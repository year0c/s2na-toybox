;----------------------------------------------------
; Sonic	1 Object 4B - leftover giant ring code
;----------------------------------------------------

S1Obj4B:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	S1Obj4B_Index(pc,d0.w),d1
		jmp	S1Obj4B_Index(pc,d1.w)
; ---------------------------------------------------------------------------
S1Obj4B_Index:	dc.w loc_AA88-S1Obj4B_Index
		dc.w loc_AAD6-S1Obj4B_Index
		dc.w loc_AAF4-S1Obj4B_Index
		dc.w loc_AB38-S1Obj4B_Index
; ---------------------------------------------------------------------------

loc_AA88:
		move.l	#Map_S1Obj4B,obMap(a0)
		move.w	#make_art_tile(ArtTile_Giant_Ring,1,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		ori.b	#4,obRender(a0)
		move.b	#$40,obActWid(a0)
		tst.b	obRender(a0)
		bpl.s	loc_AAD6
		cmpi.b	#6,(v_emeralds).w
		beq.w	loc_AB38
		cmpi.w	#50,(v_rings).w
		bcc.s	loc_AAC0
		rts
; ---------------------------------------------------------------------------

loc_AAC0:
		addq.b	#2,obRoutine(a0)
		move.b	#2,obPriority(a0)
		move.b	#$52,obColType(a0)
		move.w	#$C40,(v_gfxbigring).w

loc_AAD6:
		move.b	(v_ani1_frame).w,obFrame(a0)
		out_of_range.w	DeleteObject
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_AAF4:
		subq.b	#2,obRoutine(a0)
		move.b	#0,obColType(a0)
		bsr.w	FindFreeObj
		bne.w	loc_AB2C
		_move.b	#id_Obj7C,obID(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.l	a0,objoff_3C(a1)
		move.w	(v_player+obX).w,d0
		cmp.w	obX(a0),d0
		bcs.s	loc_AB2C
		bset	#0,obRender(a1)

loc_AB2C:
		move.w	#sfx_GiantRing,d0
		jsr	(PlaySound_Special).l
		bra.s	loc_AAD6
; ---------------------------------------------------------------------------

loc_AB38:
		bra.w	DeleteObject