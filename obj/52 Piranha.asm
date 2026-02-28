; ---------------------------------------------------------------------------
; Object 52 - Piranha badnik
; ---------------------------------------------------------------------------

Obj52:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj52_Index(pc,d0.w),d1
		jmp	Obj52_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj52_Index:	dc.w Obj52_Init-Obj52_Index
		dc.w Obj52_Main-Obj52_Index
		dc.w loc_15C48-Obj52_Index
; ---------------------------------------------------------------------------

Obj52_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj52,obMap(a0)
		move.w	#make_art_tile(ArtTile_BFish,1,0),obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#$10,obActWid(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		move.b	d0,d1
		andi.w	#$F0,d1
		add.w	d1,d1
		add.w	d1,d1
		move.w	d1,objoff_3A(a0)
		move.w	d1,objoff_3C(a0)
		andi.w	#$F,d0
		lsl.w	#6,d0
		subq.w	#1,d0
		move.w	d0,objoff_30(a0)
		move.w	d0,objoff_32(a0)
		move.w	#-$80,obVelX(a0)
		move.l	#-$48000,objoff_36(a0)
		move.w	obY(a0),objoff_34(a0)
		bset	#6,obStatus(a0)
		btst	#0,obStatus(a0)
		beq.s	Obj52_Main
		neg.w	obVelX(a0)

Obj52_Main:
		cmpi.w	#-1,objoff_3A(a0)
		beq.s	loc_15BE4
		subq.w	#1,objoff_3A(a0)

loc_15BE4:
		subq.w	#1,objoff_30(a0)
		bpl.s	loc_15C06
		move.w	objoff_32(a0),objoff_30(a0)
		neg.w	obVelX(a0)
		bchg	#0,obStatus(a0)
		move.b	#1,obPrevAni(a0)
		move.w	objoff_3C(a0),objoff_3A(a0)

loc_15C06:
		lea	(Ani_Obj52).l,a1
		bsr.w	j_AnimateSprite_1
		bsr.w	j_ObjectMove_2
		tst.w	objoff_3A(a0)
		bgt.w	loc_15D90
		cmpi.w	#-1,objoff_3A(a0)
		beq.w	loc_15D90
		move.l	#-$48000,objoff_36(a0)
		addq.b	#2,obRoutine(a0)
		move.w	#-1,objoff_3A(a0)
		move.b	#2,obAnim(a0)
		move.w	#1,objoff_3E(a0)
		bra.w	loc_15D90
; ---------------------------------------------------------------------------

loc_15C48:
		move.w	#$390,(v_waterpos1).w
		lea	(Ani_Obj52).l,a1
		bsr.w	j_AnimateSprite_1
		move.w	objoff_3E(a0),d0
		sub.w	d0,objoff_30(a0)
		bsr.w	sub_15CF8
		tst.l	objoff_36(a0)
		bpl.s	loc_15CA0
		move.w	obY(a0),d0
		cmp.w	(v_waterpos1).w,d0
		bgt.w	loc_15D90
		move.b	#3,obAnim(a0)
		bclr	#6,obStatus(a0)
		tst.b	objoff_2A(a0)
		bne.w	loc_15D90
		move.w	obVelX(a0),d0
		asl.w	#1,d0
		move.w	d0,obVelX(a0)
		addq.w	#1,objoff_3E(a0)
		st	objoff_2A(a0)
		bra.w	loc_15D90
; ---------------------------------------------------------------------------

loc_15CA0:
		move.w	obY(a0),d0
		cmp.w	(v_waterpos1).w,d0
		bgt.s	loc_15CB4
		move.b	#1,obAnim(a0)
		bra.w	loc_15D90
; ---------------------------------------------------------------------------

loc_15CB4:
		move.b	#0,obAnim(a0)
		bset	#6,obStatus(a0)
		bne.s	loc_15CCE
		move.l	objoff_36(a0),d0
		asr.l	#1,d0
		move.l	d0,objoff_36(a0)
		nop

loc_15CCE:
		move.w	objoff_34(a0),d0
		cmp.w	obY(a0),d0
		bgt.w	loc_15D90
		subq.b	#2,obRoutine(a0)
		tst.b	objoff_2A(a0)
		beq.w	loc_15D90
		move.w	obVelX(a0),d0
		asr.w	#1,d0
		move.w	d0,obVelX(a0)
		sf	objoff_2A(a0)
		bra.w	loc_15D90

; =============== S U B	R O U T	I N E =======================================


sub_15CF8:
		move.l	obX(a0),d2
		move.l	obY(a0),d3
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		add.l	objoff_36(a0),d3
		btst	#6,obStatus(a0)
		beq.s	loc_15D34
		tst.l	objoff_36(a0)
		bpl.s	loc_15D2C
		addi.l	#$1000,objoff_36(a0)
		addi.l	#$1000,objoff_36(a0)

loc_15D2C:
		subi.l	#$1000,objoff_36(a0)

loc_15D34:
		addi.l	#$1800,objoff_36(a0)
		move.l	d2,obX(a0)
		move.l	d3,obY(a0)
		rts
; End of function sub_15CF8