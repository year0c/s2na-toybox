;----------------------------------------------------
; Sonic	1 Object 7E - leftover S1 Special Stage	results
;----------------------------------------------------

S1Obj7E:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	S1Obj7E_Index(pc,d0.w),d1
		jmp	S1Obj7E_Index(pc,d1.w)
; ---------------------------------------------------------------------------
S1Obj7E_Index:	dc.w loc_BDA6-S1Obj7E_Index
		dc.w loc_BE1E-S1Obj7E_Index
		dc.w loc_BE5C-S1Obj7E_Index
		dc.w loc_BE6A-S1Obj7E_Index
		dc.w loc_BE5C-S1Obj7E_Index
		dc.w loc_BEC4-S1Obj7E_Index
		dc.w loc_BE5C-S1Obj7E_Index
		dc.w loc_BECE-S1Obj7E_Index
		dc.w loc_BE5C-S1Obj7E_Index
		dc.w loc_BEC4-S1Obj7E_Index
		dc.w loc_BEF2-S1Obj7E_Index
; ---------------------------------------------------------------------------

loc_BDA6:
		tst.l	(v_plc_buffer).w
		beq.s	loc_BDAE
		rts
; ---------------------------------------------------------------------------

loc_BDAE:
		movea.l	a0,a1
		lea	(S1Obj7E_Conf).l,a2
		moveq	#3,d1
		cmpi.w	#50,(v_rings).w
		bcs.s	loc_BDC2
		addq.w	#1,d1

loc_BDC2:
		_move.b	#id_Obj7E,obID(a1)
		move.w	(a2)+,obX(a1)
		move.w	(a2)+,objoff_30(a1)
		move.w	(a2)+,obScreenY(a1)
		move.b	(a2)+,obRoutine(a1)
		move.b	(a2)+,obFrame(a1)
		move.l	#Map_S1Obj7E,obMap(a1)
		move.w	#make_art_tile(ArtTile_Title_Card,0,1),obGfx(a1)
		bsr.w	Adjust2PArtPointer2
		move.b	#0,obRender(a1)
		lea	object_size(a1),a1
		dbf	d1,loc_BDC2
		moveq	#7,d0
		move.b	(v_emeralds).w,d1
		beq.s	loc_BE1A
		moveq	#0,d0
		cmpi.b	#6,d1
		bne.s	loc_BE1A
		moveq	#8,d0
		move.w	#$18,obX(a0)
		move.w	#$118,objoff_30(a0)

loc_BE1A:
		move.b	d0,obFrame(a0)

loc_BE1E:
		moveq	#$10,d1
		move.w	objoff_30(a0),d0
		cmp.w	obX(a0),d0
		beq.s	loc_BE44
		bge.s	loc_BE2E
		neg.w	d1

loc_BE2E:
		add.w	d1,obX(a0)

loc_BE32:
		move.w	obX(a0),d0
		bmi.s	locret_BE42
		cmpi.w	#$200,d0
		bcc.s	locret_BE42
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

locret_BE42:
		rts
; ---------------------------------------------------------------------------

loc_BE44:
		cmpi.b	#2,obFrame(a0)
		bne.s	loc_BE32
		addq.b	#2,obRoutine(a0)
		move.w	#180,obTimeFrame(a0)
		move.b	#id_Obj7F,(v_ssresemeralds).w

loc_BE5C:
		subq.w	#1,obTimeFrame(a0)
		bne.s	loc_BE66
		addq.b	#2,obRoutine(a0)

loc_BE66:
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_BE6A:
		bsr.w	DisplaySprite
		move.b	#1,(f_endactbonus).w
		tst.w	(v_ringbonus).w
		beq.s	loc_BE9C
		subi.w	#10,(v_ringbonus).w
		moveq	#10,d0
		jsr	(AddPoints).l
		move.b	(Vint_runcount+3).w,d0
		andi.b	#3,d0
		bne.s	locret_BEC2
		move.w	#sfx_Switch,d0
		jmp	(PlaySound_Special).l
; ---------------------------------------------------------------------------

loc_BE9C:
		move.w	#sfx_Cash,d0
		jsr	(PlaySound_Special).l
		addq.b	#2,obRoutine(a0)
		move.w	#180,obTimeFrame(a0)
		cmpi.w	#50,(v_rings).w
		bcs.s	locret_BEC2
		move.w	#60,obTimeFrame(a0)
		addq.b	#4,obRoutine(a0)

locret_BEC2:
		rts
; ---------------------------------------------------------------------------

loc_BEC4:
		move.w	#1,(Level_Inactive_flag).w
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_BECE:
		move.b	#4,(v_ssrescontinue+obFrame).w
		move.b	#$14,(v_ssrescontinue+obRoutine).w
		move.w	#sfx_Continue,d0
		jsr	(PlaySound_Special).l
		addq.b	#2,obRoutine(a0)
		move.w	#360,obTimeFrame(a0)
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_BEF2:
		move.b	(Vint_runcount+3).w,d0
		andi.b	#$F,d0
		bne.s	loc_BF02
		bchg	#0,obFrame(a0)

loc_BF02:
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------
S1Obj7E_Conf:	dc.w   $20, $120,  $C4,	$200
		dc.w  $320, $120, $118,	$201
		dc.w  $360, $120, $128,	$202
		dc.w  $1EC, $11C,  $C4,	$203
		dc.w  $3A0, $120, $138,	$206