; ===========================================================================
; ---------------------------------------------------------------------------
; Object 22 - Buzz Bomber from GHZ
; ---------------------------------------------------------------------------
; OST:
obj22_time:	equ objoff_32					; time to wait for performing an action
obj22_status:	equ objoff_34					; 0 = still, 1 = flying, 2 = shooting
obj22_parent:	equ objoff_3C
; ---------------------------------------------------------------------------

Obj22:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj22_Index(pc,d0.w),d1
		jmp	Obj22_Index(pc,d1.w)
; ===========================================================================
Obj22_Index:	dc.w Obj22_Init-Obj22_Index
		dc.w Obj22_Main-Obj22_Index
		dc.w Obj22_Delete-Obj22_Index
; ===========================================================================
; loc_A41C:
Obj22_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_obj22,obMap(a0)
		move.w	#make_art_tile(ArtTile_Buzz_Bomber,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#8,obColType(a0)
		move.b	#$18,obActWid(a0)
; loc_A44A:
Obj22_Main:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj22_Main_Index(pc,d0.w),d1
		jsr	Obj22_Main_Index(pc,d1.w)
		lea	(Ani_obj22).l,a1
		bsr.w	AnimateSprite
		bra.w	MarkObjGone
; ===========================================================================
Obj22_Main_Index:	dc.w Obj22_Move-Obj22_Main_Index
			dc.w Obj22_NearSonic-Obj22_Main_Index
; ===========================================================================
; loc_A46A:
Obj22_Move:
		subq.w	#1,obj22_time(a0)
		bpl.s	locret_A49A
		btst	#1,obj22_status(a0)
		bne.s	Obj22_LoadMissile
		addq.b	#2,ob2ndRout(a0)
		move.w	#128-1,obj22_time(a0)
		move.w	#$400,obVelX(a0)
		move.b	#1,obAnim(a0)
		btst	#0,obStatus(a0)
		bne.s	locret_A49A
		neg.w	obVelX(a0)

locret_A49A:
		rts
; ===========================================================================
; loc_A49C:
Obj22_LoadMissile:
		bsr.w	FindFreeObj
		bne.s	locret_A4FE
		_move.b	#id_Obj23,obID(a1)			; load Obj23 (Buzz Bomber/Newtron missile)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		addi.w	#$1C,obY(a1)
		move.w	#$200,obVelY(a1)
		move.w	#$200,obVelX(a1)
		move.w	#$18,d0
		btst	#0,obStatus(a0)
		bne.s	loc_A4D8
		neg.w	d0
		neg.w	obVelX(a1)

loc_A4D8:
		add.w	d0,obX(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.w	#15-1,obj22_time(a1)
		move.l	a0,obj22_parent(a1)
		move.b	#1,obj22_status(a0)
		move.w	#60-1,obj22_time(a0)
		move.b	#2,obAnim(a0)

locret_A4FE:
		rts
; ===========================================================================
; loc_A500:
Obj22_NearSonic:
		subq.w	#1,obj22_time(a0)
		bmi.s	loc_A536
		bsr.w	ObjectMove
		tst.b	obj22_status(a0)
		bne.s	locret_A558
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bpl.s	loc_A51C
		neg.w	d0

loc_A51C:
		cmpi.w	#$60,d0				; is Buzz Bomber within $60 pixels of Sonic?
		bcc.s	locret_A558			; if not, branch
		tst.b	obRender(a0)
		bpl.s	locret_A558
		move.b	#2,obj22_status(a0)
		move.w	#29,obj22_time(a0)
		bra.s	loc_A548
; ===========================================================================

loc_A536:
		move.b	#0,obj22_status(a0)
		bchg	#0,obStatus(a0)
		move.w	#59,obj22_time(a0)

loc_A548:
		subq.b	#2,ob2ndRout(a0)
		move.w	#0,obVelX(a0)
		move.b	#0,obAnim(a0)

locret_A558:
		rts
; ===========================================================================
; loc_A55A:
Obj22_Delete:
		bra.w	DeleteObject