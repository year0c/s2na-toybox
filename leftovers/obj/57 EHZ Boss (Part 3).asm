; ---------------------------------------------------------------------------
; Object 57 - sub object of the	EHZ boss
; ---------------------------------------------------------------------------

Obj57_PB:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	.off_17892(pc,d0.w),d1
		jmp	.off_17892(pc,d1.w)
; ---------------------------------------------------------------------------
.off_17892:	dc.w .loc_1789E-.off_17892
		dc.w .loc_178C4-.off_17892
		dc.w .loc_17920-.off_17892
		dc.w .loc_17952-.off_17892
		dc.w .loc_1797C-.off_17892
		dc.w .loc_17996-.off_17892
; ---------------------------------------------------------------------------

.loc_1789E:
		move.b	#0,obColType(a0)
		cmpi.w	#$29B0,obX(a0)
		ble.s	.loc_178B6
		subi.w	#1,obX(a0)
		bra.w	$16890+$8D4	;	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

.loc_178B6:
		move.w	#$29B0,obX(a0)
		addq.b	#2,ob2ndRout(a0)
		bra.w	$16890+$8D4	;	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

.loc_178C4:
		moveq	#0,d0
		move.b	objoff_2C(a0),d0
		move.w	.off_178D2(pc,d0.w),d1
		jmp	.off_178D2(pc,d1.w)
; ---------------------------------------------------------------------------
.off_178D2:	dc.w .loc_178D6-.off_178D2
		dc.w .loc_178FC-.off_178D2
; ---------------------------------------------------------------------------

.loc_178D6:
		cmpi.w	#$3DE,obY(a0)
		bge.s	.loc_178E8
		addi.w	#1,obY(a0)
		bra.w	$16890+$8D4	;	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

.loc_178E8:
		addq.b	#2,objoff_2C(a0)
		bset	#0,objoff_2D(a0)
		move.w	#$3C,objoff_2A(a0)
		bra.w	$16890+$8D4	;	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

.loc_178FC:
		subi.w	#1,objoff_2A(a0)
		bpl.w	$16890+$8D4	;	JmpTo7_DisplaySprite
		move.w	#-$200,obVelX(a0)
		addq.b	#2,ob2ndRout(a0)
		move.b	#$F,obColType(a0)
		bset	#1,objoff_2D(a0)
		bra.w	$16890+$8D4	;	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

.loc_17920:
		bsr.w	.sub_17A8C
		bsr.w	.sub_17A6A
		move.l	obX(a0),d1
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		move.l	d1,obX(a0)
		move.b	(Vint_runcount+3).w,d0
		andi.b	#$F,d0
		bne.w	$16890+$8D4	;	JmpTo7_DisplaySprite
		bsr.w	$16890+$8F2	;	JmpTo_RandomNumber
		andi.w	#3,d0
		move.b	.tbl(pc,d0.w),d0
		ext.w	d0
		add.w	objoff_38(a0),d0
		move.w	d0,obY(a0)
		bra.w	$16890+$8D4	;	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------
.tbl:	dc.w $FF02
		dc.w $FE01
; ---------------------------------------------------------------------------

.loc_17952:
		subq.w	#1,objoff_3C(a0)
		bpl.w	BossDefeated_PB
		bset	#0,obStatus(a0)
		bclr	#7,obStatus(a0)
		clr.w	obVelX(a0)
		addq.b	#2,ob2ndRout(a0)
		move.w	#-$26,objoff_3C(a0)
		move.w	#$C,objoff_2A(a0)
		tst.b	(Boss_defeated_flag).w
		bne.s	.end
		move.b	#1,(Boss_defeated_flag).w

.end:
		rts
; ---------------------------------------------------------------------------

.loc_1797C:
		addq.w	#1,obY(a0)
		subq.w	#1,objoff_2A(a0)
		bpl.w	$16890+$8D4	;	JmpTo7_DisplaySprite
		addq.b	#2,ob2ndRout(a0)
		move.b	#0,objoff_2C(a0)
		bra.w	$16890+$8D4	;	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

.loc_17996:
		moveq	#0,d0
		move.b	objoff_2C(a0),d0
		move.w	.off_179A8(pc,d0.w),d1
		jsr	.off_179A8(pc,d1.w)
		bra.w	$16890+$8D4	;	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------
.off_179A8:	dc.w .loc_179AE-.off_179A8
		dc.w .loc_17A22-.off_179A8
		dc.w .loc_17A3C-.off_179A8
; ---------------------------------------------------------------------------

.loc_179AE:
		bclr	#0,objoff_2D(a0)
		bsr.w	$16890+$8E6	;	JmpTo3_FindNextFreeObj
		bne.w	$16890+$8D4	;	JmpTo7_DisplaySprite
		_move.b	#id_Obj58,obID(a1)
		move.l	a0,objoff_34(a1)
		move.l	#Map_Obj58_PB,obMap(a1)
		move.w	#make_art_tile(ArtTile_ArtNem_EggChoppers,1,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#32,obActWid(a1)
		move.b	#4,obPriority(a1)
		move.l	obX(a0),obX(a1)
		move.l	obY(a0),obY(a1)
		addi.w	#$C,obY(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	obRender(a0),obRender(a1)
		move.b	#8,obRoutine(a1)
		move.b	#2,obAnim(a1)
		move.w	#$10,objoff_2A(a1)
		move.w	#$32,objoff_2A(a0)
		addq.b	#2,objoff_2C(a0)
		rts
; ---------------------------------------------------------------------------

.loc_17A22:
		subi.w	#1,objoff_2A(a0)
		bpl.s	.locret_17A3A
		bset	#2,objoff_2D(a0)
		move.w	#$30,objoff_2A(a0)
		addq.b	#2,objoff_2C(a0)

.locret_17A3A:
		rts
; ---------------------------------------------------------------------------

.loc_17A3C:
		subq.w	#1,obY(a0)
		subi.w	#1,objoff_2A(a0)
		bpl.s	.locret_17A68
		addq.w	#1,obY(a0)
		addq.w	#2,obX(a0)

.locret_17A68:
		rts

; =============== S U B	R O U T	I N E =======================================


.sub_17A6A:
		move.w	obX(a0),d0
		cmpi.w	#$2780,d0
		ble.s	.loc_17A7A
		cmpi.w	#$2A08,d0
		blt.s	.locret_17A8A

.loc_17A7A:
		bchg	#0,obStatus(a0)
		bchg	#0,obRender(a0)
		neg.w	obVelX(a0)

.locret_17A8A:
		rts
; End of function sub_17A6A


; =============== S U B	R O U T	I N E =======================================


.sub_17A8C:
		cmpi.b	#6,ob2ndRout(a0)
		bhs.s	.locret_17AD2
		tst.b	obStatus(a0)
		bmi.s	.loc_17AD4
		tst.b	obColType(a0)
		bne.s	.locret_17AD2
		tst.b	objoff_3E(a0)
		bne.s	.loc_17AB6
		move.b	#$20,objoff_3E(a0)
		move.w	#sfx_HitBoss,d0
		jsr	(QueueSound2_PB).l

.loc_17AB6:
		lea	(v_palette_line_2+2).w,a1
		moveq	#0,d0
		tst.w	(a1)
		bne.s	.loc_17AC4
		move.w	#cWhite,d0

.loc_17AC4:
		move.w	d0,(a1)
		subq.b	#1,objoff_3E(a0)
		bne.s	.locret_17AD2
		move.b	#$F,obColType(a0)

.locret_17AD2:
		rts
; ---------------------------------------------------------------------------

.loc_17AD4:
		moveq	#100,d0
		bsr.w	$1A248	;	AddPoints
		move.b	#6,ob2ndRout(a0)
		move.w	#180-1,objoff_3C(a0)
		bset	#3,objoff_2D(a0)
		rts
; End of function sub_17A8C