; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


PalCycle_Load:
		moveq	#0,d2
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		add.w	d0,d0
		move.w	PalCycle(pc,d0.w),d0
		jmp	PalCycle(pc,d0.w)
; ---------------------------------------------------------------------------
		rts
; End of function PalCycle_Load

; ===========================================================================
PalCycle:	dc.w PalCycle_GHZ-PalCycle
		dc.w PalCycle_CPZ-PalCycle
		dc.w PalCycle_CPZ-PalCycle
		dc.w PalCycle_EHZ-PalCycle
		dc.w PalCycle_HPZ-PalCycle
		dc.w PalCycle_HTZ-PalCycle
		dc.w PalCycle_GHZ-PalCycle
; ===========================================================================

PalCycle_S1TitleScreen:
		lea	(Pal_S1TitleCyc).l,a0
		bra.s	loc_1E7C
; ===========================================================================

PalCycle_GHZ:
		lea	(Pal_GHZCyc).l,a0

loc_1E7C:
		subq.w	#1,(v_pcyc_time).w
		bpl.s	locret_1EA2
		move.w	#5,(v_pcyc_time).w
		move.w	(v_pcyc_num).w,d0
		addq.w	#1,(v_pcyc_num).w
		andi.w	#3,d0
		lsl.w	#3,d0
		lea	(v_palette+$50).w,a1
		move.l	(a0,d0.w),(a1)+
		move.l	4(a0,d0.w),(a1)

locret_1EA2:
		rts
; ===========================================================================

PalCycle_CPZ:
		subq.w	#1,(v_pcyc_time).w
		bpl.s	locret_1F14
		move.w	#7,(v_pcyc_time).w
		lea	(Pal_CPZCyc1).l,a0
		move.w	(v_pcyc_num).w,d0
		addq.w	#6,(v_pcyc_num).w
		cmpi.w	#$36,(v_pcyc_num).w
		bcs.s	loc_1ECC
		move.w	#0,(v_pcyc_num).w

loc_1ECC:
		lea	(v_palette+$78).w,a1
		move.l	(a0,d0.w),(a1)+
		move.w	4(a0,d0.w),(a1)
		lea	(Pal_CPZCyc2).l,a0
		move.w	(v_pal_buffer+2).w,d0
		addq.w	#2,(v_pal_buffer+2).w
		cmpi.w	#$2A,(v_pal_buffer+2).w
		bcs.s	loc_1EF4
		move.w	#0,(v_pal_buffer+2).w

loc_1EF4:
		move.w	(a0,d0.w),(v_palette+$7E).w
		lea	(Pal_CPZCyc3).l,a0
		move.w	(v_pal_buffer+4).w,d0
		addq.w	#2,(v_pal_buffer+4).w
		andi.w	#$1E,(v_pal_buffer+4).w
		move.w	(a0,d0.w),(v_palette+$5E).w

locret_1F14:
		rts
; ===========================================================================

PalCycle_HPZ:
		subq.w	#1,(v_pcyc_time).w
		bpl.s	locret_1F56
		move.w	#4,(v_pcyc_time).w
		lea	(Pal_HPZCyc1).l,a0
		move.w	(v_pcyc_num).w,d0
		subq.w	#2,(v_pcyc_num).w
		bcc.s	loc_1F38
		move.w	#6,(v_pcyc_num).w

loc_1F38:
		lea	(v_palette+$72).w,a1
		move.l	(a0,d0.w),(a1)+
		move.l	4(a0,d0.w),(a1)
		lea	(Pal_HPZCyc2).l,a0
		lea	(v_palette_water+$72).w,a1
		move.l	(a0,d0.w),(a1)+
		move.l	4(a0,d0.w),(a1)

locret_1F56:
		rts
; ===========================================================================

PalCycle_EHZ:
		lea	(Pal_EHZCyc).l,a0
		subq.w	#1,(v_pcyc_time).w
		bpl.s	locret_1F84
		move.w	#7,(v_pcyc_time).w
		move.w	(v_pcyc_num).w,d0
		addq.w	#1,(v_pcyc_num).w
		andi.w	#3,d0
		lsl.w	#3,d0
		move.l	(a0,d0.w),(v_palette+$26).w
		move.l	4(a0,d0.w),(v_palette+$3C).w

locret_1F84:
		rts
; ===========================================================================

PalCycle_HTZ:
		lea	(Pal_HTZCyc1).l,a0
		subq.w	#1,(v_pcyc_time).w
		bpl.s	locret_1FB8
		move.w	#0,(v_pcyc_time).w
		move.w	(v_pcyc_num).w,d0
		addq.w	#1,(v_pcyc_num).w
		andi.w	#$F,d0
		move.b	Pal_HTZCyc2(pc,d0.w),(v_pcyc_time+1).w
		lsl.w	#3,d0
		move.l	(a0,d0.w),(v_palette+$26).w
		move.l	4(a0,d0.w),(v_palette+$3C).w

locret_1FB8:
		rts