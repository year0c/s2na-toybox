;----------------------------------------------------
; Object 28 - animals
;----------------------------------------------------

Obj28:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	off_9AB6(pc,d0.w),d1
		jmp	off_9AB6(pc,d1.w)
; ---------------------------------------------------------------------------
off_9AB6:	dc.w loc_9B92-off_9AB6,loc_9CB8-off_9AB6,loc_9D12-off_9AB6
		dc.w loc_9D4E-off_9AB6,loc_9D12-off_9AB6,loc_9D12-off_9AB6
		dc.w loc_9D12-off_9AB6,loc_9D4E-off_9AB6,loc_9D12-off_9AB6
		dc.w loc_9DCE-off_9AB6,loc_9DEE-off_9AB6,loc_9DEE-off_9AB6
		dc.w loc_9E0E-off_9AB6,loc_9E48-off_9AB6,loc_9EA2-off_9AB6
		dc.w loc_9EC0-off_9AB6,loc_9EA2-off_9AB6,loc_9EC0-off_9AB6
		dc.w loc_9EA2-off_9AB6,loc_9EFE-off_9AB6,loc_9E64-off_9AB6
byte_9AE0:	dc.b   0,  5,  2,  3,  6,  3,  4,  5,  4,  1,  0,  1
word_9AEC:	dc.w -$200
		dc.w -$400
		dc.l Map_Obj28a
		dc.w -$200
		dc.w -$300
		dc.l Map_Obj28
		dc.w $FE80
		dc.w -$300
		dc.l Map_Obj28a
		dc.w $FEC0
		dc.w $FE80
		dc.l Map_Obj28
		dc.w $FE40
		dc.w -$300
		dc.l Map_Obj28b
		dc.w -$300
		dc.w -$400
		dc.l Map_Obj28
		dc.w $FD80
		dc.w $FC80
		dc.l Map_Obj28b
word_9B24:	dc.w $FBC0,$FC00,$FBC0,$FC00
		dc.w $FBC0,$FC00,$FD00,$FC00
		dc.w $FD00,$FC00,$FE80,$FD00
		dc.w $FE80,$FD00,$FEC0,$FE80
		dc.w $FE40,$FD00,$FE00,$FD00
		dc.w $FD80,$FC80
off_9B50:	dc.l Map_Obj28,Map_Obj28
		dc.l Map_Obj28,Map_Obj28a
		dc.l Map_Obj28a,Map_Obj28a
		dc.l Map_Obj28a,Map_Obj28
		dc.l Map_Obj28b,Map_Obj28
		dc.l Map_Obj28b
word_9B7C:
		dc.w make_art_tile($5A5,0,0)
		dc.w make_art_tile($5A5,0,0)
		dc.w make_art_tile($5A5,0,0)
		dc.w make_art_tile($553,0,0)
		dc.w make_art_tile($553,0,0)
		dc.w make_art_tile($573,0,0)
		dc.w make_art_tile($573,0,0)
		dc.w make_art_tile($585,0,0)
		dc.w make_art_tile($593,0,0)
		dc.w make_art_tile($565,0,0)
		dc.w make_art_tile($5B3,0,0)
; ---------------------------------------------------------------------------

loc_9B92:
		tst.b	obSubtype(a0)
		beq.w	loc_9C00
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		add.w	d0,d0
		move.b	d0,obRoutine(a0)
		subi.w	#$14,d0
		move.w	word_9B7C(pc,d0.w),obGfx(a0)
		add.w	d0,d0
		move.l	off_9B50(pc,d0.w),obMap(a0)
		lea	word_9B24(pc),a1
		move.w	(a1,d0.w),objoff_32(a0)
		move.w	(a1,d0.w),obVelX(a0)
		move.w	2(a1,d0.w),objoff_34(a0)
		move.w	2(a1,d0.w),obVelY(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#$C,obHeight(a0)
		move.b	#4,obRender(a0)
		bset	#0,obRender(a0)
		move.b	#6,obPriority(a0)
		move.b	#8,obActWid(a0)
		move.b	#7,obTimeFrame(a0)
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_9C00:
		addq.b	#2,obRoutine(a0)
		bsr.w	RandomNumber
		andi.w	#1,d0
		moveq	#0,d1
		move.b	(Current_Zone).w,d1
		add.w	d1,d1
		add.w	d0,d1
		lea	byte_9AE0(pc),a1
		move.b	(a1,d1.w),d0
		move.b	d0,objoff_30(a0)
		lsl.w	#3,d0
		lea	word_9AEC(pc),a1
		adda.w	d0,a1
		move.w	(a1)+,objoff_32(a0)
		move.w	(a1)+,objoff_34(a0)
		move.l	(a1)+,obMap(a0)
		move.w	#make_art_tile($580,0,0),obGfx(a0)
		btst	#0,objoff_30(a0)
		beq.s	loc_9C4A
		move.w	#make_art_tile($592,0,0),obGfx(a0)

loc_9C4A:
		bsr.w	Adjust2PArtPointer
		move.b	#$C,obHeight(a0)
		move.b	#4,obRender(a0)
		bset	#0,obRender(a0)
		move.b	#6,obPriority(a0)
		move.b	#8,obActWid(a0)
		move.b	#7,obTimeFrame(a0)
		move.b	#2,obFrame(a0)
		move.w	#-$400,obVelY(a0)
		tst.b	(v_bossstatus).w
		bne.s	loc_9CAA
		bsr.w	FindFreeObj
		bne.s	loc_9CA6
		_move.b	#id_Obj29,obID(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	objoff_3E(a0),d0
		lsr.w	#1,d0
		move.b	d0,obFrame(a1)

loc_9CA6:
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_9CAA:
		move.b	#$12,obRoutine(a0)
		clr.w	obVelX(a0)
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_9CB8:
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		bsr.w	ObjectMoveAndFall
		tst.w	obVelY(a0)
		bmi.s	loc_9D0E
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	loc_9D0E
		add.w	d1,obY(a0)
		move.w	objoff_32(a0),obVelX(a0)
		move.w	objoff_34(a0),obVelY(a0)
		move.b	#1,obFrame(a0)
		move.b	objoff_30(a0),d0
		add.b	d0,d0
		addq.b	#4,d0
		move.b	d0,obRoutine(a0)
		tst.b	(v_bossstatus).w
		beq.s	loc_9D0E
		btst	#4,(Vint_runcount+3).w
		beq.s	loc_9D0E
		neg.w	obVelX(a0)
		bchg	#0,obRender(a0)

loc_9D0E:
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_9D12:
		bsr.w	ObjectMoveAndFall
		move.b	#1,obFrame(a0)
		tst.w	obVelY(a0)
		bmi.s	loc_9D3C
		move.b	#0,obFrame(a0)
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	loc_9D3C
		add.w	d1,obY(a0)
		move.w	objoff_34(a0),obVelY(a0)

loc_9D3C:
		tst.b	obSubtype(a0)
		bne.s	loc_9DB2
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_9D4E:
		bsr.w	ObjectMove
		addi.w	#$18,obVelY(a0)
		tst.w	obVelY(a0)
		bmi.s	loc_9D8A
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	loc_9D8A
		add.w	d1,obY(a0)
		move.w	objoff_34(a0),obVelY(a0)
		tst.b	obSubtype(a0)
		beq.s	loc_9D8A
		cmpi.b	#$A,obSubtype(a0)
		beq.s	loc_9D8A
		neg.w	obVelX(a0)
		bchg	#0,obRender(a0)

loc_9D8A:
		subq.b	#1,obTimeFrame(a0)
		bpl.s	loc_9DA0
		move.b	#1,obTimeFrame(a0)
		addq.b	#1,obFrame(a0)
		andi.b	#1,obFrame(a0)

loc_9DA0:
		tst.b	obSubtype(a0)
		bne.s	loc_9DB2
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_9DB2:
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		bcs.s	loc_9DCA
		subi.w	#$180,d0
		bpl.s	loc_9DCA
		tst.b	obRender(a0)
		bpl.w	DeleteObject

loc_9DCA:
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_9DCE:
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		subq.w	#1,objoff_36(a0)
		bne.w	loc_9DEA
		move.b	#2,obRoutine(a0)
		move.b	#3,obPriority(a0)

loc_9DEA:
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_9DEE:
		bsr.w	sub_9F92
		bcc.s	loc_9E0A
		move.w	objoff_32(a0),obVelX(a0)
		move.w	objoff_34(a0),obVelY(a0)
		move.b	#$E,obRoutine(a0)
		bra.w	loc_9D4E
; ---------------------------------------------------------------------------

loc_9E0A:
		bra.w	loc_9DB2
; ---------------------------------------------------------------------------

loc_9E0E:
		bsr.w	sub_9F92
		bpl.s	loc_9E44
		clr.w	obVelX(a0)
		clr.w	objoff_32(a0)
		bsr.w	ObjectMove
		addi.w	#$18,obVelY(a0)
		bsr.w	sub_9F52
		bsr.w	sub_9F7A
		subq.b	#1,obTimeFrame(a0)
		bpl.s	loc_9E44
		move.b	#1,obTimeFrame(a0)
		addq.b	#1,obFrame(a0)
		andi.b	#1,obFrame(a0)

loc_9E44:
		bra.w	loc_9DB2
; ---------------------------------------------------------------------------

loc_9E48:
		bsr.w	sub_9F92
		bpl.s	loc_9E9E
		move.w	objoff_32(a0),obVelX(a0)
		move.w	objoff_34(a0),obVelY(a0)
		move.b	#4,obRoutine(a0)
		bra.w	loc_9D12
; ---------------------------------------------------------------------------

loc_9E64:
		bsr.w	ObjectMoveAndFall
		move.b	#1,obFrame(a0)
		tst.w	obVelY(a0)
		bmi.s	loc_9E9E
		move.b	#0,obFrame(a0)
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	loc_9E9E
		not.b	objoff_29(a0)
		bne.s	loc_9E94
		neg.w	obVelX(a0)
		bchg	#0,obRender(a0)

loc_9E94:
		add.w	d1,obY(a0)
		move.w	objoff_34(a0),obVelY(a0)

loc_9E9E:
		bra.w	loc_9DB2
; ---------------------------------------------------------------------------

loc_9EA2:
		bsr.w	sub_9F92
		bpl.s	loc_9EBC
		clr.w	obVelX(a0)
		clr.w	objoff_32(a0)
		bsr.w	ObjectMoveAndFall
		bsr.w	sub_9F52
		bsr.w	sub_9F7A

loc_9EBC:
		bra.w	loc_9DB2
; ---------------------------------------------------------------------------

loc_9EC0:
		bsr.w	sub_9F92
		bpl.s	loc_9EFA
		bsr.w	ObjectMoveAndFall
		move.b	#1,obFrame(a0)
		tst.w	obVelY(a0)
		bmi.s	loc_9EFA
		move.b	#0,obFrame(a0)
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	loc_9EFA
		neg.w	obVelX(a0)
		bchg	#0,obRender(a0)
		add.w	d1,obY(a0)
		move.w	objoff_34(a0),obVelY(a0)

loc_9EFA:
		bra.w	loc_9DB2
; ---------------------------------------------------------------------------

loc_9EFE:
		bsr.w	sub_9F92
		bpl.s	loc_9F4E
		bsr.w	ObjectMove
		addi.w	#$18,obVelY(a0)
		tst.w	obVelY(a0)
		bmi.s	loc_9F38
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	loc_9F38
		not.b	objoff_29(a0)
		bne.s	loc_9F2E
		neg.w	obVelX(a0)
		bchg	#0,obRender(a0)

loc_9F2E:
		add.w	d1,obY(a0)
		move.w	objoff_34(a0),obVelY(a0)

loc_9F38:
		subq.b	#1,obTimeFrame(a0)
		bpl.s	loc_9F4E
		move.b	#1,obTimeFrame(a0)
		addq.b	#1,obFrame(a0)
		andi.b	#1,obFrame(a0)

loc_9F4E:
		bra.w	loc_9DB2

; =============== S U B	R O U T	I N E =======================================


sub_9F52:
		move.b	#1,obFrame(a0)
		tst.w	obVelY(a0)
		bmi.s	locret_9F78
		move.b	#0,obFrame(a0)
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	locret_9F78
		add.w	d1,obY(a0)
		move.w	objoff_34(a0),obVelY(a0)

locret_9F78:
		rts
; End of function sub_9F52


; =============== S U B	R O U T	I N E =======================================


sub_9F7A:
		bset	#0,obRender(a0)
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		bcc.s	locret_9F90
		bclr	#0,obRender(a0)

locret_9F90:
		rts
; End of function sub_9F7A


; =============== S U B	R O U T	I N E =======================================


sub_9F92:
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		subi.w	#$B8,d0
		rts
; End of function sub_9F92