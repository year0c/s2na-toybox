; ---------------------------------------------------------------------------
; Object 51 - Aquis badnik from HPZ
; ---------------------------------------------------------------------------

Obj51_PB:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	.off_16532(pc,d0.w),d1
		jmp	.off_16532(pc,d1.w)
; ---------------------------------------------------------------------------
.off_16532:	dc.w .loc_1653E-.off_16532
		dc.w .loc_1659C-.off_16532
		dc.w .loc_165C0-.off_16532
		dc.w 0
		dc.w Obj50_PB_Routine08-.off_16532
		dc.w Obj50_PB_Routine0A-.off_16532
; ---------------------------------------------------------------------------

.loc_1653E:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj50_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_Aquis,1,0),obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#16,obActWid(a0)
		move.b	#6,obAnim(a0)
		move.b	obSubtype(a0),d0
		andi.w	#$F,d0
		move.w	d0,d1
		lsl.w	#5,d1
		subq.w	#1,d1
		move.w	d1,objoff_32(a0)
		move.w	d1,objoff_34(a0)
		move.w	obY(a0),objoff_2A(a0)
		move.w	obY(a0),objoff_2E(a0)
		addi.w	#$60,objoff_2E(a0)
		move.w	#-$100,obVelX(a0)

.loc_1659C:
		lea	Ani_Obj50_PB(pc),a1
		bsr.w	$14F5C+$872	;	JmpTo4_AnimateSprite
		move.w	#$39C,(v_waterpos1).w
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	.off_165BC(pc,d0.w),d1
		jsr	.off_165BC(pc,d1.w)
		bra.w	$14F5C+$86C	;	JmpTo3_MarkObjGone
; ---------------------------------------------------------------------------
.off_165BC:	dc.w .loc_165D4-.off_165BC
		dc.w .loc_165EA-.off_165BC
; ---------------------------------------------------------------------------

.loc_165C0:
		bsr.w	Obj50_PB_Routine0A.loc_162FC
		bsr.w	$14F5C+$87E	;	JmpTo5_ObjectMove
		lea	Ani_Obj50_PB(pc),a1
		bsr.w	$14F5C+$872	;	JmpTo4_AnimateSprite
		bra.w	$14F5C+$86C	;	JmpTo3_MarkObjGone
; ---------------------------------------------------------------------------

.loc_165D4:
		bsr.w	$14F5C+$87E	;	JmpTo5_ObjectMove
		bsr.w	Obj50_PB_Routine0A.sub_162DE
		bsr.w	.loc_16626
		bsr.w	.loc_16708
		bsr.w	.loc_16678
		rts
; ---------------------------------------------------------------------------

.loc_165EA:
		bsr.w	$14F5C+$87E	;	JmpTo5_ObjectMove
		bsr.w	Obj50_PB_Routine0A.sub_162DE
		bsr.w	.loc_16626
		bsr.w	.loc_16708
		bsr.w	.loc_16600
		rts
; ---------------------------------------------------------------------------

.loc_16600:
		subq.w	#1,objoff_30(a0)
		beq.s	.loc_16614
		move.w	objoff_30(a0),d0
		cmpi.w	#$12,d0
		beq.w	.loc_1669E
		rts
; ---------------------------------------------------------------------------

.loc_16614:
		subq.b	#2,ob2ndRout(a0)
		move.b	#6,obAnim(a0)
		move.w	#180,objoff_30(a0)
		rts
; ---------------------------------------------------------------------------

.loc_16626:
		sf	objoff_2D(a0)
		sf	objoff_2C(a0)
		sf	objoff_36(a0)
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		bpl.s	.loc_16646
		btst	#0,obStatus(a0)
		bne.s	.loc_1664E
		bra.s	.loc_16652
; ---------------------------------------------------------------------------

.loc_16646:
		btst	#0,obStatus(a0)
		bne.s	.loc_16652

.loc_1664E:
		st	objoff_2C(a0)

.loc_16652:
		move.w	(v_player+obY).w,d0
		sub.w	obY(a0),d0
		cmpi.w	#-4,d0
		blt.s	.locret_16676
		cmpi.w	#4,d0
		bgt.s	.loc_16672
		st	objoff_2D(a0)
		move.w	#0,obVelY(a0)
		rts
; ---------------------------------------------------------------------------

.loc_16672:
		st	objoff_36(a0)

.locret_16676:
		rts
; ---------------------------------------------------------------------------

.loc_16678:
		tst.b	objoff_2C(a0)
		bne.s	.locret_1669C
		subq.w	#1,objoff_30(a0)
		bgt.s	.locret_1669C
		tst.b	objoff_2D(a0)
		beq.s	.locret_1669C
		move.b	#7,obAnim(a0)
		move.w	#$24,objoff_30(a0)
		addi.b	#2,ob2ndRout(a0)

.locret_1669C:
		rts
; ---------------------------------------------------------------------------

.loc_1669E:
		bsr.w	$DAA2	;	FindFreeObj
		bne.s	.locret_16706
		_move.b	#id_Obj51,obID(a1)
		move.b	#4,obRoutine(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.l	#Map_Obj50_PB,obMap(a1)
		move.w	#make_art_tile(ArtTile_Aquis_Child,1,0),obGfx(a1)
		ori.b	#4,obRender(a1)
		move.b	#3,obPriority(a1)
		move.b	#2,obAnim(a1)
		move.b	#$E5,obColType(a1)
		move.w	#$C,d0
		move.w	#$10,d1
		move.w	#-$300,d2
		btst	#0,obStatus(a0)
		beq.s	.loc_166FA
		neg.w	d1
		neg.w	d2

.loc_166FA:
		sub.w	d0,obY(a1)
		sub.w	d1,obX(a1)
		move.w	d2,obVelX(a1)

.locret_16706:
		rts
; ---------------------------------------------------------------------------

.loc_16708:
		tst.b	objoff_2D(a0)
		bne.s	.locret_16766
		tst.b	objoff_36(a0)
		beq.s	.loc_16738
		move.w	objoff_2E(a0),d0
		cmp.w	obY(a0),d0
		ble.s	.loc_1675C
		tst.b	objoff_2C(a0)
		beq.s	.loc_16730
		move.w	objoff_2A(a0),d0
		cmp.w	obY(a0),d0
		bge.s	.loc_1675C
		rts
; ---------------------------------------------------------------------------

.loc_16730:
		move.w	#$180,obVelY(a0)
		rts
; ---------------------------------------------------------------------------

.loc_16738:
		move.w	objoff_2A(a0),d0
		cmp.w	obY(a0),d0
		bge.s	.loc_1675C
		tst.b	objoff_2C(a0)
		beq.s	.loc_16754
		move.w	objoff_2E(a0),d0
		cmp.w	obY(a0),d0
		ble.s	.loc_1675C
		rts
; ---------------------------------------------------------------------------

.loc_16754:
		move.w	#-$180,obVelY(a0)
		rts
; ---------------------------------------------------------------------------

.loc_1675C:
		move.w	d0,obY(a0)
		move.w	#0,obVelY(a0)

.locret_16766:
		rts