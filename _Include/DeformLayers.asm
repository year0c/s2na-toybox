; ---------------------------------------------------------------------------
; Background layer deformation subroutines
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

DeformBGLayer:
		tst.b	(Deform_lock).w
		beq.s	loc_5AA4
		rts
; ---------------------------------------------------------------------------

loc_5AA4:
		clr.w	(Scroll_flags).w
		clr.w	(Scroll_flags_BG).w
		clr.w	(Scroll_flags_BG2).w
		clr.w	(Scroll_flags_BG3).w
		clr.w	(Scroll_flags_P2).w
		clr.w	(Scroll_flags_BG_P2).w
		clr.w	(Scroll_flags_BG2_P2).w
		clr.w	(Scroll_flags_BG3_P2).w
		lea	(v_player).w,a0
		lea	(Camera_RAM).w,a1
		lea	(Horiz_block_crossed_flag).w,a2
		lea	(Scroll_flags).w,a3
		lea	(Camera_X_pos_diff).w,a4
		lea	(Horiz_scroll_delay_val).w,a5
		lea	(Sonic_Pos_Record_Buf).w,a6
		bsr.w	ScrollHorizontal
		lea	(Camera_Y_pos).w,a1
		lea	(Verti_block_crossed_flag).w,a2
		lea	(Camera_Y_pos_diff).w,a4
		bsr.w	ScrollVertical
		tst.w	(Two_player_mode).w
		beq.s	loc_5B2A
		lea	(v_player2).w,a0
		lea	(Camera_X_pos_P2).w,a1
		lea	(Horiz_block_crossed_flag_P2).w,a2
		lea	(Scroll_flags_P2).w,a3
		lea	(Camera_BG_Y_pos_diff).w,a4
		lea	(Horiz_scroll_delay_val_P2).w,a5
		lea	(Tails_Pos_Record_Buf_Dup).w,a6
		bsr.w	ScrollHorizontal
		lea	(Camera_Y_pos_P2).w,a1
		lea	(Verti_block_crossed_flag_P2).w,a2
		lea	(Camera_X_pos_diff_P2).w,a4
		bsr.w	ScrollVertical

loc_5B2A:
		bsr.w	DynScreenResizeLoad
		move.w	(Camera_Y_pos).w,(v_scrposy_vdp).w
		move.w	(Camera_BG_Y_pos).w,(v_bgscrposy_vdp).w
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		add.w	d0,d0
		move.w	Deform_Index(pc,d0.w),d0
		jmp	Deform_Index(pc,d0.w)
; End of function DeformBGLayer

; ---------------------------------------------------------------------------
Deform_Index:	dc.w Deform_GHZ-Deform_Index
		dc.w Deform_LZ-Deform_Index
		dc.w Deform_CPZ-Deform_Index
		dc.w Deform_EHZ-Deform_Index
		dc.w Deform_HPZ-Deform_Index
		dc.w Deform_HTZ-Deform_Index
		dc.w Deform_GHZ-Deform_Index
; ---------------------------------------------------------------------------

Deform_GHZ:
		tst.w	(Two_player_mode).w		; is two player mode enabled?
		bne.w	Deform_GHZ_2P	; if so, branch
		move.w	(Camera_X_pos_diff).w,d4
		ext.l	d4
		asl.l	#5,d4
		move.l	d4,d1
		asl.l	#1,d4
		add.l	d1,d4
		moveq	#0,d6
		bsr.w	ScrollBlock6
		move.w	(Camera_X_pos_diff).w,d4
		ext.l	d4
		asl.l	#7,d4
		moveq	#0,d6
		bsr.w	ScrollBlock5
		lea	(v_hscrolltablebuffer).w,a1
		move.w	(Camera_Y_pos).w,d0
		andi.w	#$7FF,d0
		lsr.w	#5,d0
		neg.w	d0
		addi.w	#$20,d0
		bpl.s	loc_5B9A
		moveq	#0,d0

loc_5B9A:
		move.w	d0,d4
		move.w	d0,(v_bgscrposy_vdp).w
		move.w	(Camera_RAM).w,d0
		cmpi.b	#GameModeID_TitleScreen,(v_gamemode).w
		bne.s	loc_5BAE
		moveq	#0,d0

loc_5BAE:
		neg.w	d0
		swap	d0
		lea	(v_bgscroll_buffer).w,a2
		addi.l	#$10000,(a2)+
		addi.l	#$C000,(a2)+
		addi.l	#$8000,(a2)+
		move.w	(v_bgscroll_buffer).w,d0
		add.w	(Camera_BG3_X_pos).w,d0
		neg.w	d0
		move.w	#32-1,d1
		sub.w	d4,d1
		blo.s	loc_5BE0

loc_5BDA:
		move.l	d0,(a1)+
		dbf	d1,loc_5BDA

loc_5BE0:
		move.w	(v_bgscroll_buffer+4).w,d0
		add.w	(Camera_BG3_X_pos).w,d0
		neg.w	d0
		move.w	#16-1,d1

loc_5BEE:
		move.l	d0,(a1)+
		dbf	d1,loc_5BEE
		move.w	(v_bgscroll_buffer+8).w,d0
		add.w	(Camera_BG3_X_pos).w,d0
		neg.w	d0
		move.w	#16-1,d1

loc_5C02:
		move.l	d0,(a1)+
		dbf	d1,loc_5C02
		move.w	#48-1,d1
		move.w	(Camera_BG3_X_pos).w,d0
		neg.w	d0

loc_5C12:
		move.l	d0,(a1)+
		dbf	d1,loc_5C12
		move.w	#40-1,d1
		move.w	(Camera_BG2_X_pos).w,d0
		neg.w	d0

loc_5C22:
		move.l	d0,(a1)+
		dbf	d1,loc_5C22
		move.w	(Camera_BG2_X_pos).w,d0
		move.w	(Camera_RAM).w,d2
		sub.w	d0,d2
		ext.l	d2
		asl.l	#8,d2
		divs.w	#$68,d2
		ext.l	d2
		asl.l	#8,d2
		moveq	#0,d3
		move.w	d0,d3
		move.w	#72-1,d1	; 32+16+16+48+40+72 = 224
		add.w	d4,d1

loc_5C48:
		move.w	d3,d0
		neg.w	d0
		move.l	d0,(a1)+
		swap	d3
		add.l	d2,d3
		swap	d3
		dbf	d1,loc_5C48
		rts
; ---------------------------------------------------------------------------

Deform_GHZ_2P:
		move.w	(Camera_X_pos_diff).w,d4
		ext.l	d4
		asl.l	#5,d4
		move.l	d4,d1
		asl.l	#1,d4
		add.l	d1,d4
		moveq	#0,d6
		bsr.w	ScrollBlock6
		move.w	(Camera_X_pos_diff).w,d4
		ext.l	d4
		asl.l	#7,d4
		moveq	#0,d6
		bsr.w	ScrollBlock5
		lea	(v_hscrolltablebuffer).w,a1
		move.w	(Camera_Y_pos).w,d0
		andi.w	#$7FF,d0
		lsr.w	#5,d0
		neg.w	d0
		addi.w	#$20,d0
		bpl.s	loc_5C94
		moveq	#0,d0

loc_5C94:
		andi.w	#$FFFE,d0
		move.w	d0,d4
		lsr.w	#1,d4
		move.w	d0,(v_bgscrposy_vdp).w
		andi.l	#$FFFEFFFE,(v_scrposy_vdp).w
		move.w	(Camera_RAM).w,d0
		cmpi.b	#GameModeID_TitleScreen,(v_gamemode).w
		bne.s	loc_5CB6
		moveq	#0,d0

loc_5CB6:
		neg.w	d0
		swap	d0
		lea	(v_bgscroll_buffer).w,a2
		addi.l	#$10000,(a2)+
		addi.l	#$C000,(a2)+
		addi.l	#$8000,(a2)+
		move.w	(v_bgscroll_buffer).w,d0
		add.w	(Camera_BG3_X_pos).w,d0
		neg.w	d0
		move.w	#16-1,d1
		sub.w	d4,d1
		blo.s	loc_5CE8

loc_5CE2:
		move.l	d0,(a1)+
		dbf	d1,loc_5CE2

loc_5CE8:
		move.w	(v_bgscroll_buffer+4).w,d0
		add.w	(Camera_BG3_X_pos).w,d0
		neg.w	d0
		move.w	#8-1,d1

loc_5CF6:
		move.l	d0,(a1)+
		dbf	d1,loc_5CF6

		move.w	(v_bgscroll_buffer+8).w,d0
		add.w	(Camera_BG3_X_pos).w,d0
		neg.w	d0
		move.w	#8-1,d1

loc_5D0A:
		move.l	d0,(a1)+
		dbf	d1,loc_5D0A

		move.w	#24-1,d1
		move.w	(Camera_BG3_X_pos).w,d0
		neg.w	d0

loc_5D1A:
		move.l	d0,(a1)+
		dbf	d1,loc_5D1A

	if FixBugs
		move.w	#20-1,d1
	else
		; Bug: This does 24 lines, resulting in the deformation doing 4 extra lines.
		move.w	#24-1,d1
	endif
		move.w	(Camera_BG2_X_pos).w,d0
		neg.w	d0

loc_5D2A:
		move.l	d0,(a1)+
		dbf	d1,loc_5D2A

		move.w	(Camera_BG2_X_pos).w,d0
		move.w	(Camera_RAM).w,d2
		sub.w	d0,d2
		ext.l	d2
		asl.l	#8,d2
		divs.w	#$68,d2
		ext.l	d2
		asl.l	#8,d2
		add.l	d2,d2
		moveq	#0,d3
		move.w	d0,d3
	if FixBugs
		move.w	#36-1,d1	; 16+8+8+24+20+36 = 112
	else
		move.w	#36-1,d1	; 16+8+8+24+24+36 = 116 (incorrect, should be 112)
	endif
		add.w	d4,d1

loc_5D52:
		move.w	d3,d0
		neg.w	d0
		move.l	d0,(a1)+
		swap	d3
		add.l	d2,d3
		swap	d3
		dbf	d1,loc_5D52

; begin second player deformation
		move.w	(Camera_BG_Y_pos_diff).w,d4
		ext.l	d4
		asl.l	#5,d4
		move.l	d4,d1
		asl.l	#1,d4
		add.l	d1,d4
		add.l	d4,(Camera_BG3_X_pos_P2).w
		move.w	(Camera_BG_Y_pos_diff).w,d4
		ext.l	d4
		asl.l	#7,d4
		add.l	d4,(Camera_BG2_X_pos_P2).w
		lea	(v_hscrolltablebuffer+$1C0).w,a1
		move.w	(Camera_Y_pos_P2).w,d0
		andi.w	#$7FF,d0
		lsr.w	#5,d0
		neg.w	d0
		addi.w	#$20,d0
		bpl.s	loc_5D98
		moveq	#0,d0

loc_5D98:
		andi.w	#$FFFE,d0
		move.w	d0,d4
		lsr.w	#1,d4
		move.w	d0,(v_bg3scrposx_vdp).w
		subi.w	#224,(v_bg3scrposx_vdp).w
		move.w	(Camera_Y_pos_P2).w,(v_bg3scrposy_vdp).w
		subi.w	#224,(v_bg3scrposy_vdp).w
		andi.l	#$FFFEFFFE,(v_bg3scrposy_vdp).w
		move.w	(Camera_X_pos_P2).w,d0
		cmpi.b	#GameModeID_TitleScreen,(v_gamemode).w
		bne.s	loc_5DCC
		moveq	#0,d0

loc_5DCC:
		neg.w	d0
		swap	d0
		move.w	(v_bgscroll_buffer).w,d0
		add.w	(Camera_BG3_X_pos_P2).w,d0
		neg.w	d0
		move.w	#16-1,d1
		sub.w	d4,d1
		blo.s	loc_5DE8

loc_5DE2:
		move.l	d0,(a1)+
		dbf	d1,loc_5DE2

loc_5DE8:
		move.w	(v_bgscroll_buffer+4).w,d0
		add.w	(Camera_BG3_X_pos_P2).w,d0
		neg.w	d0
		move.w	#8-1,d1

loc_5DF6:
		move.l	d0,(a1)+
		dbf	d1,loc_5DF6

		move.w	(v_bgscroll_buffer+8).w,d0
		add.w	(Camera_BG3_X_pos_P2).w,d0
		neg.w	d0
		move.w	#8-1,d1

loc_5E0A:
		move.l	d0,(a1)+
		dbf	d1,loc_5E0A

		move.w	#24-1,d1
		move.w	(Camera_BG3_X_pos_P2).w,d0
		neg.w	d0

loc_5E1A:
		move.l	d0,(a1)+
		dbf	d1,loc_5E1A

	if FixBugs
		move.w	#20-1,d1
	else
		; Bug: This does 24 lines, resulting in the deformation doing 4 extra lines.
		move.w	#24-1,d1
	endif
		move.w	(Camera_BG2_X_pos_P2).w,d0
		neg.w	d0

loc_5E2A:
		move.l	d0,(a1)+
		dbf	d1,loc_5E2A

		move.w	(Camera_BG2_X_pos_P2).w,d0
		move.w	(Camera_X_pos_P2).w,d2
		sub.w	d0,d2
		ext.l	d2
		asl.l	#8,d2
		divs.w	#$68,d2
		ext.l	d2
		asl.l	#8,d2
		add.l	d2,d2
		moveq	#0,d3
		move.w	d0,d3
	if FixBugs
		move.w	#36-1,d1	; 16+8+8+24+20+36 = 112
	else
		move.w	#36-1,d1	; 16+8+8+24+24+36 = 116 (incorrect, should be 112)
	endif
		add.w	d4,d1

loc_5E52:
		move.w	d3,d0
		neg.w	d0
		move.l	d0,(a1)+
		swap	d3
		add.l	d2,d3
		swap	d3
		dbf	d1,loc_5E52

		rts
; ---------------------------------------------------------------------------

Deform_LZ:
		move.w	(Camera_X_pos_diff).w,d4
		ext.l	d4
		asl.l	#7,d4
		move.w	(Camera_Y_pos_diff).w,d5
		ext.l	d5
		asl.l	#7,d5
		bsr.w	ScrollBlock1
		move.w	(Camera_BG_Y_pos).w,(v_bgscrposy_vdp).w
		lea	(Deform_LZ_Data1).l,a3
		lea	(Obj0A_WobbleData).l,a2
		move.b	(v_lz_deform).w,d2
		move.b	d2,d3
		addi.w	#$80,(v_lz_deform).w
		add.w	(Camera_BG_Y_pos).w,d2
		andi.w	#$FF,d2
		add.w	(Camera_Y_pos).w,d3
		andi.w	#$FF,d3
		lea	(v_hscrolltablebuffer).w,a1
		move.w	#224-1,d1
		move.w	(Camera_RAM).w,d0
		neg.w	d0
		move.w	d0,d6
		swap	d0
		move.w	(Camera_BG_X_pos).w,d0
		neg.w	d0
		move.w	(v_waterpos1).w,d4
		move.w	(Camera_Y_pos).w,d5

loc_5EC6:
		cmp.w	d4,d5
		bge.s	loc_5ED8
		move.l	d0,(a1)+
		addq.w	#1,d5
		addq.b	#1,d2
		addq.b	#1,d3
		dbf	d1,loc_5EC6

		rts
; ---------------------------------------------------------------------------

loc_5ED8:
		move.b	(a3,d3.w),d4
		ext.w	d4
		add.w	d6,d4
		move.w	d4,(a1)+
		move.b	(a2,d2.w),d4
		ext.w	d4
		add.w	d0,d4
		move.w	d4,(a1)+
		addq.b	#1,d2
		addq.b	#1,d3
		dbf	d1,loc_5ED8

		rts
; ---------------------------------------------------------------------------
Deform_LZ_Data1:
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b $FF,$FF,$FE,$FE,$FD,$FD,$FD,$FD,$FE,$FE,$FF,$FF,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   1,  1,  2,  2,  3,  3,  3,  3,  2,  2,  1,  1,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0
		even
; ---------------------------------------------------------------------------

Deform_CPZ:
		move.w	(Camera_X_pos_diff).w,d4
		ext.l	d4
		asl.l	#5,d4
		move.w	(Camera_Y_pos_diff).w,d5
		ext.l	d5
		asl.l	#6,d5
		bsr.w	ScrollBlock1
		move.w	(Camera_BG_Y_pos).w,(v_bgscrposy_vdp).w
		lea	(v_hscrolltablebuffer).w,a1
		move.w	#224-1,d1
		move.w	(Camera_RAM).w,d0
		neg.w	d0
		swap	d0
		move.w	(Camera_BG_X_pos).w,d0
		neg.w	d0

loc_6026:
		move.l	d0,(a1)+
		dbf	d1,loc_6026

		rts
; ---------------------------------------------------------------------------

Deform_Unk:						; unknown BG deform
		move.w	(Camera_X_pos_diff).w,d4
		ext.l	d4
		asl.l	#5,d4
		move.w	(Camera_Y_pos_diff).w,d5
		ext.l	d5
		asl.l	#6,d5
		bsr.w	ScrollBlock1
		move.w	(Camera_X_pos_diff).w,d4
		ext.l	d4
		asl.l	#7,d4
		moveq	#4,d6
		bsr.w	ScrollBlock5
		move.w	(Camera_BG_Y_pos).w,(v_bgscrposy_vdp).w
		move.b	(Scroll_flags_BG).w,d0
		or.b	(Scroll_flags_BG2).w,d0
		move.b	d0,(Scroll_flags_BG3).w
		clr.b	(Scroll_flags_BG).w
		clr.b	(Scroll_flags_BG2).w
		lea	(v_bgscroll_buffer).w,a1
		move.w	(Camera_BG_X_pos).w,d0
		neg.w	d0
		move.w	#19-1,d1

loc_6078:
		move.w	d0,(a1)+
		dbf	d1,loc_6078

		move.w	(Camera_BG2_X_pos).w,d0
		neg.w	d0
		move.w	#29-1,d1

loc_6088:
		move.w	d0,(a1)+
		dbf	d1,loc_6088

		lea	(v_bgscroll_buffer).w,a2
		move.w	(Camera_BG_Y_pos).w,d0
		andi.w	#$3F0,d0
		lsr.w	#3,d0
		lea	(a2,d0.w),a2
		bra.w	Bg_Scroll_X

; =============== S U B	R O U T	I N E =======================================


Deform_TitleScreen:
		move.w	(Camera_BG_Y_pos).w,(v_bgscrposy_vdp).w
		move.w	(Camera_RAM).w,d0
		cmpi.w	#$1C00,d0
		bhs.s	loc_60B6
		addq.w	#8,d0

loc_60B6:
		move.w	d0,(Camera_RAM).w
		lea	(v_hscrolltablebuffer).w,a1
		move.w	(Camera_RAM).w,d2
		neg.w	d2
		moveq	#0,d0
		bra.s	loc_60E4
; ---------------------------------------------------------------------------

Deform_EHZ:
		tst.w	(Two_player_mode).w
		bne.w	Deform_EHZ_2P
		move.w	(Camera_BG_Y_pos).w,(v_bgscrposy_vdp).w
		lea	(v_hscrolltablebuffer).w,a1
		move.w	(Camera_RAM).w,d0
		neg.w	d0
		move.w	d0,d2
		swap	d0

loc_60E4:
		move.w	#0,d0
		move.w	#22-1,d1

loc_60EC:
		move.l	d0,(a1)+
		dbf	d1,loc_60EC

		move.w	d2,d0
		asr.w	#6,d0
		move.w	#58-1,d1

loc_60FA:
		move.l	d0,(a1)+
		dbf	d1,loc_60FA

		move.w	d0,d3
		move.b	(Vint_runcount+3).w,d1
		andi.w	#7,d1
		bne.s	loc_6110
		subq.w	#1,(v_bgscroll_buffer).w

loc_6110:
		move.w	(v_bgscroll_buffer).w,d1
		andi.w	#$1F,d1
		lea	(Deform_EHZ_Data).l,a2
		lea	(a2,d1.w),a2
		move.w	#21-1,d1

loc_6126:
		move.b	(a2)+,d0
		ext.w	d0
		add.w	d3,d0
		move.l	d0,(a1)+
		dbf	d1,loc_6126

		move.w	#0,d0
		move.w	#11-1,d1

loc_613A:
		move.l	d0,(a1)+
		dbf	d1,loc_613A

		move.w	d2,d0
		asr.w	#4,d0
		move.w	#16-1,d1

loc_6148:
		move.l	d0,(a1)+
		dbf	d1,loc_6148

		move.w	d2,d0
		asr.w	#4,d0
		move.w	d0,d1
		asr.w	#1,d1
		add.w	d1,d0
		move.w	#16-1,d1

loc_615C:
		move.l	d0,(a1)+
		dbf	d1,loc_615C

		move.l	d0,d4
		swap	d4
		move.w	d2,d0
		asr.w	#1,d0
		move.w	d2,d1
		asr.w	#3,d1
		sub.w	d1,d0
		ext.l	d0
		asl.l	#4,d0
		divs.w	#$30,d0
		ext.l	d0
		asl.l	#4,d0
		asl.l	#8,d0
		moveq	#0,d3
		move.w	d2,d3
		asr.w	#3,d3
		move.w	#15-1,d1

loc_6188:
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		swap	d3
		add.l	d0,d3
		swap	d3
		dbf	d1,loc_6188

		move.w	#18/2-1,d1

loc_619A:
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		swap	d3
		add.l	d0,d3
		add.l	d0,d3
		swap	d3
		dbf	d1,loc_619A

		move.w	#45/3-1,d1	; 22+58+21+11+16+16+15+18+45 = 222

loc_61B2:
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		swap	d3
		add.l	d0,d3
		add.l	d0,d3
		add.l	d0,d3
		swap	d3
		dbf	d1,loc_61B2

	if FixBugs
		rept 2
		move.w	d4,(a1)+
		move.w	d3,(a1)+
		endm
		; 22+58+21+11+16+16+15+18+45+2 = 224
	else
		; Bug: The last 2 pixels of the screen are not covered, resulting in very weird artifacting at the bottom of the screen.
	endif
		rts
; End of function Deform_TitleScreen

; ---------------------------------------------------------------------------
Deform_EHZ_Data:
		dc.b   1,  2,  1,  3,  1,  2,  2,  1,  2,  3,  1,  2,  1,  2,  0,  0
		dc.b   2,  0,  3,  2,  2,  3,  2,  2,  1,  3,  0,  0,  1,  0,  1,  3
		dc.b   1,  2,  1,  3,  1,  2,  2,  1,  2,  3,  1,  2,  1,  2,  0,  0
		dc.b   2,  0,  3,  2,  2,  3,  2,  2,  1,  3,  0,  0,  1,  0,  1,  3
		even
; ---------------------------------------------------------------------------

Deform_EHZ_2P:
		move.b	(Vint_runcount+3).w,d1
		andi.w	#7,d1
		bne.s	loc_621C
		subq.w	#1,(v_bgscroll_buffer).w

loc_621C:
		move.w	(Camera_BG_Y_pos).w,(v_bgscrposy_vdp).w
		andi.l	#$FFFEFFFE,(v_scrposy_vdp).w
		lea	(v_hscrolltablebuffer).w,a1
		move.w	(Camera_RAM).w,d0
		move.w	#11-1,d1
		bsr.s	sub_6264	; do first player deformation
		; first player deformation height = 11+29+11+5+8+8+40 = 112
		moveq	#0,d0
		move.w	d0,(v_bg3scrposx_vdp).w
		subi.w	#224,(v_bg3scrposx_vdp).w
		move.w	(Camera_Y_pos_P2).w,(v_bg3scrposy_vdp).w
		subi.w	#224,(v_bg3scrposy_vdp).w
		andi.l	#$FFFEFFFE,(v_bg3scrposy_vdp).w
	if FixBugs
		; We will optimize the deformation for the second player so that it doesn't unnecessarily deform layers that the user can't see.
		lea	(v_hscrolltablebuffer+224*2).w,a1
	else
		lea	(v_hscrolltablebuffer+216*2).w,a1
	endif
		move.w	(Camera_X_pos_P2).w,d0
	if FixBugs
		move.w	#11-1,d1	; do second player deformation
		; second player deformation height = 11+29+11+5+8+8+40 = 112
	else
		move.w	#(11+4)-1,d1	; do second player deformation
		; second player deformation height = 11+29+11+5+8+8+40 = 112
	endif

; =============== S U B	R O U T	I N E =======================================


sub_6264:
		neg.w	d0
		move.w	d0,d2
		swap	d0
		move.w	#0,d0

loc_626E:
		move.l	d0,(a1)+
		dbf	d1,loc_626E

		move.w	d2,d0
		asr.w	#6,d0
		move.w	#29-1,d1

loc_627C:
		move.l	d0,(a1)+
		dbf	d1,loc_627C

		move.w	d0,d3
		move.w	(v_bgscroll_buffer).w,d1
		andi.w	#$1F,d1
		lea	Deform_EHZ_Data(pc),a2
		lea	(a2,d1.w),a2
		move.w	#11-1,d1

loc_6298:
		move.b	(a2)+,d0
		ext.w	d0
		add.w	d3,d0
		move.l	d0,(a1)+
		dbf	d1,loc_6298

		move.w	#0,d0
		move.w	#5-1,d1

loc_62AC:
		move.l	d0,(a1)+
		dbf	d1,loc_62AC

		move.w	d2,d0
		asr.w	#4,d0
		move.w	#8-1,d1

loc_62BA:
		move.l	d0,(a1)+
		dbf	d1,loc_62BA

		move.w	d2,d0
		asr.w	#4,d0
		move.w	d0,d1
		asr.w	#1,d1
		add.w	d1,d0
		move.w	#8-1,d1

loc_62CE:
		move.l	d0,(a1)+
		dbf	d1,loc_62CE

		move.w	d2,d0
		asr.w	#1,d0
		move.w	d2,d1
		asr.w	#3,d1
		sub.w	d1,d0
		ext.l	d0
		asl.l	#4,d0
		divs.w	#$30,d0
		ext.l	d0
		asl.l	#4,d0
		asl.l	#8,d0
		moveq	#0,d3
		move.w	d2,d3
		asr.w	#3,d3
		move.w	#40-1,d1

loc_62F6:
		move.w	d2,(a1)+
		move.w	d3,(a1)+
		swap	d3
		add.l	d0,d3
		swap	d3
		dbf	d1,loc_62F6

		rts
; End of function sub_6264

; ---------------------------------------------------------------------------

Bg_Scroll_X:
		lea	(v_hscrolltablebuffer).w,a1
		move.w	#224/16+1-1,d1
		move.w	(Camera_RAM).w,d0
		neg.w	d0
		swap	d0
		andi.w	#$F,d2
		add.w	d2,d2
		move.w	(a2)+,d0
		jmp	loc_6324(pc,d2.w)
; ---------------------------------------------------------------------------

loc_6322:
		move.w	(a2)+,d0

loc_6324:
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,loc_6322
		rts
; ---------------------------------------------------------------------------

Deform_HPZ:
		move.w	(Camera_X_pos_diff).w,d4
		ext.l	d4
		asl.l	#6,d4
		moveq	#2,d6
		bsr.w	ScrollBlock4
		move.w	(Camera_Y_pos_diff).w,d5
		ext.l	d5
		asl.l	#7,d5
		moveq	#6,d6
		bsr.w	ScrollBlock2

		; Update the background's vertical scrolling.
		move.w	(Camera_BG_Y_pos).w,(v_bgscrposy_vdp).w

		; Rather than scroll each individual line of the background, this
		; zone scrolls entire blocks of lines (16 lines) at once. The scroll
		; value of each row is written to 'TempArray_LayerDef', before it is
		; applied to 'Horiz_Scroll_Buf' in 'Deform_HPZ_Continued'. This is
		; vaguely similar to how Chemical Plant Zone scrolls its background,
		; even overflowing 'Horiz_Scroll_Buf' in the same way.
		lea	(v_bgscroll_buffer).w,a1
		move.w	(Camera_RAM).w,d2
		neg.w	d2

		; Do 8 line blocks.
		move.w	d2,d0
		asr.w	#1,d0
		move.w	#8-1,d1

loc_637E:
		move.w	d0,(a1)+
		dbf	d1,loc_637E

		move.w	d2,d0
		asr.w	#3,d0
		sub.w	d2,d0
		ext.l	d0
		asl.l	#3,d0
		divs.w	#8,d0	; this could be replaced with asr.w #3,d0 to save 150 cycles and 2 bytes of space
		ext.l	d0
		asl.l	#4,d0
		asl.l	#8,d0
		moveq	#0,d3
		move.w	d2,d3
		asr.w	#1,d3
		lea	(v_bgscroll_buffer+(8+7+26+7)*2).w,a2
		swap	d3
		add.l	d0,d3
		swap	d3
		move.w	d3,(a1)+
		move.w	d3,(a1)+
		move.w	d3,(a1)+
		move.w	d3,-(a2)
		move.w	d3,-(a2)
		move.w	d3,-(a2)
		swap	d3
		add.l	d0,d3
		swap	d3
		move.w	d3,(a1)+
		move.w	d3,(a1)+
		move.w	d3,-(a2)
		move.w	d3,-(a2)
		swap	d3
		add.l	d0,d3
		swap	d3
		move.w	d3,(a1)+
		move.w	d3,-(a2)
		swap	d3
		add.l	d0,d3
		swap	d3
		move.w	d3,(a1)+
		move.w	d3,-(a2)

		; Do 26 line blocks.
		move.w	(Camera_BG_X_pos).w,d0
		neg.w	d0
		move.w	#26-1,d1

loc_63E0:
		move.w	d0,(a1)+
		dbf	d1,loc_63E0

		; Skip 7 line blocks which were done earlier.
		adda.w	#7*2,a1

		; Do 24 line blocks.
		move.w	d2,d0
		asr.w	#1,d0
		move.w	#24-1,d1

loc_63F2:
		move.w	d0,(a1)+
		dbf	d1,loc_63F2

		lea	(v_bgscroll_buffer).w,a2
		move.w	(Camera_BG_Y_pos).w,d0
		move.w	d0,d2
		andi.w	#$3F0,d0
		lsr.w	#3,d0
		lea	(a2,d0.w),a2
		bra.w	Bg_Scroll_X
; ---------------------------------------------------------------------------

Deform_HTZ:
		move.w	(Camera_BG_Y_pos).w,(v_bgscrposy_vdp).w
		lea	(v_hscrolltablebuffer).w,a1
		move.w	(Camera_RAM).w,d0
		neg.w	d0
		move.w	d0,d2
		swap	d0
		move.w	d2,d0
		asr.w	#3,d0
		move.w	#128-1,d1

loc_642C:
		move.l	d0,(a1)+
		dbf	d1,loc_642C

		move.l	d0,d4
		move.w	d2,d0
		asr.w	#1,d0
		move.w	d2,d1
		asr.w	#3,d1
		sub.w	d1,d0
		ext.l	d0
		asl.l	#4,d0
		divs.w	#$18,d0
		ext.l	d0
		asl.l	#4,d0
		asl.l	#8,d0
		moveq	#0,d3
		move.w	d2,d3
		asr.w	#3,d3
		swap	d3
		add.l	d0,d3
		swap	d3
		move.w	d3,d4
		move.l	d4,(a1)+
		move.l	d4,(a1)+
		move.l	d4,(a1)+
		swap	d3
		add.l	d0,d3
		swap	d3
		move.w	d3,d4
		move.l	d4,(a1)+
		move.l	d4,(a1)+
		move.l	d4,(a1)+
		move.l	d4,(a1)+
		move.l	d4,(a1)+
		swap	d3
		add.l	d0,d3
		swap	d3
		move.w	d3,d4
		move.w	#7-1,d1

loc_647E:
		move.l	d4,(a1)+
		dbf	d1,loc_647E

		swap	d3
		add.l	d0,d3
		add.l	d0,d3
		swap	d3
		move.w	d3,d4
		move.w	#8-1,d1

loc_6492:
		move.l	d4,(a1)+
		dbf	d1,loc_6492

		swap	d3
		add.l	d0,d3
		add.l	d0,d3
		swap	d3
		move.w	d3,d4
		move.w	#10-1,d1

loc_64A6:
		move.l	d4,(a1)+
		dbf	d1,loc_64A6

		swap	d3
		add.l	d0,d3
		add.l	d0,d3
		add.l	d0,d3
		swap	d3
		move.w	d3,d4
		move.w	#15-1,d1

loc_64BC:
		move.l	d4,(a1)+
		dbf	d1,loc_64BC

		swap	d3
		add.l	d0,d3
		add.l	d0,d3
		add.l	d0,d3
		swap	d3
		move.w	#3-1,d2		; 128+1+1+1+1+1+1+1+1+7+8+10+15+(16*3) = 224

loc_64D0:
		move.w	d3,d4
		move.w	#16-1,d1

loc_64D6:
		move.l	d4,(a1)+
		dbf	d1,loc_64D6

		swap	d3
		add.l	d0,d3
		add.l	d0,d3
		add.l	d0,d3
		add.l	d0,d3
		swap	d3
		dbf	d2,loc_64D0

		rts

; =============== S U B	R O U T	I N E =======================================


ScrollHorizontal:
		move.w	(a1),d4
		bsr.s	ScrollHoriz
		move.w	(a1),d0
		andi.w	#16,d0
		move.b	(a2),d1
		eor.b	d1,d0
		bne.s	locret_6512
		eori.b	#16,(a2)
		move.w	(a1),d0
		sub.w	d4,d0
		bpl.s	loc_650E
		bset	#2,(a3)
		rts
; ---------------------------------------------------------------------------

loc_650E:
		bset	#3,(a3)

locret_6512:
		rts
; End of function ScrollHorizontal


; =============== S U B	R O U T	I N E =======================================

;sub_6514:
ScrollHoriz:
	if FixBugs
		; To prevent the bug that is described above, this caps the position
		; array index offset so that it does not access position data from
		; before the spin dash was performed. Note that this required
		; modifications to 'Sonic_UpdateSpindash' and 'Tails_UpdateSpindash'.
		move.b	Horiz_scroll_delay_val-Camera_Delay(a5),d1	; should scrolling be delayed?
		beq.s	.scrollNotDelayed				; if not, branch
		lsl.b	#2,d1		; multiply by 4, the size of a position buffer entry
		subq.b	#1,Horiz_scroll_delay_val-Camera_Delay(a5)	; reduce delay value
		move.b	Sonic_Pos_Record_Index+1-Camera_Delay(a5),d0
		sub.b	Horiz_scroll_delay_val+1-Camera_Delay(a5),d0
		cmp.b	d0,d1
		blo.s	.doNotCap
		move.b	d0,d1
.doNotCap:
	else
		; The intent of this code is to make the camera briefly lag behind the
		; player right after releasing a spin dash, however it does this by
		; simply making the camera use position data from previous frames. This
		; means that if the camera had been moving recently enough, then
		; releasing a spin dash will cause the camera to jerk around instead of
		; remain still. This can be encountered by running into a wall, and
		; quickly turning around and spin dashing away. Sonic 3 would have had
		; this same issue with the Fire Shield's dash abiliity, but it shoddily
		; works around the issue by resetting the old position values to the
		; current position (see 'Reset_Player_Position_Array').
		move.w	Horiz_scroll_delay_val-Camera_Delay(a5),d1	; should scrolling be delayed?
		beq.s	.scrollNotDelayed				; if not, branch
		subi.w	#$100,d1					; reduce delay value
		move.w	d1,Horiz_scroll_delay_val-Camera_Delay(a5)
		moveq	#0,d1
		move.b	Horiz_scroll_delay_val-Camera_Delay(a5),d1	; get delay value
		lsl.b	#2,d1		; multiply by 4, the size of a position buffer entry
		addq.b	#4,d1
	endif

		move.w	Sonic_Pos_Record_Index-Camera_Delay(a5),d0
		sub.b	d1,d0
		move.w	(a6,d0.w),d0
		andi.w	#$3FFF,d0
		bra.s	.checkIfShouldScroll
; ---------------------------------------------------------------------------

.scrollNotDelayed:
		move.w	obX(a0),d0

.checkIfShouldScroll:
		sub.w	(a1),d0
		subi.w	#(320/2)-16,d0
		blt.s	.scrollLeft
		subi.w	#16,d0
		bge.s	.scrollRight
		clr.w	(a4)
		rts
; ---------------------------------------------------------------------------

.scrollLeft:
		cmpi.w	#-16,d0
		bgt.s	.maxNotReached
		move.w	#-16,d0

.maxNotReached:
		add.w	(a1),d0
		cmp.w	(Camera_Min_X_pos).w,d0
		bgt.s	.doScroll
		move.w	(Camera_Min_X_pos).w,d0
		bra.s	.doScroll
; ---------------------------------------------------------------------------

.scrollRight:
		cmpi.w	#16,d0
		blo.s	.maxNotReached2
		move.w	#16,d0

.maxNotReached2:
		add.w	(a1),d0
		cmp.w	(Camera_Max_X_pos).w,d0
		blt.s	.doScroll
		move.w	(Camera_Max_X_pos).w,d0

.doScroll:
		move.w	d0,d1
		sub.w	(a1),d1
		asl.w	#8,d1
		move.w	d0,(a1)
		move.w	d1,(a4)
		rts
; End of function ScrollHoriz


; =============== S U B	R O U T	I N E =======================================


ScrollVertical:
		moveq	#0,d1
		move.w	obY(a0),d0
		sub.w	(a1),d0
		btst	#2,obStatus(a0)
		beq.s	loc_6598
		subq.w	#5,d0

loc_6598:
		btst	#1,obStatus(a0)
		beq.s	loc_65B8
		addi.w	#32,d0
		sub.w	(Camera_Y_pos_bias).w,d0
		blo.s	loc_6602
		subi.w	#64,d0
		bhs.s	loc_6602
		tst.b	(Camera_Max_Y_Pos_Changing).w
		bne.s	loc_6614
		bra.s	loc_65C4
; ---------------------------------------------------------------------------

loc_65B8:
		sub.w	(Camera_Y_pos_bias).w,d0
		bne.s	loc_65C8
		tst.b	(Camera_Max_Y_Pos_Changing).w
		bne.s	loc_6614

loc_65C4:
		clr.w	(a4)
		rts
; ---------------------------------------------------------------------------

loc_65C8:
		cmpi.w	#$60,(Camera_Y_pos_bias).w
		bne.s	loc_65F0
		move.w	obInertia(a0),d1
		bpl.s	loc_65D8
		neg.w	d1

loc_65D8:
		cmpi.w	#$800,d1
		bhs.s	loc_6602
		move.w	#$600,d1
		cmpi.w	#6,d0
		bgt.s	loc_665C
		cmpi.w	#-6,d0
		blt.s	loc_662A
		bra.s	loc_661A
; ---------------------------------------------------------------------------

loc_65F0:
		move.w	#$200,d1
		cmpi.w	#2,d0
		bgt.s	loc_665C
		cmpi.w	#-2,d0
		blt.s	loc_662A
		bra.s	loc_661A
; ---------------------------------------------------------------------------

loc_6602:
		move.w	#$1000,d1
		cmpi.w	#16,d0
		bgt.s	loc_665C
		cmpi.w	#-16,d0
		blt.s	loc_662A
		bra.s	loc_661A
; ---------------------------------------------------------------------------

loc_6614:
		moveq	#0,d0
		move.b	d0,(Camera_Max_Y_Pos_Changing).w

loc_661A:
		moveq	#0,d1
		move.w	d0,d1
		add.w	(a1),d1
		tst.w	d0
		bpl.w	loc_6664
		bra.w	loc_6634
; ---------------------------------------------------------------------------

loc_662A:
		neg.w	d1
		ext.l	d1
		asl.l	#8,d1
		add.l	(a1),d1
		swap	d1

loc_6634:
		cmp.w	(Camera_Min_Y_pos).w,d1
		bgt.s	loc_6686
		cmpi.w	#$FF00,d1
		bgt.s	loc_6656
		andi.w	#$7FF,d1
		andi.w	#$7FF,obY(a0)
		andi.w	#$7FF,(a1)
		andi.w	#$3FF,obX(a1)
		bra.s	loc_6686
; ---------------------------------------------------------------------------

loc_6656:
		move.w	(Camera_Min_Y_pos).w,d1
		bra.s	loc_6686
; ---------------------------------------------------------------------------

loc_665C:
		ext.l	d1
		asl.l	#8,d1
		add.l	(a1),d1
		swap	d1

loc_6664:
		cmp.w	(Camera_Max_Y_pos).w,d1
		blt.s	loc_6686
		subi.w	#$800,d1
		blo.s	loc_6682
		andi.w	#$7FF,obY(a0)
		subi.w	#$800,(a1)
		andi.w	#$3FF,obX(a1)
		bra.s	loc_6686
; ---------------------------------------------------------------------------

loc_6682:
		move.w	(Camera_Max_Y_pos).w,d1

loc_6686:
		move.w	(a1),d4
		swap	d1
		move.l	d1,d3
		sub.l	(a1),d3
		ror.l	#8,d3
		move.w	d3,(a4)
		move.l	d1,(a1)
		move.w	(a1),d0
		andi.w	#16,d0
		move.b	(a2),d1
		eor.b	d1,d0
		bne.s	locret_66B4
		eori.b	#16,(a2)
		move.w	(a1),d0
		sub.w	d4,d0
		bpl.s	loc_66B0
		bset	#0,(a3)
		rts
; ---------------------------------------------------------------------------

loc_66B0:
		bset	#1,(a3)

locret_66B4:
		rts
; End of function ScrollVertical


; =============== S U B	R O U T	I N E =======================================


ScrollBlock1:
		move.l	(Camera_BG_X_pos).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(Camera_BG_X_pos).w
		move.l	d0,d1
		swap	d1
		andi.w	#16,d1
		move.b	(Horiz_block_crossed_flag_BG).w,d3
		eor.b	d3,d1
		bne.s	loc_66EA
		eori.b	#16,(Horiz_block_crossed_flag_BG).w
		sub.l	d2,d0
		bpl.s	loc_66E4
		bset	#2,(Scroll_flags_BG).w
		bra.s	loc_66EA
; ---------------------------------------------------------------------------

loc_66E4:
		bset	#3,(Scroll_flags_BG).w

loc_66EA:
		move.l	(Camera_BG_Y_pos).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(Camera_BG_Y_pos).w
		move.l	d0,d1
		swap	d1
		andi.w	#16,d1
		move.b	(Verti_block_crossed_flag_BG).w,d2
		eor.b	d2,d1
		bne.s	locret_671E
		eori.b	#16,(Verti_block_crossed_flag_BG).w
		sub.l	d3,d0
		bpl.s	loc_6718
		bset	#0,(Scroll_flags_BG).w
		rts
; ---------------------------------------------------------------------------

loc_6718:
		bset	#1,(Scroll_flags_BG).w

locret_671E:
		rts
; End of function ScrollBlock1


; =============== S U B	R O U T	I N E =======================================


ScrollBlock2:
		move.l	(Camera_BG_Y_pos).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(Camera_BG_Y_pos).w
		move.l	d0,d1
		swap	d1
		andi.w	#16,d1
		move.b	(Verti_block_crossed_flag_BG).w,d2
		eor.b	d2,d1
		bne.s	locret_6752
		eori.b	#16,(Verti_block_crossed_flag_BG).w
		sub.l	d3,d0
		bpl.s	loc_674C
		bset	d6,(Scroll_flags_BG).w
		rts
; ---------------------------------------------------------------------------

loc_674C:
		addq.b	#1,d6
		bset	d6,(Scroll_flags_BG).w

locret_6752:
		rts
; End of function ScrollBlock2

; ---------------------------------------------------------------------------

ScrollBlock3:
		move.w	(Camera_BG_Y_pos).w,d3
		move.w	d0,(Camera_BG_Y_pos).w
		move.w	d0,d1
		andi.w	#16,d1
		move.b	(Verti_block_crossed_flag_BG).w,d2
		eor.b	d2,d1
		bne.s	locret_6782
		eori.b	#16,(Verti_block_crossed_flag_BG).w
		sub.w	d3,d0
		bpl.s	loc_677C
		bset	#0,(Scroll_flags_BG).w
		rts
; ---------------------------------------------------------------------------

loc_677C:
		bset	#1,(Scroll_flags_BG).w

locret_6782:
		rts

; =============== S U B	R O U T	I N E =======================================


ScrollBlock4:
		move.l	(Camera_BG_X_pos).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(Camera_BG_X_pos).w
		move.l	d0,d1
		swap	d1
		andi.w	#16,d1
		move.b	(Horiz_block_crossed_flag_BG).w,d3
		eor.b	d3,d1
		bne.s	locret_67B6
		eori.b	#16,(Horiz_block_crossed_flag_BG).w
		sub.l	d2,d0
		bpl.s	loc_67B0
		bset	d6,(Scroll_flags_BG).w
		bra.s	locret_67B6
; ---------------------------------------------------------------------------

loc_67B0:
		addq.b	#1,d6
		bset	d6,(Scroll_flags_BG).w

locret_67B6:
		rts
; End of function ScrollBlock4


; =============== S U B	R O U T	I N E =======================================


ScrollBlock5:
		move.l	(Camera_BG2_X_pos).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(Camera_BG2_X_pos).w
		move.l	d0,d1
		swap	d1
		andi.w	#16,d1
		move.b	(Horiz_block_crossed_flag_BG2).w,d3
		eor.b	d3,d1
		bne.s	locret_67EA
		eori.b	#16,(Horiz_block_crossed_flag_BG2).w
		sub.l	d2,d0
		bpl.s	loc_67E4
		bset	d6,(Scroll_flags_BG2).w
		bra.s	locret_67EA
; ---------------------------------------------------------------------------

loc_67E4:
		addq.b	#1,d6
		bset	d6,(Scroll_flags_BG2).w

locret_67EA:
		rts
; End of function ScrollBlock5


; =============== S U B	R O U T	I N E =======================================


ScrollBlock6:
		move.l	(Camera_BG3_X_pos).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(Camera_BG3_X_pos).w
		move.l	d0,d1
		swap	d1
		andi.w	#16,d1
		move.b	(Horiz_block_crossed_flag_BG3).w,d3
		eor.b	d3,d1
		bne.s	locret_681E
		eori.b	#16,(Horiz_block_crossed_flag_BG3).w
		sub.l	d2,d0
		bpl.s	loc_6818
		bset	d6,(Scroll_flags_BG3).w
		bra.s	locret_681E
; ---------------------------------------------------------------------------

loc_6818:
		addq.b	#1,d6
		bset	d6,(Scroll_flags_BG3).w

locret_681E:
		rts
; End of function ScrollBlock6