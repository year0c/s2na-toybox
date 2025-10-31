;----------------------------------------------------
; Object 3C - GHZ smashable wall
;----------------------------------------------------

Obj3C:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj3C_Index(pc,d0.w),d1
		jsr	Obj3C_Index(pc,d1.w)
		bra.w	MarkObjGone
; ---------------------------------------------------------------------------
Obj3C_Index:	dc.w loc_C8DC-Obj3C_Index
		dc.w loc_C90A-Obj3C_Index
		dc.w loc_C988-Obj3C_Index
; ---------------------------------------------------------------------------

loc_C8DC:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj3C,obMap(a0)
		move.w	#make_art_tile($590,2,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#$10,obActWid(a0)
		move.b	#4,obPriority(a0)
		move.b	obSubtype(a0),obFrame(a0)

loc_C90A:
		move.w	(v_player+obVelX).w,objoff_30(a0)
		move.w	#$1B,d1
		move.w	#$20,d2
		move.w	#$20,d3
		move.w	obX(a0),d4
		bsr.w	SolidObject
		btst	#5,obStatus(a0)
		bne.s	loc_C92E

locret_C92C:
		rts
; ---------------------------------------------------------------------------

loc_C92E:
		lea	(v_player).w,a1
		cmpi.b	#2,obAnim(a1)
		bne.s	locret_C92C
		move.w	objoff_30(a0),d0
		bpl.s	loc_C942
		neg.w	d0

loc_C942:
		cmpi.w	#$480,d0
		bcs.s	locret_C92C
		move.w	objoff_30(a0),obVelX(a1)
		addq.w	#4,obX(a1)
		lea	(Obj3C_FragSpdRight).l,a4
		move.w	obX(a0),d0
		cmp.w	obX(a1),d0
		bcs.s	loc_C96E
		subi.w	#8,obX(a1)
		lea	(Obj3C_FragSpdLeft).l,a4

loc_C96E:
		move.w	obVelX(a1),obInertia(a1)
		bclr	#5,obStatus(a0)
		bclr	#5,obStatus(a1)
		moveq	#7,d1
		move.w	#$70,d2
		bsr.s	SmashObject

loc_C988:
		bsr.w	ObjectMove
		addi.w	#$70,obVelY(a0)
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		bra.w	DisplaySprite