; ---------------------------------------------------------------------------
; Object 40 - GHZ Motobug
; ---------------------------------------------------------------------------

Obj40:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj40_Index(pc,d0.w),d1
		jmp	Obj40_Index(pc,d1.w)
; ===========================================================================
; off_F256:
Obj40_Index:	dc.w Obj40_Init-Obj40_Index
		dc.w Obj40_Main-Obj40_Index
		dc.w Obj40_Animate-Obj40_Index
		dc.w Obj40_Delete-Obj40_Index
; ===========================================================================
; loc_F25E:
Obj40_Init:
		move.l	#Map_obj40,obMap(a0)
		move.w	#make_art_tile($4E0,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#$14,obActWid(a0)
		tst.b	obAnim(a0)
		bne.s	Obj40_Smoke
		move.b	#$E,obHeight(a0)
		move.b	#8,obWidth(a0)
		move.b	#$C,obColType(a0)
		bsr.w	ObjectMoveAndFall
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	locret_F2BC
		add.w	d1,obY(a0)
		move.w	#0,obVelY(a0)
		addq.b	#2,obRoutine(a0)
		bchg	#0,obStatus(a0)

locret_F2BC:
		rts
; ===========================================================================
; loc_F2BE:
Obj40_Smoke:
		addq.b	#4,obRoutine(a0)
		bra.w	Obj40_Animate
; ===========================================================================
; loc_F2C6:
Obj40_Main:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj40_Main_Index(pc,d0.w),d1
		jsr	Obj40_Main_Index(pc,d1.w)
		lea	(Ani_obj40).l,a1
		bsr.w	AnimateSprite
		bra.w	MarkObjGone
; ===========================================================================
; off_F2E2
Obj40_Main_Index:	dc.w Obj40_Move-Obj40_Main_Index
			dc.w Obj40_Floor-Obj40_Main_Index
; ===========================================================================
; loc_F2E6:
Obj40_Move:
		subq.w	#1,objoff_30(a0)
		bpl.s	locret_F308
		addq.b	#2,ob2ndRout(a0)
		move.w	#-$100,obVelX(a0)
		move.b	#1,obAnim(a0)
		bchg	#0,obStatus(a0)
		bne.s	locret_F308
		neg.w	obVelX(a0)

locret_F308:
		rts
; ===========================================================================
; loc_F30A:
Obj40_Floor:
		bsr.w	ObjectMove
		jsr	(ObjHitFloor).l
		cmpi.w	#-8,d1
		blt.s	Obj40_StopMoving
		cmpi.w	#$C,d1
		bge.s	Obj40_StopMoving
		add.w	d1,obY(a0)
		subq.b	#1,objoff_33(a0)
		bpl.s	locret_F354
		move.b	#15,objoff_33(a0)
		bsr.w	FindFreeObj
		bne.s	locret_F354
		_move.b	#id_Obj40,obID(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	#2,obAnim(a1)

locret_F354:
		rts
; ---------------------------------------------------------------------------
; loc_F356:
Obj40_StopMoving:
		subq.b	#2,ob2ndRout(a0)
		move.w	#59,objoff_30(a0)
		move.w	#0,obVelX(a0)
		move.b	#0,obAnim(a0)
		rts
; ===========================================================================
; loc_F36E:
Obj40_Animate:
		lea	(Ani_obj40).l,a1
		bsr.w	AnimateSprite
		bra.w	DisplaySprite
; ===========================================================================
; loc_F37C:
Obj40_Delete:
		bra.w	DeleteObject