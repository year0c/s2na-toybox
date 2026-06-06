; ---------------------------------------------------------------------------
; When debug mode is currently in use, you can actually find the original
; source code for it within the leftovers at $50A9C, which includes the
; code that has been commented out below
; ---------------------------------------------------------------------------

DebugMode_PB:
		moveq	#0,d0
		move.b	(Debug_placement_mode).w,d0
		move.w	DebugIndex_PB(pc,d0.w),d1
		jmp	DebugIndex_PB(pc,d1.w)
; ===========================================================================
DebugIndex_PB:	dc.w Debug_Init_PB-DebugIndex_PB
		dc.w Debug_Main_PB-DebugIndex_PB
; ===========================================================================
Debug_Init_PB:
		addq.b	#2,(Debug_placement_mode).w
		move.w	(Camera_Min_Y_pos).w,(v_limittopdb).w
		move.w	(Camera_Max_Y_pos_target).w,(v_limitbtmdb).w
		move.w	#0,(Camera_Min_Y_pos).w
		move.w	#$720,(Camera_Max_Y_pos_target).w
		andi.w	#$7FF,(v_player+obY).w
		andi.w	#$7FF,(Camera_Y_pos).w
		andi.w	#$3FF,(Camera_BG_Y_pos).w
		move.b	#0,obFrame(a0)
		move.b	#AniIDSonAni_Walk,obAnim(a0)

; Debug_CheckSS:
		cmpi.b	#GameModeID_SpecialStage,(v_gamemode).w ; is this the Special Stage?
		bne.s	.loc_1BB04			; if not, branch
		moveq	#6,d0				; force zone 6's debug object list (was the ending in S1)
		bra.s	.loc_1BB0A
; ===========================================================================

.loc_1BB04:
		moveq	#0,d0
		move.b	(Current_Zone).w,d0

.loc_1BB0A:
		lea	(DebugList_PB).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d6
		cmp.b	(Debug_object).w,d6
		bhi.s	.loc_1BB24
		move.b	#0,(Debug_object).w

.loc_1BB24:
		bsr.w	LoadDebugObjectSprite_PB
		move.b	#12,(Debug_Accel_Timer).w
		move.b	#1,(Debug_Speed).w

Debug_Main_PB:
		moveq	#6,d0				; force zone 6's debug object list (was the ending in S1)
		cmpi.b	#GameModeID_SpecialStage,(v_gamemode).w ; is this the Special Stage?
		beq.s	.loc_1BB44			; if yes, branch

		moveq	#0,d0
		move.b	(Current_Zone).w,d0

.loc_1BB44:
		lea	(DebugList_PB).l,a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d6
		bsr.w	Debug_Control_PB
		jmp	(DisplaySprite_PB).l

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


Debug_Control_PB:
		moveq	#0,d4
		move.w	#1,d1
		move.b	(v_jpadpress1).w,d4
		andi.w	#btnUp+btnDn+btnL+btnR,d4
		bne.s	Debug_Move_PB
		move.b	(v_jpadhold1).w,d0
		andi.w	#btnUp+btnDn+btnL+btnR,d0
		bne.s	Debug_ContinueMoving_PB
		move.b	#12,(Debug_Accel_Timer).w
		move.b	#15,(Debug_Speed).w
		bra.w	Debug_ControlObjects_PB
; ===========================================================================
; loc_1BB86:
Debug_ContinueMoving_PB:
		subq.b	#1,(Debug_Accel_Timer).w
		bne.s	Debug_TimerNotOver_PB
		move.b	#1,(Debug_Accel_Timer).w
		addq.b	#1,(Debug_Speed).w
		bne.s	Debug_Move_PB
		move.b	#-1,(Debug_Speed).w
; loc_1BB9E:
Debug_Move_PB:
		move.b	(v_jpadhold1).w,d4
; loc_1BBA2:
Debug_TimerNotOver_PB:
		moveq	#0,d1
		move.b	(Debug_Speed).w,d1
		addq.w	#1,d1
		swap	d1
		asr.l	#4,d1
		move.l	obY(a0),d2
		move.l	obX(a0),d3

		; move up
		btst	#bitUp,d4
		beq.s	.loc_1BBC2
		sub.l	d1,d2
		bhs.s	.loc_1BBC2
		moveq	#0,d2

.loc_1BBC2:
		; move down
		btst	#bitDn,d4
		beq.s	.loc_1BBD8
		add.l	d1,d2
		cmpi.l	#$7FF0000,d2
		blo.s	.loc_1BBD8
		move.l	#$7FF0000,d2

.loc_1BBD8:
		; move left
		btst	#bitL,d4
		beq.s	.loc_1BBE4
		sub.l	d1,d3
		bhs.s	.loc_1BBE4
		moveq	#0,d3

.loc_1BBE4:
		; move right
		btst	#bitR,d4
		beq.s	.loc_1BBEC
		add.l	d1,d3

.loc_1BBEC:
		move.l	d2,obY(a0)
		move.l	d3,obX(a0)
; loc_1BBF4:
Debug_ControlObjects_PB:
		btst	#bitA,(v_jpadhold1).w
		beq.s	Debug_SpawnObject_PB
		btst	#bitC,(v_jpadpress1).w
		beq.s	Debug_CycleObjects_PB
		; cycle backwards through the object list
		subq.b	#1,(Debug_object).w
		bhs.s	Debug_CycleObjects_PB.loc_1BC28
		add.b	d6,(Debug_object).w
		bra.s	Debug_CycleObjects_PB.loc_1BC28
; ===========================================================================
; loc_1BC10:
Debug_CycleObjects_PB:
		btst	#bitA,(v_jpadpress1).w
		beq.s	Debug_SpawnObject_PB
		addq.b	#1,(Debug_object).w
		cmp.b	(Debug_object).w,d6
		bhi.s	.loc_1BC28
		move.b	#0,(Debug_object).w

.loc_1BC28:
		bra.w	LoadDebugObjectSprite_PB
; ===========================================================================
; loc_1BC2C:
Debug_SpawnObject_PB:
		btst	#bitC,(v_jpadpress1).w
		beq.s	Debug_ExitDebugMode_PB
		; spawn object
		jsr	(FindFreeObj_PB).l
		bne.s	Debug_ExitDebugMode_PB
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		_move.b	obMap(a0),obID(a1)		; load obj
		move.b	obRender(a0),obRender(a1)
		move.b	obRender(a0),obStatus(a1)
		andi.b	#$7F,obStatus(a1)
		moveq	#0,d0
		move.b	(Debug_object).w,d0
		lsl.w	#3,d0
		move.b	4(a2,d0.w),obSubtype(a1)
		rts
; ===========================================================================
; loc_1BC70:
Debug_ExitDebugMode_PB:
		btst	#bitB,(v_jpadpress1).w
		beq.s	.locret_1BCCA
		; exit Debug Mode
		moveq	#0,d0
		move.w	d0,(Debug_placement_mode).w
		move.l	#Map_Sonic_PB,(v_player+obMap).w
		move.w	#make_art_tile(ArtTile_Sonic,0,0),(v_player+obGfx).w
		tst.w	(Two_player_mode).w
		beq.s	.loc_1BC98
		move.w	#make_art_tile_2p(ArtTile_Sonic,0,0),(v_player+obGfx).w

.loc_1BC98:
		move.b	d0,(v_player+obAnim).w
		move.w	d0,obX+2(a0)
		move.w	d0,obY+2(a0)
		move.w	(v_limittopdb).w,(Camera_Min_Y_pos).w
		move.w	(v_limitbtmdb).w,(Camera_Max_Y_pos_target).w
		cmpi.b	#GameModeID_SpecialStage,(v_gamemode).w ; is this the Special Stage?
		bne.s	.locret_1BCCA			; if not, branch

		move.b	#AniIDSonAni_Roll,(v_player+obAnim).w
		bset	#2,(v_player+obStatus).w
		bset	#1,(v_player+obStatus).w

.locret_1BCCA:
		rts
; End of function Debug_Control


; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; loc_1BCCC: Debug_ShowItem:
LoadDebugObjectSprite_PB:
		moveq	#0,d0
		move.b	(Debug_object).w,d0
		lsl.w	#3,d0
		move.l	(a2,d0.w),obMap(a0)
		move.w	6(a2,d0.w),obGfx(a0)
		move.b	5(a2,d0.w),obFrame(a0)
		bsr.w	$1AB00+$450	;	JmpTo10_Adjust2PArtPointer
		rts
; End of function Debug_ShowItem