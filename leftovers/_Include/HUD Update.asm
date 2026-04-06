; =============== S U B	R O U T	I N E =======================================


HudUpdate_PB:
		nop
		lea	(vdp_data_port).l,a6
		tst.w	(Debug_mode_flag).w
		bne.w	S1TimeOver_PB.loc_1B330
		tst.b	(f_scorecount).w
		beq.s	.loc_1B266
		clr.b	(f_scorecount).w
		locVRAM	(ArtTile_HUD+$1A)*tile_size,d0	; set VRAM address
		move.l	(v_score).w,d1
		bsr.w	HUD_Score_PB

.loc_1B266:
		tst.b	(f_ringcount).w
		beq.s	.loc_1B286
		bpl.s	.loc_1B272
		bsr.w	HUD_LoadZero_PB

.loc_1B272:
		clr.b	(f_ringcount).w
		locVRAM	(ArtTile_HUD+$30)*tile_size,d0	; set VRAM address
		moveq	#0,d1
		move.w	(v_rings).w,d1
		bsr.w	HUD_Rings_PB

.loc_1B286:
		tst.b	(f_timecount).w
		beq.s	.loc_1B2E2
		tst.w	(f_pause).w
		bne.s	.loc_1B2E2
		lea	(v_time).w,a1
		cmpi.l	#9<<16+59<<8+59,(a1)+		; if the timer has passed 9:59...
	if 0
		beq.s	S1TimeOver_PB
	else
		nop					; ...do nothing
	endif
		addq.b	#1,-(a1)
		cmpi.b	#60,(a1)
		blo.s	.loc_1B2E2
		move.b	#0,(a1)
		addq.b	#1,-(a1)
		cmpi.b	#60,(a1)
		blo.s	.loc_1B2C2
		move.b	#0,(a1)
		addq.b	#1,-(a1)
		cmpi.b	#9,(a1)
		blo.s	.loc_1B2C2
		move.b	#9,(a1)

.loc_1B2C2:
		locVRAM	(ArtTile_HUD+$28)*tile_size,d0
		moveq	#0,d1
		move.b	(v_timemin).w,d1
		bsr.w	HUD_Mins_PB
		locVRAM	(ArtTile_HUD+$2C)*tile_size,d0
		moveq	#0,d1
		move.b	(v_timesec).w,d1
		bsr.w	HUD_Secs_PB

.loc_1B2E2:
		tst.b	(f_lifecount).w
		beq.s	.loc_1B2F0
		clr.b	(f_lifecount).w
		bsr.w	HUD_Lives_PB

.loc_1B2F0:
		tst.b	(f_endactbonus).w
		beq.s	.locret_1B318
		clr.b	(f_endactbonus).w
		locVRAM	ArtTile_Bonuses*tile_size
		moveq	#0,d1
		move.w	(v_timebonus).w,d1
		bsr.w	HUD_TimeRingBonus_PB
		moveq	#0,d1
		move.w	(v_ringbonus).w,d1
		bsr.w	HUD_TimeRingBonus_PB

.locret_1B318:
		rts
; ===========================================================================
; kills the player if the time has reached 9:59, except now it's unused due
; to its "beq" command being noped out above
S1TimeOver_PB:
		clr.b	(f_timecount).w
		lea	(v_player).w,a0
		movea.l	a0,a2
		bsr.w	KillCharacter_PB	;	KillCharacter
		move.b	#1,(f_timeover).w
		rts
; ---------------------------------------------------------------------------

.loc_1B330:
		bsr.w	HUDDebug_XY_PB
		tst.b	(f_ringcount).w
		beq.s	.loc_1B354
		bpl.s	.loc_1B340
		bsr.w	HUD_LoadZero_PB

.loc_1B340:
		clr.b	(f_ringcount).w
		locVRAM	(ArtTile_HUD+$30)*tile_size,d0	; set VRAM address
		moveq	#0,d1
		move.w	(v_rings).w,d1
		bsr.w	HUD_Rings_PB

.loc_1B354:
		locVRAM	(ArtTile_HUD+$2C)*tile_size,d0	; set VRAM address
		moveq	#0,d1
		move.b	(v_spritecount).w,d1
		bsr.w	HUD_Secs_PB
		tst.b	(f_lifecount).w
		beq.s	.loc_1B372
		clr.b	(f_lifecount).w
		bsr.w	HUD_Lives_PB

.loc_1B372:
		tst.b	(f_endactbonus).w
		beq.s	.locret_1B39A
		clr.b	(f_endactbonus).w
		locVRAM	ArtTile_Bonuses*tile_size		; set VRAM address
		moveq	#0,d1
		move.w	(v_timebonus).w,d1
		bsr.w	HUD_TimeRingBonus_PB
		moveq	#0,d1
		move.w	(v_ringbonus).w,d1
		bsr.w	HUD_TimeRingBonus_PB

.locret_1B39A:
		rts
; End of function HudUpdate


; =============== S U B	R O U T	I N E =======================================


HUD_LoadZero_PB:
		locVRAM	(ArtTile_HUD+$30)*tile_size
		lea	HUD_TilesRings_PB(pc),a2
		move.w	#(HUD_TilesBase_PB_End-HUD_TilesRings_PB)-1,d2
		bra.s	HUD_Base_PB.loc_1B3CC
; End of function HUD_LoadZero


; =============== S U B	R O U T	I N E =======================================


HUD_Base_PB:
		lea	(vdp_data_port).l,a6
		bsr.w	HUD_Lives_PB
		locVRAM	(ArtTile_HUD+$18)*tile_size
		lea	HUD_TilesBase_PB(pc),a2
		move.w	#(HUD_TilesBase_PB_End-HUD_TilesBase_PB)-1,d2

.loc_1B3CC:
		lea	Art_HUD_PB(pc),a1

.loc_1B3D0:
		move.w	#$10-1,d1
		move.b	(a2)+,d0
		bmi.s	.loc_1B3EC
		ext.w	d0
		lsl.w	#5,d0
		lea	(a1,d0.w),a3

.loc_1B3E0:
		move.l	(a3)+,(a6)
		dbf	d1,.loc_1B3E0

.loc_1B3E6:
		dbf	d2,.loc_1B3D0
		rts
; ---------------------------------------------------------------------------

.loc_1B3EC:
		move.l	#0,(a6)
		dbf	d1,.loc_1B3EC
		bra.s	.loc_1B3E6
; End of function HUD_Base

; ---------------------------------------------------------------------------
		charset	' ',$FF
		charset	'0',0
		charset	'1',2
		charset	'2',4
		charset	'3',6
		charset	'4',8
		charset	'5',$A
		charset	'6',$C
		charset	'7',$E
		charset	'8',$10
		charset	'9',$12
		charset	':',$14
		charset	'E',$16

HUD_TilesBase_PB:
		dc.b "E      0"
		dc.b "0:00"
HUD_TilesRings_PB:
		dc.b "  0"
HUD_TilesBase_PB_End:
		even

		charset

; =============== S U B	R O U T	I N E =======================================


HUDDebug_XY_PB:
		locVRAM	(ArtTile_HUD+$18)*tile_size		; set VRAM address
		move.w	(Camera_X_pos).w,d1
		move.w	(v_objstate_debug).w,d1
		swap	d1
		move.w	(v_player+obX).w,d1
		bsr.s	HUDDebug_XY2_PB
		move.w	(Camera_Y_pos).w,d1
		move.w	(Obj_respawn_index_P2_debug).w,d1
		swap	d1
		move.w	(v_player+obY).w,d1
; End of function HUDDebug_XY


; =============== S U B	R O U T	I N E =======================================


HUDDebug_XY2_PB:
		moveq	#8-1,d6
		lea	($4E8).l,a1	;	Art_Text

.loc_1B430:
		rol.w	#4,d1
		move.w	d1,d2
		andi.w	#$F,d2
		cmpi.w	#$A,d2
		blo.s	.loc_1B442
		addi.w	#7,d2

.loc_1B442:
		lsl.w	#5,d2
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		swap	d1
		dbf	d6,.loc_1B430
		rts
; End of function HUDDebug_XY2


; =============== S U B	R O U T	I N E =======================================


HUD_Rings_PB:
		lea	(HUD_100_PB).l,a2
		moveq	#3-1,d6
		bra.s	HUD_Score_PB.loc_1B472
; End of function HUD_Rings


; =============== S U B	R O U T	I N E =======================================


HUD_Score_PB:
		lea	(HUD_100000_PB).l,a2
		moveq	#6-1,d6

.loc_1B472:
		moveq	#0,d4
		lea	Art_HUD_PB(pc),a1

.loc_1B478:
		moveq	#0,d2
		move.l	(a2)+,d3

.loc_1B47C:
		sub.l	d3,d1
		blo.s	.loc_1B484
		addq.w	#1,d2
		bra.s	.loc_1B47C
; ---------------------------------------------------------------------------

.loc_1B484:
		add.l	d3,d1
		tst.w	d2
		beq.s	.loc_1B48E
		move.w	#1,d4

.loc_1B48E:
		tst.w	d4
		beq.s	.loc_1B4BC
		lsl.w	#6,d2
		move.l	d0,4(a6)
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)

.loc_1B4BC:
		addi.l	#$400000,d0
		dbf	d6,.loc_1B478
		rts
; End of function HUD_Score

; ---------------------------------------------------------------------------
; Subroutine to	load countdown numbers on the continue screen
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ContScrCounter_PB:
		locVRAM	ArtTile_Continue_Number*tile_size
		lea	(vdp_data_port).l,a6
		lea	(HUD_10_PB).l,a2
		moveq	#2-1,d6
		moveq	#0,d4
		lea	Art_HUD_PB(pc),a1 ; load numbers patterns

ContScr_Loop_PB:
		moveq	#0,d2
		move.l	(a2)+,d3

.loc_1C95A:
		sub.l	d3,d1
		blo.s	.loc_1C962
		addq.w	#1,d2
		bra.s	.loc_1C95A
; ===========================================================================

.loc_1C962:
		add.l	d3,d1
		lsl.w	#6,d2
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		dbf	d6,ContScr_Loop_PB	; repeat 1 more	time

		rts
; End of function ContScrCounter
; ---------------------------------------------------------------------------
HUD_100000_PB:	dc.l 100000
HUD_10000_PB:	dc.l 10000
HUD_1000_PB:	dc.l 1000
HUD_100_PB:		dc.l 100
HUD_10_PB:		dc.l 10
HUD_1_PB:		dc.l 1

; =============== S U B	R O U T	I N E =======================================


HUD_Mins_PB:
		lea	HUD_1_PB(pc),a2
		moveq	#1-1,d6
		bra.s	HUD_Secs_PB.loc_1B546
; End of function HUD_Mins


; =============== S U B	R O U T	I N E =======================================


HUD_Secs_PB:
		lea	HUD_10_PB(pc),a2
		moveq	#2-1,d6

.loc_1B546:
		moveq	#0,d4
		lea	Art_HUD_PB(pc),a1

.loc_1B54C:
		moveq	#0,d2
		move.l	(a2)+,d3

.loc_1B550:
		sub.l	d3,d1
		blo.s	.loc_1B558
		addq.w	#1,d2
		bra.s	.loc_1B550
; ---------------------------------------------------------------------------

.loc_1B558:
		add.l	d3,d1
		tst.w	d2
		beq.s	.loc_1B562
		move.w	#1,d4

.loc_1B562:
		lsl.w	#6,d2
		move.l	d0,4(a6)
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		addi.l	#$400000,d0
		dbf	d6,.loc_1B54C
		rts
; End of function HUD_Secs


; =============== S U B	R O U T	I N E =======================================


HUD_TimeRingBonus_PB:
		lea	HUD_1000_PB(pc),a2
		moveq	#4-1,d6
		moveq	#0,d4
		lea	Art_HUD_PB(pc),a1

.loc_1B5A4:
		moveq	#0,d2
		move.l	(a2)+,d3

.loc_1B5A8:
		sub.l	d3,d1
		blo.s	.loc_1B5B0
		addq.w	#1,d2
		bra.s	.loc_1B5A8
; ---------------------------------------------------------------------------

.loc_1B5B0:
		add.l	d3,d1
		tst.w	d2
		beq.s	.loc_1B5BA
		move.w	#1,d4

.loc_1B5BA:
		tst.w	d4
		beq.s	.loc_1B5EA
		lsl.w	#6,d2
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)

.loc_1B5E4:
		dbf	d6,.loc_1B5A4
		rts
; ---------------------------------------------------------------------------

.loc_1B5EA:
		moveq	#$10-1,d5

.loc_1B5EC:
		move.l	#0,(a6)
		dbf	d5,.loc_1B5EC
		bra.s	.loc_1B5E4
; End of function HUD_TimeRingBonus


; =============== S U B	R O U T	I N E =======================================


HUD_Lives_PB:
		locVRAM	(ArtTile_Lives_Counter+9)*tile_size,d0	; set VRAM address
		moveq	#0,d1
		move.b	(v_lives).w,d1
		lea	HUD_10_PB(pc),a2
		moveq	#2-1,d6
		moveq	#0,d4
		lea	Art_LivesNums_PB(pc),a1

.loc_1B610:
		move.l	d0,4(a6)
		moveq	#0,d2
		move.l	(a2)+,d3

.loc_1B618:
		sub.l	d3,d1
		blo.s	.loc_1B620
		addq.w	#1,d2
		bra.s	.loc_1B618
; ---------------------------------------------------------------------------

.loc_1B620:
		add.l	d3,d1
		tst.w	d2
		beq.s	.loc_1B62A
		move.w	#1,d4

.loc_1B62A:
		tst.w	d4
		beq.s	.loc_1B650

.loc_1B62E:
		lsl.w	#5,d2
		lea	(a1,d2.w),a3
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)
		move.l	(a3)+,(a6)

.loc_1B644:
		addi.l	#$400000,d0
		dbf	d6,.loc_1B610
		rts
; ---------------------------------------------------------------------------

.loc_1B650:
		tst.w	d6
		beq.s	.loc_1B62E
		moveq	#8-1,d5

.loc_1B656:
		move.l	#0,(a6)
		dbf	d5,.loc_1B656
		bra.s	.loc_1B644
; End of function HUD_Lives