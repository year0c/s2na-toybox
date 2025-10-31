Obj17:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj17_Index(pc,d0.w),d1
		jmp	Obj17_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj17_Index:	dc.w loc_8680-Obj17_Index
		dc.w loc_874A-Obj17_Index
		dc.w loc_87AC-Obj17_Index
; ---------------------------------------------------------------------------

loc_8680:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj17,obMap(a0)
		move.w	#make_art_tile($398,2,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#7,obStatus(a0)
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#8,obActWid(a0)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		_move.b	obID(a0),d4
		lea	obSubtype(a0),a2
		moveq	#0,d1
		move.b	(a2),d1
		move.b	#0,(a2)+
		move.w	d1,d0
		lsr.w	#1,d0
		lsl.w	#4,d0
		sub.w	d0,d3
		subq.b	#2,d1
		bcs.s	loc_874A
		moveq	#0,d6

loc_86D4:
		bsr.w	FindNextFreeObj
		bne.s	loc_874A
		addq.b	#1,obSubtype(a0)
		move.w	a1,d5
		subi.w	#v_objspace,d5
		lsr.w	#object_size_bits,d5
		andi.w	#$7F,d5
		move.b	d5,(a2)+
		move.b	#4,obRoutine(a1)
		_move.b	d4,obID(a1)
		move.w	d2,obY(a1)
		move.w	d3,obX(a1)
		move.l	obMap(a0),obMap(a1)
		move.w	#make_art_tile($398,2,0),obGfx(a1)
		bsr.w	Adjust2PArtPointer2
		move.b	#4,obRender(a1)
		move.b	#3,obPriority(a1)
		move.b	#8,obActWid(a1)
		move.b	d6,objoff_3E(a1)
		addq.b	#1,d6
		andi.b	#7,d6
		addi.w	#$10,d3
		cmp.w	obX(a0),d3
		bne.s	loc_8746
		move.b	d6,objoff_3E(a0)
		addq.b	#1,d6
		andi.b	#7,d6
		addi.w	#$10,d3
		addq.b	#1,obSubtype(a0)

loc_8746:
		dbf	d1,loc_86D4

loc_874A:
		bsr.w	sub_878C
		out_of_range.w	loc_8766
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_8766:
		moveq	#0,d2
		lea	obSubtype(a0),a2
		move.b	(a2)+,d2
		subq.b	#2,d2
		bcs.s	loc_8788

loc_8772:
		moveq	#0,d0
		move.b	(a2)+,d0
		lsl.w	#object_size_bits,d0
		addi.l	#v_objspace,d0
		movea.l	d0,a1
		bsr.w	DeleteObject2
		dbf	d2,loc_8772

loc_8788:
		bra.w	DeleteObject

; =============== S U B	R O U T	I N E =======================================


sub_878C:
		move.b	(v_ani0_frame).w,d0
		move.b	#0,obColType(a0)
		add.b	objoff_3E(a0),d0
		andi.b	#7,d0
		move.b	d0,obFrame(a0)
		bne.s	locret_87AA
		move.b	#$84,obColType(a0)

locret_87AA:
		rts
; End of function sub_878C

; ---------------------------------------------------------------------------

loc_87AC:
		bsr.w	sub_878C
		bra.w	DisplaySprite