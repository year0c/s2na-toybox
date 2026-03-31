; ---------------------------------------------------------------------------
; Object 53 - Masher from EHZ
; ---------------------------------------------------------------------------

Obj53_PB:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj53_PB_Index(pc,d0.w),d1
		jsr	Obj53_PB_Index(pc,d1.w)
		bra.w	$164F8+$E8	;	JmpTo7_MarkObjGone
; ===========================================================================
Obj53_PB_Index:	dc.w Obj53_PB_Init-Obj53_PB_Index
		dc.w Obj53_PB_Main-Obj53_PB_Index
; ===========================================================================

Obj53_PB_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj53_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_Masher,0,0),obGfx(a0)
		bsr.w	$164F8+$F4	;	JmpTo3_Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#9,obColType(a0)
		move.b	#16,obActWid(a0)
		move.w	#-$400,obVelY(a0)
		move.w	obY(a0),objoff_30(a0)

Obj53_PB_Main:
		lea	(Ani_Obj53_PB).l,a1
		bsr.w	$164F8+$EE	;	JmpTo9_AnimateSprite
		bsr.w	$164F8+$FA	;	JmpTo9_ObjectMove
		addi.w	#$18,obVelY(a0)
		move.w	objoff_30(a0),d0
		cmp.w	obY(a0),d0
		bhs.s	.loc_17548
		move.w	d0,obY(a0)
		move.w	#-$500,obVelY(a0)

.loc_17548:
		move.b	#1,obAnim(a0)
		subi.w	#$C0,d0
		cmp.w	obY(a0),d0
		bhs.s	.locret_1756A
		move.b	#0,obAnim(a0)
		tst.w	obVelY(a0)
		bmi.s	.locret_1756A
		move.b	#2,obAnim(a0)

.locret_1756A:
		rts