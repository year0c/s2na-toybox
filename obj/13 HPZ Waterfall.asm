; ---------------------------------------------------------------------------
; Object 13 - HPZ waterfall
; ---------------------------------------------------------------------------

Obj13:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj13_Index(pc,d0.w),d1
		jmp	Obj13_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj13_Index:	dc.w loc_1446C-Obj13_Index
		dc.w loc_14532-Obj13_Index
		dc.w loc_145BC-Obj13_Index
; ---------------------------------------------------------------------------

loc_1446C:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj13,obMap(a0)
		move.w	#make_art_tile(ArtTile_HPZ_Waterfall,3,1),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#16,obActWid(a0)
		move.b	#1,obPriority(a0)
		move.b	#$12,obFrame(a0)
		bsr.s	sub_144D4
		move.b	#$A0,obHeight(a1)
		bset	#4,obRender(a1)
		move.l	a1,objoff_38(a0)
		move.w	obY(a0),objoff_34(a0)
		move.w	obY(a0),objoff_36(a0)
		cmpi.b	#$10,obSubtype(a0)
		blo.s	loc_14518
		bsr.s	sub_144D4
		move.l	a1,objoff_3C(a0)
		move.w	obY(a0),obY(a1)
		addi.w	#$98,obY(a1)
		bra.s	loc_14518

; =============== S U B	R O U T	I N E =======================================


sub_144D4:
		jsr	(FindNextFreeObj).l
		bne.s	locret_14516
		_move.b	#id_Obj13,obID(a1)
		addq.b	#4,obRoutine(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.l	#Map_Obj13,obMap(a1)
		move.w	#make_art_tile(ArtTile_HPZ_Waterfall,3,1),obGfx(a1)
		bsr.w	Adjust2PArtPointer2
		move.b	#4,obRender(a1)
		move.b	#16,obActWid(a1)
		move.b	#1,obPriority(a1)

locret_14516:
		rts
; End of function sub_144D4

; ---------------------------------------------------------------------------

loc_14518:
		moveq	#0,d1
		move.b	obSubtype(a0),d1
		move.w	objoff_34(a0),d0
		subi.w	#$78,d0
		lsl.w	#4,d1
		add.w	d1,d0
		move.w	d0,obY(a0)
		move.w	d0,objoff_34(a0)

loc_14532:
		movea.l	objoff_38(a0),a1
		move.b	#$12,obFrame(a0)
		move.w	objoff_34(a0),d0
		move.w	(v_waterpos1).w,d1
		cmp.w	d0,d1
		bhs.s	loc_1454A
		move.w	d1,d0

loc_1454A:
		move.w	d0,obY(a0)
		sub.w	objoff_36(a0),d0
		addi.w	#$80,d0
		bmi.s	loc_1459C
		lsr.w	#4,d0
		move.w	d0,d1
		cmpi.w	#$F,d0
		blo.s	loc_14564
		moveq	#$F,d0

loc_14564:
		move.b	d0,obFrame(a1)
		cmpi.b	#$10,obSubtype(a0)
		blo.s	loc_14584
		movea.l	objoff_3C(a0),a1
		subi.w	#$F,d1
		bhs.s	loc_1457C
		moveq	#0,d1

loc_1457C:
		addi.w	#$13,d1
		move.b	d1,obFrame(a1)

loc_14584:
		out_of_range.w	DeleteObject
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_1459C:
		moveq	#$13,d0
		move.b	d0,obFrame(a0)
		move.b	d0,obFrame(a1)
		out_of_range.w	DeleteObject
		rts
; ---------------------------------------------------------------------------

loc_145BC:
		out_of_range.w	DeleteObject
		bra.w	DisplaySprite