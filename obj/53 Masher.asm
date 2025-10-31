; ---------------------------------------------------------------------------
; Object 53 - Masher from EHZ
; ---------------------------------------------------------------------------

Obj53:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj53_Index(pc,d0.w),d1
		jsr	Obj53_Index(pc,d1.w)
		bra.w	loc_175B8
; ===========================================================================
Obj53_Index:	dc.w Obj53_Init-Obj53_Index
		dc.w Obj53_Main-Obj53_Index
; ===========================================================================

Obj53_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_obj53,obMap(a0)
		move.w	#make_art_tile(ArtTile_Masher,0,0),obGfx(a0)
		bsr.w	j_Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#9,obColType(a0)
		move.b	#$10,obActWid(a0)
		move.w	#-$400,obVelY(a0)
		move.w	obY(a0),objoff_30(a0)

Obj53_Main:
		lea	(Ani_obj53).l,a1
		bsr.w	j_AnimateSprite
		bsr.w	j_ObjectMove
		addi.w	#$18,obVelY(a0)
		move.w	objoff_30(a0),d0
		cmp.w	obY(a0),d0
		bcc.s	loc_17548
		move.w	d0,obY(a0)
		move.w	#-$500,obVelY(a0)

loc_17548:
		move.b	#1,obAnim(a0)
		subi.w	#$C0,d0
		cmp.w	obY(a0),d0
		bcc.s	locret_1756A
		move.b	#0,obAnim(a0)
		tst.w	obVelY(a0)
		bmi.s	locret_1756A
		move.b	#2,obAnim(a0)

locret_1756A:
		rts