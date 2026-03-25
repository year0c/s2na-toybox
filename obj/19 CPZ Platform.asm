; ---------------------------------------------------------------------------
; Object 19 - CPZ platforms moving side	to side
; ---------------------------------------------------------------------------

Obj19:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj19_Index(pc,d0.w),d1
		jmp	Obj19_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj19_Index:	dc.w Obj19_Init-Obj19_Index
		dc.w Obj19_Main-Obj19_Index
Obj19_WidthArray:
		dc.b 32,0
		dc.b 32,1
		dc.b 32,2
		dc.b 64,3
		dc.b 48,4
		even
; ---------------------------------------------------------------------------

Obj19_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj19,obMap(a0)
		move.w	#make_art_tile(ArtTile_CPZ_Platform,3,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		lsr.w	#3,d0
		andi.w	#$1E,d0
		lea	Obj19_WidthArray(pc,d0.w),a2
		move.b	(a2)+,obActWid(a0)
		move.b	(a2)+,obFrame(a0)
		move.b	#4,obPriority(a0)
		move.w	obX(a0),objoff_30(a0)
		move.w	obY(a0),objoff_32(a0)
		andi.b	#$F,obSubtype(a0)

Obj19_Main:
		move.w	obX(a0),-(sp)
		bsr.w	Obj19_Modes
		moveq	#0,d1
		move.b	obActWid(a0),d1
		move.w	#$10,d3
		move.w	(sp)+,d4
		bsr.w	sub_F78A
		out_of_range.w	JmpTo2_DeleteObject,objoff_30(a0)
		jmpto	JmpTo2_DisplaySprite

	if RemoveJmpTos
JmpTo2_DeleteObject	; JmpTo
		jmp	(DeleteObject).l
	endif

; =============== S U B	R O U T	I N E =======================================


Obj19_Modes:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#$F,d0
		add.w	d0,d0
		move.w	Obj19_SubIndex(pc,d0.w),d1
		jmp	Obj19_SubIndex(pc,d1.w)
; End of function Obj19_Modes

; ---------------------------------------------------------------------------
Obj19_SubIndex:	dc.w locret_1537A-Obj19_SubIndex
		dc.w loc_1537C-Obj19_SubIndex
		dc.w loc_1539C-Obj19_SubIndex
		dc.w loc_153AC-Obj19_SubIndex
		dc.w loc_1539C-Obj19_SubIndex
		dc.w loc_153CC-Obj19_SubIndex
		dc.w loc_153EC-Obj19_SubIndex
		dc.w loc_1540E-Obj19_SubIndex
		dc.w loc_15430-Obj19_SubIndex
		dc.w loc_1539C-Obj19_SubIndex
		dc.w loc_15450-Obj19_SubIndex
; ---------------------------------------------------------------------------

locret_1537A:
		rts
; ---------------------------------------------------------------------------

loc_1537C:
		move.b	(v_oscillate+$E).w,d0
		move.w	#$60,d1
		btst	#0,obStatus(a0)
		beq.s	loc_15390
		neg.w	d0
		add.w	d1,d0

loc_15390:
		move.w	objoff_30(a0),d1
		sub.w	d0,d1
		move.w	d1,obX(a0)
		rts
; ---------------------------------------------------------------------------

loc_1539C:
		move.b	obStatus(a0),d0
		andi.b	#$18,d0
		beq.s	locret_153AA
		addq.b	#1,obSubtype(a0)

locret_153AA:
		rts
; ---------------------------------------------------------------------------

loc_153AC:
		moveq	#0,d3
		move.b	obActWid(a0),d3
		bsr.w	ObjHitWallRight
		tst.w	d1
		bmi.s	loc_153C6
		addq.w	#1,obX(a0)
		move.w	obX(a0),objoff_30(a0)
		rts
; ---------------------------------------------------------------------------

loc_153C6:
		clr.b	obSubtype(a0)
		rts
; ---------------------------------------------------------------------------

loc_153CC:
		moveq	#0,d3
		move.b	obActWid(a0),d3
		bsr.w	ObjHitWallRight
		tst.w	d1
		bmi.s	loc_153E6
		addq.w	#1,obX(a0)
		move.w	obX(a0),objoff_30(a0)
		rts
; ---------------------------------------------------------------------------

loc_153E6:
		addq.b	#1,obSubtype(a0)
		rts
; ---------------------------------------------------------------------------

loc_153EC:
		jsrto	JmpTo2_ObjectMove
		addi.w	#$18,obVelY(a0)
		bsr.w	ObjHitFloor
		tst.w	d1
		bpl.w	locret_1540C
		add.w	d1,obY(a0)
		clr.w	obVelY(a0)
		clr.b	obSubtype(a0)

locret_1540C:
		rts
; ---------------------------------------------------------------------------

loc_1540E:
		tst.b	(f_switch+2).w
		beq.s	loc_15418
		subq.b	#3,obSubtype(a0)

loc_15418:
		addq.l	#6,sp
		out_of_range.w	JmpTo2_DeleteObject,objoff_30(a0)
		rts
; ---------------------------------------------------------------------------

loc_15430:
		move.b	(v_oscillate+$1E).w,d0
		move.w	#$80,d1
		btst	#0,obStatus(a0)
		beq.s	loc_15444
		neg.w	d0
		add.w	d1,d0

loc_15444:
		move.w	objoff_32(a0),d1
		sub.w	d0,d1
		move.w	d1,obY(a0)
		rts
; ---------------------------------------------------------------------------

loc_15450:
		moveq	#0,d3
		move.b	obActWid(a0),d3
		add.w	d3,d3
		moveq	#8,d1
		btst	#0,obStatus(a0)
		beq.s	loc_15466
		neg.w	d1
		neg.w	d3

loc_15466:
		tst.w	objoff_36(a0)
		bne.s	loc_15492
		move.w	obX(a0),d0
		sub.w	objoff_30(a0),d0
		cmp.w	d3,d0
		beq.s	loc_15484
		add.w	d1,obX(a0)
		move.w	#$12C,objoff_34(a0)
		rts
; ---------------------------------------------------------------------------

loc_15484:
		subq.w	#1,objoff_34(a0)
		bne.s	locret_15490
		move.w	#1,objoff_36(a0)

locret_15490:
		rts
; ---------------------------------------------------------------------------

loc_15492:
		move.w	obX(a0),d0
		sub.w	objoff_30(a0),d0
		beq.s	loc_154A2
		sub.w	d1,obX(a0)
		rts
; ---------------------------------------------------------------------------

loc_154A2:
		clr.w	objoff_36(a0)
		subq.b	#1,obSubtype(a0)
		rts