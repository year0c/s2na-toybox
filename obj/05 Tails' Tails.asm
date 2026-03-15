; ===========================================================================
; ---------------------------------------------------------------------------
; Object 05 - Tails' tails
; ---------------------------------------------------------------------------

Obj05:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj05_Index(pc,d0.w),d1
		jmp	Obj05_Index(pc,d1.w)
; ===========================================================================
Obj05_Index:	dc.w Obj05_Init-Obj05_Index
		dc.w Obj05_Main-Obj05_Index
; ===========================================================================

Obj05_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Tails,obMap(a0)
		move.w	#make_art_tile(ArtTile_TailsTails,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#2,obPriority(a0)
		move.b	#24,obActWid(a0)
		move.b	#4,obRender(a0)

Obj05_Main:
		move.b	(v_player2+obAngle).w,obAngle(a0)
		move.b	(v_player2+obStatus).w,obStatus(a0)
		move.w	(v_player2+obX).w,obX(a0)
		move.w	(v_player2+obY).w,obY(a0)
		moveq	#0,d0
		move.b	(v_player2+obAnim).w,d0
		cmp.b	objoff_30(a0),d0
		beq.s	loc_11DE6
		move.b	d0,objoff_30(a0)
		move.b	Obj05_Animations(pc,d0.w),obAnim(a0)

loc_11DE6:
		lea	(Obj05_AniData).l,a1
		bsr.w	Tails_Animate2
		bsr.w	LoadTailsTailsDynPLC
		jsr	(DisplaySprite).l
		rts