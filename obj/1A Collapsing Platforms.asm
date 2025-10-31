Obj1A:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj1A_Index(pc,d0.w),d1
		jmp	Obj1A_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj1A_Index:	dc.w loc_8C58-Obj1A_Index
		dc.w loc_8CCA-Obj1A_Index
		dc.w loc_8D02-Obj1A_Index
; ---------------------------------------------------------------------------

loc_8C58:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj1A,obMap(a0)
		move.w	#make_art_tile(ArtTile_Level,2,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		ori.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#7,objoff_38(a0)
		move.b	obSubtype(a0),obFrame(a0)
		cmpi.b	#id_HPZ,(Current_Zone).w
		bne.s	loc_8CB0
		move.l	#Map_Obj1A_HPZ,obMap(a0)
		move.w	#$434A,obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#$30,obActWid(a0)
		move.l	#Obj1A_Conf_HPZ,objoff_3C(a0)
		bra.s	loc_8CCA
; ---------------------------------------------------------------------------

loc_8CB0:
		move.l	#Obj1A_Conf,objoff_3C(a0)
		move.b	#$34,obActWid(a0)
		move.b	#$38,obHeight(a0)
		bset	#4,obRender(a0)

loc_8CCA:
		tst.b	objoff_3A(a0)
		beq.s	loc_8CDC
		tst.b	objoff_38(a0)
		beq.w	loc_8E58
		subq.b	#1,objoff_38(a0)

loc_8CDC:
		move.b	obStatus(a0),d0
		andi.b	#$18,d0
		beq.s	sub_8CEC
		move.b	#1,objoff_3A(a0)

; =============== S U B	R O U T	I N E =======================================


sub_8CEC:
		moveq	#0,d1
		move.b	obActWid(a0),d1
		movea.l	objoff_3C(a0),a2
		move.w	obX(a0),d4
		bsr.w	sub_F7DC
		bra.w	MarkObjGone
; End of function sub_8CEC

; ---------------------------------------------------------------------------

loc_8D02:
		tst.b	objoff_38(a0)
		beq.s	loc_8D46
		tst.b	objoff_3A(a0)
		bne.s	loc_8D16
		subq.b	#1,objoff_38(a0)
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_8D16:
		bsr.w	sub_8CEC
		subq.b	#1,objoff_38(a0)
		bne.s	locret_8D44
		lea	(v_player).w,a1
		bsr.s	sub_8D2A
		lea	(v_player2).w,a1

; =============== S U B	R O U T	I N E =======================================


sub_8D2A:
		btst	#3,obStatus(a1)
		beq.s	locret_8D44
		bclr	#3,obStatus(a1)
		bclr	#5,obStatus(a1)
		move.b	#1,obPrevAni(a1)

locret_8D44:
		rts
; End of function sub_8D2A

; ---------------------------------------------------------------------------

loc_8D46:
		bsr.w	ObjectMoveAndFall
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		bra.w	DisplaySprite