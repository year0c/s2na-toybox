;----------------------------------------------------
; Sonic	1 Object 7F - leftover Sonic 1 SS emeralds
;----------------------------------------------------

S1Obj7F:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	S1Obj7F_Index(pc,d0.w),d1
		jmp	S1Obj7F_Index(pc,d1.w)
; ---------------------------------------------------------------------------
S1Obj7F_Index:	dc.w loc_BF4C-S1Obj7F_Index
		dc.w loc_BFA6-S1Obj7F_Index
word_BF40:	dc.w $110
		dc.w $128
		dc.w $F8
		dc.w $140
		dc.w $E0
		dc.w $158
; ---------------------------------------------------------------------------

loc_BF4C:
		movea.l	a0,a1
		lea	word_BF40(pc),a2
		moveq	#0,d2
		moveq	#0,d1
		move.b	(v_emeralds).w,d1
		subq.b	#1,d1
		bcs.w	DeleteObject

loc_BF60:
		_move.b	#id_Obj7F,obID(a1)
		move.w	(a2)+,obX(a1)
		move.w	#$F0,obScreenY(a1)
		lea	(v_emldlist).w,a3
		move.b	(a3,d2.w),d3
		move.b	d3,obFrame(a1)
		move.b	d3,obAnim(a1)
		addq.b	#1,d2
		addq.b	#2,obRoutine(a1)
		move.l	#Map_S1Obj7F,obMap(a1)
		move.w	#make_art_tile(ArtTile_SS_Results_Emeralds,0,1),obGfx(a1)
		bsr.w	Adjust2PArtPointer2
		move.b	#0,obRender(a1)
		lea	object_size(a1),a1
		dbf	d1,loc_BF60

loc_BFA6:
		move.b	obFrame(a0),d0
		move.b	#6,obFrame(a0)
		cmpi.b	#6,d0
		bne.s	loc_BFBC
		move.b	obAnim(a0),obFrame(a0)

loc_BFBC:
		bra.w	DisplaySprite