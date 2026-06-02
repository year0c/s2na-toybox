; ---------------------------------------------------------------------------
; Leftover Sonic 1 Routine
; LoadTilesAsYouMove_BGOnly:
		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		lea	(Scroll_flags_BG).w,a2
		lea	(Camera_BG_X_pos).w,a3
		lea	(v_lvllayoutbg).w,a4
		move.w	#$6000,d2
		bsr.w	DrawBGScrollBlock1
		lea	(Scroll_flags_BG2).w,a2
		lea	(Camera_BG2_X_pos).w,a3
		bra.w	DrawBGScrollBlock2

; =============== S U B	R O U T	I N E =======================================


LoadTilesAsYouMove:
		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		lea	(Scroll_flags_BG_copy).w,a2
		lea	(Camera_BG_copy).w,a3
		lea	(v_lvllayoutbg).w,a4
		move.w	#$6000,d2
		bsr.w	DrawBGScrollBlock1
		lea	(Scroll_flags_BG2_copy).w,a2
		lea	(Camera_BG2_copy).w,a3
		bsr.w	DrawBGScrollBlock2
		lea	(Scroll_flags_BG3_copy).w,a2
		lea	(Camera_BG3_copy).w,a3
		bsr.w	DrawBGScrollBlock3
		tst.w	(Two_player_mode).w
		beq.s	loc_689E
		lea	(Scroll_flags_copy_P2).w,a2
		lea	(Camera_P2_copy).w,a3
		lea	(v_lvllayout).w,a4
		move.w	#$6000,d2
		bsr.w	sub_694C

loc_689E:
		lea	(Scroll_flags_copy).w,a2
		lea	(Camera_RAM_copy).w,a3
		lea	(v_lvllayout).w,a4
		move.w	#$4000,d2
		tst.b	(Screen_redraw_flag).w
		beq.s	loc_68E6
		move.b	#0,(Screen_redraw_flag).w
		moveq	#-16,d4
		moveq	#((224+16+16)/16)-1,d6

loc_68BE:
		movem.l	d4-d6,-(sp)
		moveq	#-16,d5
		move.w	d4,d1
		bsr.w	Calc_VRAM_Pos
		move.w	d1,d4
		moveq	#-16,d5
		bsr.w	DrawBlocks_LR
		movem.l	(sp)+,d4-d6
		addi.w	#16,d4
		dbf	d6,loc_68BE
		move.b	#0,(Scroll_flags_copy).w
		rts
; ---------------------------------------------------------------------------

loc_68E6:
		tst.b	(a2)
		beq.s	locret_694A
		bclr	#0,(a2)
		beq.s	loc_6900
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	DrawBlocks_LR

loc_6900:
		bclr	#1,(a2)
		beq.s	loc_691A
		move.w	#224,d4
		moveq	#-16,d5
		bsr.w	Calc_VRAM_Pos
		move.w	#224,d4
		moveq	#-16,d5
		bsr.w	DrawBlocks_LR

loc_691A:
		bclr	#2,(a2)
		beq.s	loc_6930
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	sub_6CFE

loc_6930:
		bclr	#3,(a2)
		beq.s	locret_694A
		moveq	#-16,d4
		move.w	#320,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-16,d4
		move.w	#320,d5
		bsr.w	sub_6CFE

locret_694A:
		rts
; End of function LoadTilesAsYouMove


; =============== S U B	R O U T	I N E =======================================


sub_694C:
		tst.b	(a2)
		beq.s	locret_69B0
		bclr	#0,(a2)
		beq.s	loc_6966
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	sub_70C0
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	DrawBlocks_LR

loc_6966:
		bclr	#1,(a2)
		beq.s	loc_6980
		move.w	#224,d4
		moveq	#-16,d5
		bsr.w	sub_70C0
		move.w	#224,d4
		moveq	#-16,d5
		bsr.w	DrawBlocks_LR

loc_6980:
		bclr	#2,(a2)
		beq.s	loc_6996
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	sub_70C0
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	sub_6CFE

loc_6996:
		bclr	#3,(a2)
		beq.s	locret_69B0
		moveq	#-16,d4
		move.w	#320,d5
		bsr.w	sub_70C0
		moveq	#-16,d4
		move.w	#320,d5
		bsr.w	sub_6CFE

locret_69B0:
		rts
; End of function sub_694C


; =============== S U B	R O U T	I N E =======================================

DrawBGScrollBlock1:
		tst.b	(a2)
		beq.w	locret_6A80
		bclr	#0,(a2)
		beq.s	loc_69CE
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	DrawBlocks_LR

loc_69CE:
		bclr	#1,(a2)
		beq.s	loc_69E8
		move.w	#224,d4
		moveq	#-16,d5
		bsr.w	Calc_VRAM_Pos
		move.w	#224,d4
		moveq	#-16,d5
		bsr.w	DrawBlocks_LR

loc_69E8:
		bclr	#2,(a2)
		beq.s	loc_69FE
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	sub_6CFE

loc_69FE:
		bclr	#3,(a2)
		beq.s	loc_6A18
		moveq	#-16,d4
		move.w	#320,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-16,d4
		move.w	#320,d5
		bsr.w	sub_6CFE

loc_6A18:
		bclr	#4,(a2)
		beq.s	loc_6A30
		moveq	#-16,d4
		moveq	#0,d5
		bsr.w	Calc_VRAM_Pos_2
		moveq	#-16,d4
		moveq	#0,d5
		moveq	#(512/16)-1,d6
		bsr.w	DrawBlocks_LR_3

loc_6A30:
		bclr	#5,(a2)
		beq.s	loc_6A4C
		move.w	#224,d4
		moveq	#0,d5
		bsr.w	Calc_VRAM_Pos_2
		move.w	#224,d4
		moveq	#0,d5
		moveq	#(512/16)-1,d6
		bsr.w	DrawBlocks_LR_3

loc_6A4C:
		bclr	#6,(a2)
		beq.s	loc_6A64
		moveq	#-16,d4
		moveq	#-16,d5
		bsr.w	Calc_VRAM_Pos
		moveq	#-16,d4
		moveq	#-16,d5
		moveq	#(512/16)-1,d6
		bsr.w	DrawBlocks_LR_2

loc_6A64:
		bclr	#7,(a2)
		beq.s	locret_6A80
		move.w	#224,d4
		moveq	#-16,d5
		bsr.w	Calc_VRAM_Pos
		move.w	#224,d4
		moveq	#-16,d5
		moveq	#(512/16)-1,d6
		bsr.w	DrawBlocks_LR_2

locret_6A80:
		rts
; End of function DrawBGScrollBlock1


; =============== S U B	R O U T	I N E =======================================


DrawBGScrollBlock2:
		tst.b	(a2)
		beq.w	locret_6ACE
		cmpi.b	#id_SBZ,(Current_Zone).w
		beq.w	Draw_SBz
		bclr	#0,(a2)
		beq.s	loc_6AAE
		move.w	#224/2,d4
		moveq	#-16,d5
		bsr.w	Calc_VRAM_Pos
		move.w	#224/2,d4
		moveq	#-16,d5
		moveq	#3-1,d6
		bsr.w	DrawBlocks_TB_2

loc_6AAE:
		bclr	#1,(a2)
		beq.s	locret_6ACE
		move.w	#224/2,d4
		move.w	#320,d5
		bsr.w	Calc_VRAM_Pos
		move.w	#224/2,d4
		move.w	#320,d5
		moveq	#3-1,d6
		bsr.w	DrawBlocks_TB_2

locret_6ACE:
		rts
; ---------------------------------------------------------------------------
byte_6AD0:	dc.b 0
		dc.b   0,  0,  0,  0,  6,  6,  6,  6,  6,  6,  6,  6,  6,  6,  4,  4
		dc.b   4,  4,  4,  4,  4,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2
		even
; ---------------------------------------------------------------------------

Draw_SBz:
		moveq	#-16,d4
		bclr	#0,(a2)
		bne.s	loc_6B04
		bclr	#1,(a2)
		beq.s	loc_6B4C
		move.w	#224,d4

loc_6B04:
		lea	byte_6AD0+1(pc),a0
		move.w	(Camera_BG_Y_pos).w,d0
		add.w	d4,d0
		andi.w	#$1F0,d0
		lsr.w	#4,d0
		move.b	(a0,d0.w),d0
		lea	(word_6C78).l,a3
		movea.w	(a3,d0.w),a3
		beq.s	loc_6B38
		moveq	#-16,d5
		movem.l	d4-d5,-(sp)
		bsr.w	Calc_VRAM_Pos
		movem.l	(sp)+,d4-d5
		bsr.w	DrawBlocks_LR
		bra.s	loc_6B4C
; ---------------------------------------------------------------------------

loc_6B38:
		moveq	#0,d5
		movem.l	d4-d5,-(sp)
		bsr.w	Calc_VRAM_Pos_2
		movem.l	(sp)+,d4-d5
		moveq	#(512/16)-1,d6
		bsr.w	DrawBlocks_LR_3

loc_6B4C:
		tst.b	(a2)
		bne.s	loc_6B52
		rts
; ---------------------------------------------------------------------------

loc_6B52:
		moveq	#-16,d4
		moveq	#-16,d5
		move.b	(a2),d0
		andi.b	#$A8,d0
		beq.s	loc_6B66
		lsr.b	#1,d0
		move.b	d0,(a2)
		move.w	#320,d5

loc_6B66:
		lea	byte_6AD0(pc),a0
		move.w	(Camera_BG_Y_pos).w,d0
		andi.w	#$1F0,d0
		lsr.w	#4,d0
		lea	(a0,d0.w),a0
		bra.w	loc_6C80
; End of function DrawBGScrollBlock2


; =============== S U B	R O U T	I N E =======================================


DrawBGScrollBlock3:
		tst.b	(a2)
		beq.w	locret_6BC8
		cmpi.b	#id_MZ,(Current_Zone).w
		beq.w	Draw_Mz
		bclr	#0,(a2)
		beq.s	loc_6BA8
		move.w	#64,d4
		moveq	#-16,d5
		bsr.w	Calc_VRAM_Pos
		move.w	#64,d4
		moveq	#-16,d5
		moveq	#3-1,d6
		bsr.w	DrawBlocks_TB_2

loc_6BA8:
		bclr	#1,(a2)
		beq.s	locret_6BC8
		move.w	#64,d4
		move.w	#320,d5
		bsr.w	Calc_VRAM_Pos
		move.w	#64,d4
		move.w	#320,d5
		moveq	#3-1,d6
		bsr.w	DrawBlocks_TB_2

locret_6BC8:
		rts
; ---------------------------------------------------------------------------
byte_6BCA:	dc.b 0
		dc.b   2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2
		dc.b   2,  2,  2,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4
		dc.b   4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4
		dc.b   4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4,  4
		even
; ---------------------------------------------------------------------------

Draw_Mz:
		moveq	#-16,d4
		bclr	#0,(a2)
		bne.s	loc_6C1E
		bclr	#1,(a2)
		beq.s	loc_6C48
		move.w	#224,d4

loc_6C1E:
		lea	byte_6BCA+1(pc),a0
		move.w	(Camera_BG_Y_pos).w,d0
		add.w	d4,d0
		andi.w	#$3F0,d0
		lsr.w	#4,d0
		move.b	(a0,d0.w),d0
		movea.w	word_6C78(pc,d0.w),a3
		moveq	#-16,d5
		movem.l	d4-d5,-(sp)
		bsr.w	Calc_VRAM_Pos
		movem.l	(sp)+,d4-d5
		bsr.w	DrawBlocks_LR

loc_6C48:
		tst.b	(a2)
		bne.s	loc_6C4E
		rts
; ---------------------------------------------------------------------------

loc_6C4E:
		moveq	#-16,d4
		moveq	#-16,d5
		move.b	(a2),d0
		andi.b	#$A8,d0
		beq.s	loc_6C62
		lsr.b	#1,d0
		move.b	d0,(a2)
		move.w	#320,d5

loc_6C62:
		lea	byte_6BCA(pc),a0
		move.w	(Camera_BG_Y_pos).w,d0
	if FixBugs
		andi.w	#$3F0,d0
	else
		andi.w	#$7F0,d0
	endif
		lsr.w	#4,d0
		lea	(a0,d0.w),a0
		bra.w	loc_6C80
; ---------------------------------------------------------------------------
word_6C78:	dc.w Camera_BG_copy
		dc.w Camera_BG_copy
		dc.w Camera_BG2_copy
		dc.w Camera_BG3_copy
; ---------------------------------------------------------------------------

loc_6C80:
		tst.w	(Two_player_mode).w
		bne.s	loc_6CC2
		moveq	#16-1,d6
		move.l	#$800000,d7

loc_6C8E:
		moveq	#0,d0
		move.b	(a0)+,d0
		btst	d0,(a2)
		beq.s	loc_6CB6
		movea.w	word_6C78(pc,d0.w),a3
		movem.l	d4-d5/a0,-(sp)
		movem.l	d4-d5,-(sp)
		bsr.w	GetBlockData
		movem.l	(sp)+,d4-d5
		bsr.w	Calc_VRAM_Pos
		bsr.w	sub_6F70
		movem.l	(sp)+,d4-d5/a0

loc_6CB6:
		addi.w	#16,d4
		dbf	d6,loc_6C8E
		clr.b	(a2)
		rts
; ---------------------------------------------------------------------------

loc_6CC2:
		moveq	#((224+16+16)/16)-1,d6
		move.l	#$800000,d7

loc_6CCA:
		moveq	#0,d0
		move.b	(a0)+,d0
		btst	d0,(a2)
		beq.s	loc_6CF2
		movea.w	word_6C78(pc,d0.w),a3
		movem.l	d4-d5/a0,-(sp)
		movem.l	d4-d5,-(sp)
		bsr.w	GetBlockData
		movem.l	(sp)+,d4-d5
		bsr.w	Calc_VRAM_Pos
		bsr.w	DrawBlock
		movem.l	(sp)+,d4-d5/a0

loc_6CF2:
		addi.w	#16,d4
		dbf	d6,loc_6CCA
		clr.b	(a2)
		rts
; End of function DrawBGScrollBlock3


; =============== S U B	R O U T	I N E =======================================


sub_6CFE:
		moveq	#16-1,d6
; End of function sub_6CFE


; =============== S U B	R O U T	I N E =======================================


DrawBlocks_TB_2:
		add.w	(a3),d5
		add.w	4(a3),d4
		move.l	#$800000,d7
		move.l	d0,d1
		bsr.w	sub_6E98
		tst.w	(Two_player_mode).w
		bne.s	loc_6D4E

loc_6D18:
		move.w	(a0),d3
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		lea	(v_16x16).w,a1
		adda.w	d3,a1
		move.l	d1,d0
		bsr.w	sub_6F70
		adda.w	#16,a0
		addi.w	#$100,d1
		andi.w	#$FFF,d1
		addi.w	#16,d4
		move.w	d4,d0
		andi.w	#$70,d0
		bne.s	loc_6D48
		bsr.w	sub_6E98

loc_6D48:
		dbf	d6,loc_6D18
		rts
; ---------------------------------------------------------------------------

loc_6D4E:
		move.w	(a0),d3
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		lea	(v_16x16).w,a1
		adda.w	d3,a1
		move.l	d1,d0
		bsr.w	DrawBlock
		adda.w	#16,a0
		addi.w	#$80,d1
		andi.w	#$FFF,d1
		addi.w	#16,d4
		move.w	d4,d0
		andi.w	#$70,d0
		bne.s	loc_6D7E
		bsr.w	sub_6E98

loc_6D7E:
		dbf	d6,loc_6D4E
		rts
; End of function DrawBlocks_TB_2


; =============== S U B	R O U T	I N E =======================================


DrawBlocks_LR_2:
		add.w	(a3),d5
		add.w	4(a3),d4
		bra.s	loc_6D94
; End of function DrawBlocks_LR_2


; =============== S U B	R O U T	I N E =======================================


DrawBlocks_LR:
		moveq	#(1+320/16+1)-1,d6 ; Just enough blocks to cover the screen.
		add.w	(a3),d5
; End of function DrawBlocks_LR


; =============== S U B	R O U T	I N E =======================================


DrawBlocks_LR_3:
		add.w	4(a3),d4

loc_6D94:
		tst.w	(Two_player_mode).w
		bne.s	loc_6E12
		move.l	a2,-(sp)
		move.w	d6,-(sp)
		lea	(Block_cache).w,a2
		move.l	d0,d1
		or.w	d2,d1
		swap	d1
		move.l	d1,-(sp)
		move.l	d1,(a5)
		swap	d1
		bsr.w	sub_6E98

loc_6DB2:
		move.w	(a0),d3
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		lea	(v_16x16).w,a1
		adda.w	d3,a1
		bsr.w	sub_6ED0
		addq.w	#2,a0
		addq.b	#4,d1
		bpl.s	loc_6DD4
		andi.b	#$7F,d1
		swap	d1
		move.l	d1,(a5)
		swap	d1

loc_6DD4:
		addi.w	#$10,d5
		move.w	d5,d0
		andi.w	#$70,d0
		bne.s	loc_6DE4
		bsr.w	sub_6E98

loc_6DE4:
		dbf	d6,loc_6DB2
		move.l	(sp)+,d1
		addi.l	#$800000,d1
		lea	(Block_cache).w,a2
		move.l	d1,(a5)
		swap	d1
		move.w	(sp)+,d6

loc_6DFA:
		move.l	(a2)+,(a6)
		addq.b	#4,d1
		bmi.s	loc_6E0A
		ori.b	#$80,d1
		swap	d1
		move.l	d1,(a5)
		swap	d1

loc_6E0A:
		dbf	d6,loc_6DFA
		movea.l	(sp)+,a2
		rts
; ---------------------------------------------------------------------------

loc_6E12:
		move.l	d0,d1
		or.w	d2,d1
		swap	d1
		move.l	d1,(a5)
		swap	d1
		tst.b	d1
		bmi.s	loc_6E5C
		bsr.w	sub_6E98

loc_6E24:
		move.w	(a0),d3
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		lea	(v_16x16).w,a1
		adda.w	d3,a1
		bsr.w	sub_6F32
		addq.w	#2,a0
		addq.b	#4,d1
		bpl.s	loc_6E46
		andi.b	#$7F,d1
		swap	d1
		move.l	d1,(a5)
		swap	d1

loc_6E46:
		addi.w	#$10,d5
		move.w	d5,d0
		andi.w	#$70,d0
		bne.s	loc_6E56
		bsr.w	sub_6E98

loc_6E56:
		dbf	d6,loc_6E24
		rts
; ---------------------------------------------------------------------------

loc_6E5C:
		bsr.w	sub_6E98

loc_6E60:
		move.w	(a0),d3
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		lea	(v_16x16).w,a1
		adda.w	d3,a1
		bsr.w	sub_6F32
		addq.w	#2,a0
		addq.b	#4,d1
		bmi.s	loc_6E82
		ori.b	#$80,d1
		swap	d1
		move.l	d1,(a5)
		swap	d1

loc_6E82:
		addi.w	#$10,d5
		move.w	d5,d0
		andi.w	#$70,d0
		bne.s	loc_6E92
		bsr.w	sub_6E98

loc_6E92:
		dbf	d6,loc_6E60
		rts
; End of function DrawBlocks_LR_3


; =============== S U B	R O U T	I N E =======================================


sub_6E98:
		movem.l	d4-d5,-(sp)
		move.w	d4,d3
		add.w	d3,d3
		andi.w	#$F00,d3
		lsr.w	#3,d5
		move.w	d5,d0
		lsr.w	#4,d0
		andi.w	#$7F,d0
		add.w	d3,d0
		moveq	#-1,d3
		move.b	(a4,d0.w),d3
		andi.w	#$FF,d3
		lsl.w	#7,d3
		andi.w	#$70,d4
		andi.w	#$E,d5
		add.w	d4,d3
		add.w	d5,d3
		movea.l	d3,a0
		movem.l	(sp)+,d4-d5
		rts
; End of function sub_6E98


; =============== S U B	R O U T	I N E =======================================


sub_6ED0:
		btst	#3,(a0)
		bne.s	loc_6EFC
		btst	#2,(a0)
		bne.s	loc_6EE2
		move.l	(a1)+,(a6)
		move.l	(a1)+,(a2)+
		rts
; ---------------------------------------------------------------------------

loc_6EE2:
		move.l	(a1)+,d3
		eori.l	#$8000800,d3
		swap	d3
		move.l	d3,(a6)
		move.l	(a1)+,d3
		eori.l	#$8000800,d3
		swap	d3
		move.l	d3,(a2)+
		rts
; ---------------------------------------------------------------------------

loc_6EFC:
		btst	#2,(a0)
		bne.s	loc_6F18
		move.l	(a1)+,d0
		move.l	(a1)+,d3
		eori.l	#$10001000,d3
		move.l	d3,(a6)
		eori.l	#$10001000,d0
		move.l	d0,(a2)+
		rts
; ---------------------------------------------------------------------------

loc_6F18:
		move.l	(a1)+,d0
		move.l	(a1)+,d3
		eori.l	#$18001800,d3
		swap	d3
		move.l	d3,(a6)
		eori.l	#$18001800,d0
		swap	d0
		move.l	d0,(a2)+
		rts
; End of function sub_6ED0


; =============== S U B	R O U T	I N E =======================================


sub_6F32:
		btst	#3,(a0)
		bne.s	loc_6F50
		btst	#2,(a0)
		bne.s	loc_6F42
		move.l	(a1)+,(a6)
		rts
; ---------------------------------------------------------------------------

loc_6F42:
		move.l	(a1)+,d3
		eori.l	#$8000800,d3
		swap	d3
		move.l	d3,(a6)
		rts
; ---------------------------------------------------------------------------

loc_6F50:
		btst	#2,(a0)
		bne.s	loc_6F62
		move.l	(a1)+,d3
		eori.l	#$10001000,d3
		move.l	d3,(a6)
		rts
; ---------------------------------------------------------------------------

loc_6F62:
		move.l	(a1)+,d3
		eori.l	#$18001800,d3
		swap	d3
		move.l	d3,(a6)
		rts
; End of function sub_6F32


; =============== S U B	R O U T	I N E =======================================


sub_6F70:
		or.w	d2,d0
		swap	d0
		btst	#3,(a0)
		bne.s	loc_6FAC
		btst	#2,(a0)
		bne.s	loc_6F8C
		move.l	d0,(a5)
		move.l	(a1)+,(a6)
		add.l	d7,d0
		move.l	d0,(a5)
		move.l	(a1)+,(a6)
		rts
; ---------------------------------------------------------------------------

loc_6F8C:
		move.l	d0,(a5)
		move.l	(a1)+,d3
		eori.l	#$8000800,d3
		swap	d3
		move.l	d3,(a6)
		add.l	d7,d0
		move.l	d0,(a5)
		move.l	(a1)+,d3
		eori.l	#$8000800,d3
		swap	d3
		move.l	d3,(a6)
		rts
; ---------------------------------------------------------------------------

loc_6FAC:
		btst	#2,(a0)
		bne.s	loc_6FD2
		move.l	d5,-(sp)
		move.l	d0,(a5)
		move.l	(a1)+,d5
		move.l	(a1)+,d3
		eori.l	#$10001000,d3
		move.l	d3,(a6)
		add.l	d7,d0
		move.l	d0,(a5)
		eori.l	#$10001000,d5
		move.l	d5,(a6)
		move.l	(sp)+,d5
		rts
; ---------------------------------------------------------------------------

loc_6FD2:
		move.l	d5,-(sp)
		move.l	d0,(a5)
		move.l	(a1)+,d5
		move.l	(a1)+,d3
		eori.l	#$18001800,d3
		swap	d3
		move.l	d3,(a6)
		add.l	d7,d0
		move.l	d0,(a5)
		eori.l	#$18001800,d5
		swap	d5
		move.l	d5,(a6)
		move.l	(sp)+,d5
		rts
; End of function sub_6F70


; =============== S U B	R O U T	I N E =======================================


DrawBlock:
		or.w	d2,d0
		swap	d0
		btst	#3,(a0)
		bne.s	DrawFlipY
		btst	#2,(a0)
		bne.s	DrawFlipX
		move.l	d0,(a5)
		move.l	(a1)+,(a6)
		rts
; ---------------------------------------------------------------------------

DrawFlipX:
		move.l	d0,(a5)
		move.l	(a1)+,d3
		eori.l	#$8000800,d3
		swap	d3
		move.l	d3,(a6)
		rts
; ---------------------------------------------------------------------------

DrawFlipY:
		btst	#2,(a0)
		bne.s	DrawFlipXY
		move.l	d0,(a5)
		move.l	(a1)+,d3
		eori.l	#$10001000,d3
		move.l	d3,(a6)
		rts
; ---------------------------------------------------------------------------

DrawFlipXY:
		move.l	d0,(a5)
		move.l	(a1)+,d3
		eori.l	#$18001800,d3
		swap	d3
		move.l	d3,(a6)
		rts
; End of function DrawBlock


; =============== S U B	R O U T	I N E =======================================


GetBlockData:
		add.w	(a3),d5
		add.w	4(a3),d4
		lea	(v_16x16).w,a1
		move.w	d4,d3
		add.w	d3,d3
		andi.w	#$F00,d3
		lsr.w	#3,d5
		move.w	d5,d0
		lsr.w	#4,d0
		andi.w	#$7F,d0
		add.w	d3,d0
		moveq	#-1,d3
		move.b	(a4,d0.w),d3
		andi.w	#$FF,d3
		lsl.w	#7,d3
		andi.w	#$70,d4
		andi.w	#$E,d5
		add.w	d4,d3
		add.w	d5,d3
		movea.l	d3,a0
		move.w	(a0),d3
		andi.w	#$3FF,d3
		lsl.w	#3,d3
		adda.w	d3,a1
		rts
; End of function GetBlockData


; =============== S U B	R O U T	I N E =======================================

Calc_VRAM_Pos:
		add.w	(a3),d5

Calc_VRAM_Pos_2:
		tst.w	(Two_player_mode).w
		bne.s	loc_70A6
		add.w	4(a3),d4
		andi.w	#$F0,d4
		andi.w	#$1F0,d5
		lsl.w	#4,d4
		lsr.w	#2,d5
		add.w	d5,d4
		moveq	#3,d0
		swap	d0
		move.w	d4,d0
		rts
; ---------------------------------------------------------------------------

loc_70A6:
		add.w	4(a3),d4
		andi.w	#$1F0,d4
		andi.w	#$1F0,d5
		lsl.w	#3,d4
		lsr.w	#2,d5
		add.w	d5,d4
		moveq	#3,d0
		swap	d0
		move.w	d4,d0
		rts
; End of function Calc_VRAM_Pos_2


; =============== S U B	R O U T	I N E =======================================


sub_70C0:
		tst.w	(Two_player_mode).w
		bne.s	loc_70E2
		add.w	4(a3),d4
		add.w	(a3),d5
		andi.w	#$F0,d4
		andi.w	#$1F0,d5
		lsl.w	#4,d4
		lsr.w	#2,d5
		add.w	d5,d4
		moveq	#2,d0
		swap	d0
		move.w	d4,d0
		rts
; ---------------------------------------------------------------------------

loc_70E2:
		add.w	4(a3),d4
		add.w	(a3),d5
		andi.w	#$1F0,d4
		andi.w	#$1F0,d5
		lsl.w	#3,d4
		lsr.w	#2,d5
		add.w	d5,d4
		moveq	#2,d0
		swap	d0
		move.w	d4,d0
		rts
; End of function sub_70C0


; =============== S U B	R O U T	I N E =======================================


LoadTilesFromStart:
		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		tst.w	(Two_player_mode).w
		beq.s	loc_711E
		lea	(Camera_X_pos_P2).w,a3
		lea	(v_lvllayout).w,a4
		move.w	#$6000,d2
		bsr.s	DrawChunks_2P

loc_711E:
		lea	(Camera_RAM).w,a3
		lea	(v_lvllayout).w,a4
		move.w	#$4000,d2
		bsr.s	DrawChunks
		lea	(Camera_BG_X_pos).w,a3
		lea	(v_lvllayoutbg).w,a4
		move.w	#$6000,d2
	if id_GHZ=0
		tst.b	(Current_Zone).w
	else
		cmpi.b	#id_GHZ,(Current_Zone).w
	endif
		beq.w	Draw_GHz_Bg
; End of function LoadTilesFromStart


; =============== S U B	R O U T	I N E =======================================


DrawChunks:
		moveq	#-16,d4
		moveq	#((224+16+16)/16)-1,d6

loc_7144:
		movem.l	d4-d6,-(sp)
		moveq	#0,d5
		move.w	d4,d1
		bsr.w	Calc_VRAM_Pos
		move.w	d1,d4
		moveq	#0,d5
		moveq	#(512/16)-1,d6
		disable_ints
		bsr.w	DrawBlocks_LR_2
		enable_ints
		movem.l	(sp)+,d4-d6
		addi.w	#16,d4
		dbf	d6,loc_7144
		rts
; End of function DrawChunks


; =============== S U B	R O U T	I N E =======================================


DrawChunks_2P:
		moveq	#-16,d4
		moveq	#((224+16+16)/16)-1,d6

loc_7174:
		movem.l	d4-d6,-(sp)
		moveq	#0,d5
		move.w	d4,d1
		bsr.w	sub_70C0
		move.w	d1,d4
		moveq	#0,d5
		moveq	#(512/16)-1,d6
		disable_ints
		bsr.w	DrawBlocks_LR_2
		enable_ints
		movem.l	(sp)+,d4-d6
		addi.w	#16,d4
		dbf	d6,loc_7174
		rts
; End of function LoadTilesFromStart_2P

; ---------------------------------------------------------------------------

Draw_GHz_Bg:
		moveq	#0,d4
		moveq	#((224+16+16)/16)-1,d6

loc_71A4:
		movem.l	d4-d6,-(sp)
		lea	(byte_71CA).l,a0
		move.w	(Camera_BG_Y_pos).w,d0
		add.w	d4,d0
		andi.w	#$F0,d0
		bsr.w	sub_7232
		movem.l	(sp)+,d4-d6
		addi.w	#16,d4
		dbf	d6,loc_71A4
		rts
; ---------------------------------------------------------------------------
byte_71CA:	dc.b   0,  0,  0,  0,  6,  6,  6,  4,  4,  4,  0,  0,  0,  0,  0,  0
; ---------------------------------------------------------------------------
; Draw_Mz_Bg:
		moveq	#-16,d4
		moveq	#((224+16+16)/16)-1,d6

loc_71DE:
		movem.l	d4-d6,-(sp)
		lea	byte_6BCA+1(pc),a0
		move.w	(Camera_BG_Y_pos).w,d0
		add.w	d4,d0
		andi.w	#$3F0,d0
		bsr.w	sub_7232
		movem.l	(sp)+,d4-d6
		addi.w	#16,d4
		dbf	d6,loc_71DE
		rts
; ---------------------------------------------------------------------------
; Draw_SBz_Bg:
		moveq	#-16,d4
		moveq	#((224+16+16)/16)-1,d6

loc_7206:
		movem.l	d4-d6,-(sp)
		lea	byte_6AD0+1(pc),a0
		move.w	(Camera_BG_Y_pos).w,d0
		add.w	d4,d0
		andi.w	#$1F0,d0
		bsr.w	sub_7232
		movem.l	(sp)+,d4-d6
		addi.w	#16,d4
		dbf	d6,loc_7206
		rts
; ---------------------------------------------------------------------------
word_722A:	dc.w Camera_BG_X_pos
		dc.w Camera_BG_X_pos
		dc.w Camera_BG2_X_pos
		dc.w Camera_BG3_X_pos

; =============== S U B	R O U T	I N E =======================================


sub_7232:
		lsr.w	#4,d0
		move.b	(a0,d0.w),d0
		movea.w	word_722A(pc,d0.w),a3
		beq.s	loc_725A
		moveq	#-16,d5
		movem.l	d4-d5,-(sp)
		bsr.w	Calc_VRAM_Pos
		movem.l	(sp)+,d4-d5
		disable_ints
		bsr.w	DrawBlocks_LR
		enable_ints
		rts
; ---------------------------------------------------------------------------

loc_725A:
		moveq	#0,d5
		movem.l	d4-d5,-(sp)
		bsr.w	Calc_VRAM_Pos_2
		movem.l	(sp)+,d4-d5
		moveq	#(512/16)-1,d6
		bsr.w	DrawBlocks_LR_3
		rts
; End of function sub_7232