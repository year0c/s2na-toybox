; ===========================================================================
; ---------------------------------------------------------------------------
; Object 15 - swinging platforms
;----------------------------------------------------------------------------

Obj15:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj15_Index(pc,d0.w),d1
		jmp	Obj15_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj15_Index:	dc.w loc_821E-Obj15_Index
		dc.w loc_83AA-Obj15_Index
		dc.w loc_8526-Obj15_Index
		dc.w loc_8526-Obj15_Index
		dc.w loc_852A-Obj15_Index
		dc.w loc_83CA-Obj15_Index
; ---------------------------------------------------------------------------

loc_821E:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj15,obMap(a0)
		move.w	#make_art_tile($4D0,2,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#$18,obActWid(a0)
		move.b	#8,obHeight(a0)
		move.w	obY(a0),objoff_38(a0)
		move.w	obX(a0),objoff_3A(a0)
		cmpi.b	#3,(Current_Zone).w
		bne.s	loc_8284
		move.l	#Map_Obj15_EHZ,obMap(a0)
		move.w	#make_art_tile($3DC,2,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#$20,obActWid(a0)
		move.b	#$10,obHeight(a0)
		move.b	#$99,obColType(a0)

loc_8284:
		cmpi.b	#2,(Current_Zone).w
		bne.s	loc_82BE
		move.l	#Map_Obj15_CPZ,obMap(a0)
		move.w	#make_art_tile($418,1,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#$20,obActWid(a0)
		move.b	#$10,obHeight(a0)
		lea	obSubtype(a0),a2
		move.b	(a2),d0
		lsl.w	#4,d0
		move.b	d0,objoff_3C(a0)
		move.b	#0,(a2)+
		bra.w	loc_8388
; ---------------------------------------------------------------------------

loc_82BE:
		_move.b	obID(a0),d4
		moveq	#0,d1
		lea	obSubtype(a0),a2
		move.b	(a2),d1
		move.w	d1,-(sp)
		andi.w	#$F,d1
		move.b	#0,(a2)+
		move.w	d1,d3
		lsl.w	#4,d3
		addi.b	#8,d3
		move.b	d3,objoff_3C(a0)
		subi.b	#8,d3
		tst.b	obFrame(a0)
		beq.s	loc_82F0
		addi.b	#8,d3
		subq.w	#1,d1

loc_82F0:
		bsr.w	FindNextFreeObj
		bne.s	loc_835C
		addq.b	#1,obSubtype(a0)
		move.w	a1,d5
		subi.w	#v_objspace,d5
		lsr.w	#object_size_bits,d5
		andi.w	#$7F,d5
		move.b	d5,(a2)+
		move.b	#8,obRoutine(a1)
		_move.b	d4,obID(a1)
		move.l	obMap(a0),obMap(a1)
		move.w	obGfx(a0),obGfx(a1)
		bclr	#6,obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#4,obPriority(a1)
		move.b	#8,obActWid(a1)
		move.b	#1,obFrame(a1)
		move.b	d3,objoff_3C(a1)
		subi.b	#$10,d3
		bcc.s	loc_8358
		move.b	#2,obFrame(a1)
		move.b	#3,obPriority(a1)
		bset	#6,obGfx(a1)

loc_8358:
		dbf	d1,loc_82F0

loc_835C:
		move.w	(sp)+,d1
		btst	#4,d1
		beq.s	loc_8388
		move.l	#Map_Obj48,obMap(a0)
		move.w	#make_art_tile($3AA,2,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#1,obFrame(a0)
		move.b	#2,obPriority(a0)
		move.b	#$81,obColType(a0)

loc_8388:
		move.w	a0,d5
		subi.w	#v_objspace,d5
		lsr.w	#object_size_bits,d5
		andi.w	#$7F,d5
		move.b	d5,(a2)+
		move.w	#$4080,obAngle(a0)
		move.w	#-$200,objoff_3E(a0)
		cmpi.b	#5,(Current_Zone).w
		beq.s	loc_83CA

loc_83AA:
		move.w	obX(a0),-(sp)
		bsr.w	sub_83D2
		moveq	#0,d1
		move.b	obActWid(a0),d1
		moveq	#0,d3
		move.b	obHeight(a0),d3
		addq.b	#1,d3
		move.w	(sp)+,d4
		bsr.w	sub_F82E
		bra.w	loc_84EE
; ---------------------------------------------------------------------------

loc_83CA:
		bsr.w	sub_83D2
		bra.w	loc_84EE

; =============== S U B	R O U T	I N E =======================================


sub_83D2:
		move.b	(v_oscillate+$1A).w,d0
		move.w	#$80,d1
		btst	#0,obStatus(a0)
		beq.s	loc_83E6
		neg.w	d0
		add.w	d1,d0

loc_83E6:
		bra.w	loc_8472
; ---------------------------------------------------------------------------

Obj48_Move:
		tst.b	objoff_3D(a0)
		bne.s	loc_840E
		move.w	objoff_3E(a0),d0
		addi.w	#8,d0
		move.w	d0,objoff_3E(a0)
		add.w	d0,obAngle(a0)
		cmpi.w	#$200,d0
		bne.s	loc_842A
		move.b	#1,objoff_3D(a0)
		bra.s	loc_842A
; ---------------------------------------------------------------------------

loc_840E:
		move.w	objoff_3E(a0),d0
		subi.w	#8,d0
		move.w	d0,objoff_3E(a0)
		add.w	d0,obAngle(a0)
		cmpi.w	#-$200,d0
		bne.s	loc_842A
		move.b	#0,objoff_3D(a0)

loc_842A:
		move.b	obAngle(a0),d0

Swing_Move2:
		bsr.w	CalcSine
		move.w	objoff_38(a0),d2
		move.w	objoff_3A(a0),d3
		lea	obSubtype(a0),a2
		moveq	#0,d6
		move.b	(a2)+,d6

loc_8442:
		moveq	#0,d4
		move.b	(a2)+,d4
		lsl.w	#object_size_bits,d4
		addi.l	#v_objspace,d4
		movea.l	d4,a1
		moveq	#0,d4
		move.b	objoff_3C(a1),d4
		move.l	d4,d5
		muls.w	d0,d4
		asr.l	#8,d4
		muls.w	d1,d5
		asr.l	#8,d5
		add.w	d2,d4
		add.w	d3,d5
		move.w	d4,obY(a1)
		move.w	d5,obX(a1)
		dbf	d6,loc_8442
		rts
; ---------------------------------------------------------------------------

loc_8472:
		bsr.w	CalcSine
		move.w	objoff_38(a0),d2
		move.w	objoff_3A(a0),d3
		moveq	#0,d4
		move.b	objoff_3C(a0),d4
		move.l	d4,d5
		muls.w	d0,d4
		asr.l	#8,d4
		muls.w	d1,d5
		asr.l	#8,d5
		add.w	d2,d4
		add.w	d3,d5
		move.w	d4,obY(a0)
		move.w	d5,obX(a0)
		lea	obSubtype(a0),a2
		moveq	#0,d6
		move.b	(a2)+,d6
		adda.w	d6,a2
		subq.b	#1,d6
		bcs.s	locret_84EC
		move.w	d6,-(sp)
		asl.w	#4,d0
		ext.l	d0
		asl.l	#8,d0
		asl.w	#4,d1
		ext.l	d1
		asl.l	#8,d1
		moveq	#0,d4
		moveq	#0,d5

loc_84BA:
		moveq	#0,d6
		move.b	-(a2),d6
		lsl.w	#object_size_bits,d6
		addi.l	#v_objspace,d6
		movea.l	d6,a1
		movem.l	d4-d5,-(sp)
		swap	d4
		swap	d5
		add.w	d2,d4
		add.w	d3,d5
		move.w	d4,obY(a1)
		move.w	d5,obX(a1)
		movem.l	(sp)+,d4-d5
		add.l	d0,d4
		add.l	d1,d5
		subq.w	#1,(sp)
		bcc.w	loc_84BA
		addq.w	#2,sp

locret_84EC:
		rts
; End of function sub_83D2

; ---------------------------------------------------------------------------

loc_84EE:
		out_of_range.w	loc_8506,$3A(a0)
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_8506:
		moveq	#0,d2
		lea	obSubtype(a0),a2
		move.b	(a2)+,d2

loc_850E:
		moveq	#0,d0
		move.b	(a2)+,d0
		lsl.w	#object_size_bits,d0
		addi.l	#v_objspace,d0
		movea.l	d0,a1
		bsr.w	DeleteObject2
		dbf	d2,loc_850E
		rts
; ---------------------------------------------------------------------------

loc_8526:
		bra.w	DeleteObject
; ---------------------------------------------------------------------------

loc_852A:
		bra.w	DisplaySprite