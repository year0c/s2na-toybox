; ---------------------------------------------------------------------------
; Object 8A - "SONIC TEAM PRESENTS" and credits
; ---------------------------------------------------------------------------

Obj8A_PB:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Cred_PB_Index(pc,d0.w),d1
		jmp	Cred_PB_Index(pc,d1.w)
; ===========================================================================
Cred_PB_Index:	dc.w Cred_PB_Main-Cred_PB_Index
		dc.w Cred_PB_Display-Cred_PB_Index
; ===========================================================================

Cred_PB_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.w	#$120,obX(a0)
		move.w	#$F0,obScreenY(a0)
		move.l	#Map_Cred_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_Credits_Font,0,0),obGfx(a0)
		bsr.w	$175A8+$714	;	JmpTo5_Adjust2PArtPointer
		move.w	(v_creditsnum).w,d0 ; load credits index number
		move.b	d0,obFrame(a0)	; display appropriate sprite
		move.b	#0,obRender(a0)
		move.b	#0,obPriority(a0)

		cmpi.b	#GameModeID_TitleScreen,(v_gamemode).w ; is the mode #4 (title screen)?
		bne.s	Cred_PB_Display	; if not, branch

		move.w	#make_art_tile(ArtTile_Title_Sonic,0,0),obGfx(a0)
		bsr.w	$175A8+$714	;	JmpTo5_Adjust2PArtPointer
		move.b	#$A,obFrame(a0)	; display "SONIC TEAM PRESENTS"
		tst.b	(f_creditscheat).w ; is hidden credits cheat on?
		beq.s	Cred_PB_Display	; if not, branch
		cmpi.b	#btnABC+btnDn,(v_jpadhold1).w ; is A+B+C+Down being pressed? ($72)
		bne.s	Cred_PB_Display	; if not, branch
		move.w	#cWhite,(v_palette_fading_line_3).w ; 3rd palette, 1st entry = white
		move.w	#$880,(v_palette_fading_line_3+2).w ; 3rd palette, 2nd entry = cyan
		jmp	(DeleteObject_PB).l
; ===========================================================================

Cred_PB_Display:	; Routine 2
		jmp	(DisplaySprite_PB).l
