; ---------------------------------------------------------------------------
; Object 0B - Section of pipe that tips you off from CPZ
; ---------------------------------------------------------------------------

Obj0B:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj0B_Index(pc,d0.w),d1
		jmp	Obj0B_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj0B_Index:	dc.w loc_141C8-Obj0B_Index
		dc.w loc_1421C-Obj0B_Index
		dc.w loc_1422A-Obj0B_Index
; ---------------------------------------------------------------------------

obj0B_duration_current = objoff_30
obj0B_duration_initial = objoff_32
obj0B_delay = objoff_36

loc_141C8:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj0B,obMap(a0)
		move.w	#make_art_tile(ArtTile_Level,3,1),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		ori.b	#4,obRender(a0)
		move.b	#16,obActWid(a0)
		move.b	#4,obPriority(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#$F0,d0
		addi.w	#$10,d0
		move.w	d0,d1
		subq.w	#1,d0
		move.w	d0,obj0B_duration_current(a0)
		move.w	d0,obj0B_duration_initial(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#$F,d0
		addq.w	#1,d0
		lsl.w	#4,d0
		move.b	d0,obj0B_delay(a0)

loc_1421C:
		move.b	(Vint_runcount+3).w,d0
		add.b	obj0B_delay(a0),d0
		bne.s	loc_14254
		addq.b	#2,obRoutine(a0)

loc_1422A:
		subq.w	#1,obj0B_duration_current(a0)
		bpl.s	loc_14248
		move.w	#$7F,obj0B_duration_current(a0)
		tst.b	obAnim(a0)
		beq.s	loc_14242
		move.w	obj0B_duration_initial(a0),obj0B_duration_current(a0)

loc_14242:
		bchg	#0,obAnim(a0)

loc_14248:
		lea	(off_1428A).l,a1
		jsr	(AnimateSprite).l

loc_14254:
		tst.b	obFrame(a0)
		bne.s	loc_1426E
		moveq	#0,d1
		move.b	obActWid(a0),d1
		moveq	#17,d3
		move.w	obX(a0),d4
		bsr.w	sub_F78A
		bra.w	MarkObjGone
; ---------------------------------------------------------------------------

loc_1426E:
		btst	#3,obStatus(a0)
		beq.s	loc_14286
		lea	(v_player).w,a1
		bclr	#3,obStatus(a1)
		bclr	#3,obStatus(a0)

loc_14286:
		bra.w	MarkObjGone