; ---------------------------------------------------------------------------

S1Obj_53:						; leftover object from Sonic 1
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	S1Obj_53_Index(pc,d0.w),d1
		jmp	S1Obj_53_Index(pc,d1.w)
; ---------------------------------------------------------------------------
S1Obj_53_Index:	dc.w loc_8D6A-S1Obj_53_Index
		dc.w loc_8DB4-S1Obj_53_Index
		dc.w loc_8DEA-S1Obj_53_Index
; ---------------------------------------------------------------------------

loc_8D6A:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_S1Obj53,obMap(a0)
		move.w	#make_art_tile($2B8,2,0),obGfx(a0)
		cmpi.b	#id_SLZ,(Current_Zone).w
		bne.s	loc_8D8E
		move.w	#make_art_tile($4E0,2,0),obGfx(a0)
		addq.b	#2,obFrame(a0)

loc_8D8E:
		cmpi.b	#id_SBZ,(Current_Zone).w
		bne.s	loc_8D9C
		move.w	#make_art_tile($3F5,2,0),obGfx(a0)

loc_8D9C:
		ori.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#7,objoff_38(a0)
		move.b	#$44,obActWid(a0)

loc_8DB4:
		tst.b	objoff_3A(a0)
		beq.s	loc_8DC6
		tst.b	objoff_38(a0)
		beq.w	loc_8E3E
		subq.b	#1,objoff_38(a0)

loc_8DC6:
		move.b	obStatus(a0),d0
		andi.b	#$18,d0
		beq.s	sub_8DD6
		move.b	#1,objoff_3A(a0)

; =============== S U B	R O U T	I N E =======================================


sub_8DD6:
		move.w	#$20,d1
		move.w	#8,d3
		move.w	obX(a0),d4
		bsr.w	sub_F78A
		bra.w	MarkObjGone
; End of function sub_8DD6

; ---------------------------------------------------------------------------

loc_8DEA:
		tst.b	objoff_38(a0)
		beq.s	loc_8E2E
		tst.b	objoff_3A(a0)
		bne.s	loc_8DFE
		subq.b	#1,objoff_38(a0)
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_8DFE:
		bsr.w	sub_8DD6
		subq.b	#1,objoff_38(a0)
		bne.s	locret_8E2C
		lea	(v_player).w,a1
		bsr.s	sub_8E12
		lea	(v_player2).w,a1

; =============== S U B	R O U T	I N E =======================================


sub_8E12:
		btst	#3,obStatus(a1)
		beq.s	locret_8E2C
		bclr	#3,obStatus(a1)
		bclr	#5,obStatus(a1)
		move.b	#1,obPrevAni(a1)

locret_8E2C:
		rts
; End of function sub_8E12

; ---------------------------------------------------------------------------

loc_8E2E:
		bsr.w	ObjectMoveAndFall
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_8E3E:
		lea	(byte_8F17).l,a4
		btst	#0,obSubtype(a0)
		beq.s	loc_8E52
		lea	(byte_8F1F).l,a4

loc_8E52:
		addq.b	#1,obFrame(a0)
		bra.s	loc_8E70