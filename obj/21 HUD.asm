; ===========================================================================
; ---------------------------------------------------------------------------
; Object 21 - SCORE, TIME, RINGS
; ---------------------------------------------------------------------------

Obj21:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj21_Index(pc,d0.w),d1
		jmp	Obj21_Index(pc,d1.w)
; ===========================================================================
Obj21_Index:	dc.w Obj21_Init-Obj21_Index
		dc.w Obj21_Main-Obj21_Index
; ===========================================================================

Obj21_Init:
		addq.b	#2,obRoutine(a0)
		move.w	#$90,obX(a0)
		move.w	#$108,obScreenY(a0)
		move.l	#Map_obj21,obMap(a0)
		move.w	#make_art_tile(ArtTile_HUD,0,0),obGfx(a0)
		bsr.w	j_Adjust2PArtPointer_8
		move.b	#0,obRender(a0)
		move.b	#0,obPriority(a0)

Obj21_Main:
		tst.w	(v_rings).w
		beq.s	Obj21_NoRings
		moveq	#0,d0
		btst	#3,(Timer_frames+1).w
		bne.s	Obj21_Display
		cmpi.b	#9,(v_timemin).w
		bne.s	Obj21_Display
		addq.w	#2,d0
; loc_1B082:
Obj21_Display:
		move.b	d0,obFrame(a0)
		jmp	(DisplaySprite).l
; ---------------------------------------------------------------------------
; loc_1B08C:
Obj21_NoRings:
		moveq	#0,d0
		btst	#3,(Timer_frames+1).w
		bne.s	Obj21_Display2
		addq.w	#1,d0
		cmpi.b	#9,(v_timemin).w
		bne.s	Obj21_Display2
		addq.w	#2,d0
; loc_1B0A2:
Obj21_Display2:
		move.b	d0,obFrame(a0)
		jmp	(DisplaySprite).l