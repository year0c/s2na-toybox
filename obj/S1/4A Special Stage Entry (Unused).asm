; ---------------------------------------------------------------------------
; Sonic	1 Object 4A - giant ring entry effect from prototype
; ---------------------------------------------------------------------------
; OST:
obj4A_vanishtime:	equ $30				; time for Sonic to vanish for
; ---------------------------------------------------------------------------

S1Obj4A:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	S1Obj4A_Index(pc,d0.w),d1
		jmp	S1Obj4A_Index(pc,d1.w)
; ===========================================================================
S1Obj4A_Index:	dc.w S1Obj4A_Init-S1Obj4A_Index
		dc.w S1Obj4A_RmvSonic-S1Obj4A_Index
		dc.w S1Obj4A_LoadSonic-S1Obj4A_Index
; ===========================================================================

S1Obj4A_Init:
		tst.l	(v_plc_buffer).w		; are the pattern load cues empty?
		beq.s	loc_124D4			; if yes, branch
		rts
; ---------------------------------------------------------------------------

loc_124D4:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_S1obj4A,obMap(a0)
		move.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#$38,obActWid(a0)
		move.w	#make_art_tile(ArtTile_Warp,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.w	#60*2,obj4A_vanishtime(a0)	; set vanishing time to 2 seconds

S1Obj4A_RmvSonic:
		move.w	(v_player+obX).w,obX(a0)
		move.w	(v_player+obY).w,obY(a0)
		move.b	(v_player+obStatus).w,obStatus(a0)
		lea	(Ani_S1obj4A).l,a1
		jsr	(AnimateSprite).l
		cmpi.b	#2,obFrame(a0)
		bne.s	loc_1253E
		tst.b	(v_player+obID).w		; is this Sonic?
		beq.s	loc_1253E			; if not, branch
		move.b	#0,(v_player+obID).w		; set Sonic's object ID to 0
		move.w	#sfx_SSGoal,d0
		jsr	(PlaySound_Special).l		; play Special Stage entry sound effect

loc_1253E:
		jmp	(DisplaySprite).l
; ===========================================================================

S1Obj4A_LoadSonic:
		subq.w	#1,obj4A_vanishtime(a0)		; subtract 1 from vanishing time
		bne.s	locret_12556			; if there's any time left, branch
		move.b	#id_Obj01,(v_player+obID).w			; set Sonic's object ID to 1
		jmp	(DeleteObject).l
; ---------------------------------------------------------------------------

locret_12556:
		rts