; ---------------------------------------------------------------------------
; Object 54 - Snail badnik from	EHZ
; ---------------------------------------------------------------------------

Obj54_PB:
		bra.w	$165F8+$274	;	JmpTo8_DeleteObject
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj54_PB_Index(pc,d0.w),d1
		jmp	Obj54_PB_Index(pc,d1.w)
; ===========================================================================
Obj54_PB_Index:	dc.w Obj54_PB_Init-Obj54_PB_Index
		dc.w Obj54_PB_Move-Obj54_PB_Index
		dc.w Obj54_PB_Display.loc_177B4-Obj54_PB_Index
		dc.w Obj54_PB_Display.loc_177EC-Obj54_PB_Index
		dc.w Obj54_PB_Display.loc_17772-Obj54_PB_Index
; ===========================================================================

Obj54_PB_Init:
		move.l	#Map_Obj54_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_Snail,0,0),obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#16,obActWid(a0)
		move.b	#16,obHeight(a0)
		move.b	#14,obWidth(a0)
		bsr.w	$165F8+$27A	;	JmpTo2_FindNextFreeObj
		bne.s	.loc_17670
		_move.b	#id_Obj54,obID(a1)
		move.b	#6,obRoutine(a1)
		move.l	#Map_Obj54_PB,obMap(a1)
		move.w	#make_art_tile(ArtTile_Snail,1,0),obGfx(a1)
		move.b	#3,obPriority(a1)
		move.b	#16,obActWid(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	obRender(a0),obRender(a1)
		move.l	a0,objoff_2A(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	#2,obFrame(a1)

.loc_17670:
		addq.b	#2,obRoutine(a0)
		move.w	#-$80,d0
		btst	#0,obStatus(a0)
		beq.s	.loc_17682
		neg.w	d0

.loc_17682:
		move.w	d0,obVelX(a0)
		rts
; ===========================================================================
; loc_17688:
Obj54_PB_Move:
		bsr.w	Obj54_PB_Display.sub_176D0
		bsr.w	$165F8+$292	;	JmpTo10_ObjectMove
		jsr	(ObjHitFloor_PB).l
		cmpi.w	#-8,d1
		blt.s	Obj54_PB_Display
		cmpi.w	#$C,d1
		bge.s	Obj54_PB_Display
		add.w	d1,obY(a0)
		lea	(Ani_Obj54_PB).l,a1
		bsr.w	$165F8+$280	;	JmpTo10_AnimateSprite
		bra.w	$165F8+$286	;	JmpTo2_MarkObjGone_P1
; ===========================================================================
; loc_176B4:
Obj54_PB_Display:
		addq.b	#2,obRoutine(a0)
		move.w	#$14,objoff_30(a0)
		st	objoff_34(a0)
		lea	(Ani_Obj54_PB).l,a1
		bsr.w	$165F8+$280	;	JmpTo10_AnimateSprite
		bra.w	$165F8+$286	;	JmpTo2_MarkObjGone_P1

; =============== S U B	R O U T	I N E =======================================


.sub_176D0:
		tst.b	objoff_35(a0)
		bne.s	.locret_17712
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		cmpi.w	#$64,d0
		bgt.s	.locret_17712
		cmpi.w	#-$64,d0
		blt.s	.locret_17712
		tst.w	d0
		bmi.s	.loc_176F8
		btst	#0,obStatus(a0)
		beq.s	.locret_17712
		bra.s	.loc_17700
; ---------------------------------------------------------------------------

.loc_176F8:
		btst	#0,obStatus(a0)
		bne.s	.locret_17712

.loc_17700:
		move.w	obVelX(a0),d0
		asl.w	#2,d0
		move.w	d0,obVelX(a0)
		st	objoff_35(a0)
		bsr.w	.sub_17714

.locret_17712:
		rts
; End of function sub_176D0


; =============== S U B	R O U T	I N E =======================================


.sub_17714:
		bsr.w	$165F8+$27A	;	JmpTo2_FindNextFreeObj
		bne.s	.locret_17770
		_move.b	#id_Obj54,obID(a1)
		move.b	#8,obRoutine(a1)
		move.l	#Map_Obj4B_PB,obMap(a1)
		move.w	#make_art_tile(ArtTile_Buzzer,0,0),obGfx(a1)
		move.b	#4,obPriority(a1)
		move.b	#16,obActWid(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	obRender(a0),obRender(a1)
		move.l	a0,objoff_2A(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		addq.w	#7,obY(a1)
		addi.w	#$D,obX(a1)
		move.b	#1,obAnim(a1)

.locret_17770:
		rts
; End of function sub_17714

; ---------------------------------------------------------------------------

.loc_17772:
		movea.l	objoff_2A(a0),a1
		tst.b	objoff_34(a1)
		bne.w	$165F8+$274	;	JmpTo8_DeleteObject
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		addq.w	#7,obY(a0)
		moveq	#$D,d0
		btst	#0,obStatus(a0)
		beq.s	.loc_177A2
		neg.w	d0

.loc_177A2:
		add.w	d0,obX(a0)
		lea	(Ani_Obj4B_PB).l,a1
		bsr.w	$165F8+$280	;	JmpTo10_AnimateSprite
		bra.w	$165F8+$286	;	JmpTo2_MarkObjGone_P1
; ---------------------------------------------------------------------------

.loc_177B4:
		subi.w	#1,objoff_30(a0)
		bpl.w	$165F8+$286	;	JmpTo2_MarkObjGone_P1
		neg.w	obVelX(a0)
		bsr.w	$165F8+$28C	;	JmpTo7_ObjectMoveAndFall
		move.w	obVelX(a0),d0
		asr.w	#2,d0
		move.w	d0,obVelX(a0)
		bchg	#0,obStatus(a0)
		bchg	#0,obRender(a0)
		subq.b	#2,obRoutine(a0)
		sf	objoff_34(a0)
		sf	objoff_35(a0)
		bra.w	$165F8+$286	;	JmpTo2_MarkObjGone_P1
; ---------------------------------------------------------------------------

.loc_177EC:
		movea.l	objoff_2A(a0),a1
		cmpi.b	#id_Obj54,obID(a1)
		bne.w	$165F8+$274	;	JmpTo8_DeleteObject
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		move.b	obStatus(a1),obStatus(a0)
		move.b	obRender(a1),obRender(a0)
		bra.w	$165F8+$286	;	JmpTo2_MarkObjGone_P1