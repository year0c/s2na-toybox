;----------------------------------------------------
; Object 39 - Game over	/ time over
;----------------------------------------------------

Obj39:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj39_Index(pc,d0.w),d1
		jmp	Obj39_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj39_Index:	dc.w loc_BA98-Obj39_Index
		dc.w loc_BADC-Obj39_Index
		dc.w loc_BAFE-Obj39_Index
; ---------------------------------------------------------------------------

loc_BA98:
		tst.l	(v_plc_buffer).w
		beq.s	loc_BAA0
		rts
; ---------------------------------------------------------------------------

loc_BAA0:
		addq.b	#2,obRoutine(a0)
		move.w	#$50,obX(a0)
		btst	#0,obFrame(a0)
		beq.s	loc_BAB8
		move.w	#$1F0,obX(a0)

loc_BAB8:
		move.w	#$F0,obScreenY(a0)
		move.l	#Map_Obj39,obMap(a0)
		move.w	#make_art_tile(ArtTile_Game_Over,0,1),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#0,obRender(a0)
		move.b	#0,obPriority(a0)

loc_BADC:
		moveq	#$10,d1
		cmpi.w	#$120,obX(a0)
		beq.s	loc_BAF2
		blo.s	loc_BAEA
		neg.w	d1

loc_BAEA:
		add.w	d1,obX(a0)
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_BAF2:
		move.w	#720,obTimeFrame(a0)
		addq.b	#2,obRoutine(a0)
	if FixBugs
		bra.w	DisplaySprite
	else
		; Bug: This causes the Game Over text to disappear for a frame.
		rts
	endif
; ---------------------------------------------------------------------------

loc_BAFE:
		move.b	(v_jpadpress1).w,d0
		andi.b	#btnABC,d0
		bne.s	loc_BB1E
		btst	#0,obFrame(a0)
		bne.s	loc_BB42
		tst.w	obTimeFrame(a0)
		beq.s	loc_BB1E
		subq.w	#1,obTimeFrame(a0)
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_BB1E:
		tst.b	(f_timeover).w
		bne.s	loc_BB38
		move.b	#GameModeID_ContinueScreen,(v_gamemode).w
		tst.b	(v_continues).w
		bne.s	loc_BB42
		move.b	#GameModeID_SegaScreen,(v_gamemode).w
		bra.s	loc_BB42
; ---------------------------------------------------------------------------

loc_BB38:
		clr.l	(v_lamp_time).w
		move.w	#1,(Level_Inactive_flag).w

loc_BB42:
		bra.w	DisplaySprite