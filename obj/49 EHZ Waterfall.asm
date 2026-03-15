; ---------------------------------------------------------------------------
; Object 49 - EHZ waterfalls
; ---------------------------------------------------------------------------

Obj49:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj49_Index(pc,d0.w),d1
		jmp	Obj49_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj49_Index:	dc.w Obj49_Init-Obj49_Index
		dc.w Obj49_Main-Obj49_Index
; ---------------------------------------------------------------------------

Obj49_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj49,obMap(a0)
		move.w	#make_art_tile(ArtTile_Waterfall,1,0),obGfx(a0)
		jsrto	JmpTo_Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#32,obActWid(a0)
		move.w	obX(a0),objoff_30(a0)
		move.b	#0,obPriority(a0)
		move.b	#128,obHeight(a0)
		bset	#4,obRender(a0)

Obj49_Main:
		tst.w	(Two_player_mode).w
		bne.s	loc_156F6
		out_of_range.w	JmpTo3_DeleteObject

loc_156F6:
		move.w	obX(a0),d1
		move.w	d1,d2
		subi.w	#$40,d1
		addi.w	#$40,d2
		move.b	obSubtype(a0),d3
		move.b	#0,obFrame(a0)
		move.w	(v_player+obX).w,d0
		cmp.w	d1,d0
		blo.s	loc_15728
		cmp.w	d2,d0
		bhs.s	loc_15728
		move.b	#1,obFrame(a0)
		add.b	d3,obFrame(a0)
		jmpto	JmpTo3_DisplaySprite
; ---------------------------------------------------------------------------

loc_15728:
		move.w	(v_player2+obX).w,d0
		cmp.w	d1,d0
		blo.s	loc_1573A
		cmp.w	d2,d0
		bhs.s	loc_1573A
		move.b	#1,obFrame(a0)

loc_1573A:
		add.b	d3,obFrame(a0)
		jmpto	JmpTo3_DisplaySprite

	if RemoveJmpTos
JmpTo3_DeleteObject	; JmpTo
		jmp	(DeleteObject).l
	endif