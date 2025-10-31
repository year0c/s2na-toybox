; ---------------------------------------------------------------------------
; Object 42 - GHZ Newtron badnik
; ---------------------------------------------------------------------------

Obj42:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj42_Index(pc,d0.w),d1
		jmp	Obj42_Index(pc,d1.w)
; ===========================================================================
Obj42_Index:	dc.w Obj42_Init-Obj42_Index
		dc.w Obj42_Main-Obj42_Index
		dc.w Obj42_Delete-Obj42_Index
; ===========================================================================
; loc_Ebhs:
Obj42_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_obj42,obMap(a0)
		move.w	#make_art_tile(ArtTile_Newtron,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#$14,obActWid(a0)
		move.b	#$10,obHeight(a0)
		move.b	#8,obWidth(a0)
; loc_EC00:
Obj42_Main
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj42_Main_Index(pc,d0.w),d1
		jsr	Obj42_Main_Index(pc,d1.w)
		lea	(Ani_obj42).l,a1
		bsr.w	AnimateSprite
		bra.w	MarkObjGone
; ===========================================================================
Obj42_Main_Index:	dc.w Obj42_ChkDistance-Obj42_Main_Index
			dc.w Obj42_Type00-Obj42_Main_Index
			dc.w Obj42_ChkFloor-Obj42_Main_Index
			dc.w Obj42_Move-Obj42_Main_Index
			dc.w Obj42_Type02-Obj42_Main_Index
; ===========================================================================
; loc_EC26:
Obj42_ChkDistance:
		bset	#0,obStatus(a0)
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bhs.s	loc_EC3E
		neg.w	d0
		bclr	#0,obStatus(a0)

loc_EC3E:
		cmpi.w	#$80,d0
		bhs.s	locret_EC6A
		addq.b	#2,ob2ndRout(a0)
		move.b	#1,obAnim(a0)
		tst.b	obSubtype(a0)
		beq.s	locret_EC6A
		move.w	#make_art_tile(ArtTile_Newtron,1,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#8,ob2ndRout(a0)
		move.b	#4,obAnim(a0)

locret_EC6A:
		rts
; ===========================================================================
; Blue Newtron that appears before chasing Sonic/Tails
; loc_EC6C:
Obj42_Type00:
		cmpi.b	#4,obFrame(a0)
		bhs.s	Obj42_Fall
		bset	#0,obStatus(a0)
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bhs.s	locret_EC8A
		bclr	#0,obStatus(a0)

locret_EC8A:
		rts
; ---------------------------------------------------------------------------
; loc_EC8C:
Obj42_Fall:
		cmpi.b	#1,obFrame(a0)
		bne.s	loc_EC9A
		move.b	#$C,obColType(a0)

loc_EC9A:
		bsr.w	ObjectMoveAndFall
		bsr.w	ObjHitFloor
		tst.w	d1
		bpl.s	locret_ECDE
		add.w	d1,obY(a0)
		move.w	#0,obVelY(a0)
		addq.b	#2,ob2ndRout(a0)
		move.b	#2,obAnim(a0)
		btst	#5,obGfx(a0)
		beq.s	loc_ECC6
		addq.b	#1,obAnim(a0)

loc_ECC6:
		move.b	#$D,obColType(a0)
		move.w	#$200,obVelX(a0)
		btst	#0,obStatus(a0)
		bne.s	locret_ECDE
		neg.w	obVelX(a0)

locret_ECDE:
		rts
; ===========================================================================
; loc_ECE0:
Obj42_ChkFloor:
		bsr.w	ObjectMove
		bsr.w	ObjHitFloor
		cmpi.w	#-8,d1
		blt.s	loc_ECFA
		cmpi.w	#$C,d1
		bge.s	loc_ECFA
		add.w	d1,obY(a0)
		rts
; ---------------------------------------------------------------------------

loc_ECFA:
		addq.b	#2,ob2ndRout(a0)
		rts
; ===========================================================================
; loc_ED00:
Obj42_Move:
		bsr.w	ObjectMove
		rts
; ===========================================================================
; Green Newtron that fires a missile
; loc_ED06:
Obj42_Type02:
		cmpi.b	#1,obFrame(a0)
		bne.s	Obj42_FireMissile
		move.b	#$C,obColType(a0)
; loc_ED14:
Obj42_FireMissile:
		cmpi.b	#2,obFrame(a0)
		bne.s	locret_ED6C
		tst.b	objoff_32(a0)
		bne.s	locret_ED6C
		move.b	#1,objoff_32(a0)
		bsr.w	FindFreeObj
		bne.s	locret_ED6C
		_move.b	#id_Obj23,obID(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		subq.w	#8,obY(a1)
		move.w	#$200,obVelX(a1)
		move.w	#20,d0
		btst	#0,obStatus(a0)
		bne.s	loc_ED5C
		neg.w	d0
		neg.w	obVelX(a1)

loc_ED5C:
		add.w	d0,obX(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	#1,obSubtype(a1)

locret_ED6C:
		rts
; ===========================================================================
; loc_ED6E:
Obj42_Delete:
		bra.w	DeleteObject