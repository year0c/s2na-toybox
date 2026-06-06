; ===========================================================================
; ---------------------------------------------------------------------------
; Object 21 - SCORE, TIME, RINGS
; ---------------------------------------------------------------------------

Obj21_PB:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj21_Index_PB(pc,d0.w),d1
		jmp	Obj21_Index_PB(pc,d1.w)
; ===========================================================================
Obj21_Index_PB:	dc.w Obj21_Init_PB-Obj21_Index_PB
		dc.w Obj21_Main_PB-Obj21_Index_PB
; ===========================================================================

Obj21_Init_PB:
		addq.b	#2,obRoutine(a0)
		move.w	#$90,obX(a0)
		move.w	#$108,obScreenY(a0)
		move.l	#Map_Obj21_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_HUD,0,0),obGfx(a0)
		bsr.w	$1A074+$A84	;	JmpTo9_Adjust2PArtPointer
		move.b	#0,obRender(a0)
		move.b	#0,obPriority(a0)

Obj21_Main_PB:
		tst.w	(v_rings).w
		beq.s	Obj21_NoRings_PB
		moveq	#0,d0
		btst	#3,(Timer_frames+1).w
		bne.s	Obj21_Display_PB
		cmpi.b	#9,(v_timemin).w
		bne.s	Obj21_Display_PB
		addq.w	#2,d0
; loc_1B082:
Obj21_Display_PB:
		move.b	d0,obFrame(a0)
		jmp	(DisplaySprite_PB).l
; ---------------------------------------------------------------------------
; loc_1B08C:
Obj21_NoRings_PB:
		moveq	#0,d0
		btst	#3,(Timer_frames+1).w
		bne.s	Obj21_Display2_PB
		addq.w	#1,d0
		cmpi.b	#9,(v_timemin).w
		bne.s	Obj21_Display2_PB
		addq.w	#2,d0
; loc_1B0A2:
Obj21_Display2_PB:
		move.b	d0,obFrame(a0)
		jmp	(DisplaySprite_PB).l