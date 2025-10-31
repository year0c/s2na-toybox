; ===========================================================================
; ---------------------------------------------------------------------------
; Object 09 - Sonic in Special Stage
; ---------------------------------------------------------------------------

Obj09:
		tst.w	(Debug_placement_mode).w
		beq.s	Obj09_Normal
		bsr.w	S1SS_FixCamera
		bra.w	DebugMode
; ---------------------------------------------------------------------------

Obj09_Normal:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj09_Index(pc,d0.w),d1
		jmp	Obj09_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj09_Index:	dc.w loc_1A3DC-Obj09_Index
		dc.w loc_1A41C-Obj09_Index
		dc.w loc_1A618-Obj09_Index
		dc.w loc_1A66C-Obj09_Index
; ---------------------------------------------------------------------------

loc_1A3DC:
		addq.b	#2,obRoutine(a0)
		move.b	#$E,obHeight(a0)
		move.b	#7,obWidth(a0)
		move.l	#Map_Sonic,obMap(a0)
		move.w	#make_art_tile(ArtTile_Sonic,0,0),obGfx(a0)
		bsr.w	j_Adjust2PArtPointer_7
		move.b	#4,obRender(a0)
		move.b	#0,obPriority(a0)
		move.b	#2,obAnim(a0)
		bset	#2,obStatus(a0)
		bset	#1,obStatus(a0)

loc_1A41C:
		tst.w	(Debug_mode_flag).w
		beq.s	loc_1A430
		btst	#bitB,(v_jpadpress1).w
		beq.s	loc_1A430
		move.w	#1,(Debug_placement_mode).w

loc_1A430:
		move.b	#0,objoff_30(a0)
		moveq	#0,d0
		move.b	obStatus(a0),d0
		andi.w	#2,d0
		move.w	Obj09_Modes(pc,d0.w),d1
		jsr	Obj09_Modes(pc,d1.w)
		jsr	(LoadSonicDynPLC).l
		jmp	(DisplaySprite).l
; ---------------------------------------------------------------------------
Obj09_Modes:	dc.w Obj09_OnWall-Obj09_Modes
		dc.w Obj09_InAir-Obj09_Modes
; ---------------------------------------------------------------------------

Obj09_OnWall:
		bsr.w	Obj09_Jump
		bsr.w	Obj09_Move
		bsr.w	Obj09_Fall
		bra.s	Obj09_Display
; ---------------------------------------------------------------------------

Obj09_InAir:
		bsr.w	nullsub_2
		bsr.w	Obj09_Move
		bsr.w	Obj09_Fall

Obj09_Display:
		bsr.w	Obj09_ChkItems
		bsr.w	Obj09_ChkItems2
		jsr	(ObjectMove).l
		bsr.w	S1SS_FixCamera
		move.w	(v_ssangle).w,d0
		add.w	(v_ssrotate).w,d0
		move.w	d0,(v_ssangle).w
		jsr	(Sonic_Animate).l
		rts

; =============== S U B	R O U T	I N E =======================================


Obj09_Move:
		btst	#bitL,(v_jpadhold2).w
		beq.s	loc_1A4A4
		bsr.w	Obj09_MoveLeft

loc_1A4A4:
		btst	#bitR,(v_jpadhold2).w
		beq.s	loc_1A4B0
		bsr.w	Obj09_MoveRight

loc_1A4B0:
		move.b	(v_jpadhold2).w,d0
		andi.b	#btnL+btnR,d0
		bne.s	loc_1A4E0
		move.w	obInertia(a0),d0
		beq.s	loc_1A4E0
		bmi.s	loc_1A4D2
		subi.w	#$C,d0
		bcc.s	loc_1A4CC
		move.w	#0,d0

loc_1A4CC:
		move.w	d0,obInertia(a0)
		bra.s	loc_1A4E0
; ---------------------------------------------------------------------------

loc_1A4D2:
		addi.w	#$C,d0
		bcc.s	loc_1A4DC
		move.w	#0,d0

loc_1A4DC:
		move.w	d0,obInertia(a0)

loc_1A4E0:
		move.b	(v_ssangle).w,d0
		addi.b	#$20,d0
		andi.b	#$C0,d0
		neg.b	d0
		jsr	(CalcSine).l
		muls.w	obInertia(a0),d1
		add.l	d1,obX(a0)
		muls.w	obInertia(a0),d0
		add.l	d0,obY(a0)
		movem.l	d0-d1,-(sp)
		move.l	obY(a0),d2
		move.l	obX(a0),d3
		bsr.w	sub_1A720
		beq.s	loc_1A52A
		movem.l	(sp)+,d0-d1
		sub.l	d1,obX(a0)
		sub.l	d0,obY(a0)
		move.w	#0,obInertia(a0)
		rts
; ---------------------------------------------------------------------------

loc_1A52A:
		movem.l	(sp)+,d0-d1
		rts
; End of function Obj09_Move


; =============== S U B	R O U T	I N E =======================================


Obj09_MoveLeft:
		bset	#0,obStatus(a0)
		move.w	obInertia(a0),d0
		beq.s	loc_1A53E
		bpl.s	loc_1A552

loc_1A53E:
		subi.w	#$C,d0
		cmpi.w	#-$800,d0
		bgt.s	loc_1A54C
		move.w	#-$800,d0

loc_1A54C:
		move.w	d0,obInertia(a0)
		rts
; ---------------------------------------------------------------------------

loc_1A552:
		subi.w	#$40,d0
		bcc.s	loc_1A55A
		nop

loc_1A55A:
		move.w	d0,obInertia(a0)
		rts
; End of function Obj09_MoveLeft


; =============== S U B	R O U T	I N E =======================================


Obj09_MoveRight:
		bclr	#0,obStatus(a0)
		move.w	obInertia(a0),d0
		bmi.s	loc_1A580
		addi.w	#$C,d0
		cmpi.w	#$800,d0
		blt.s	loc_1A57A
		move.w	#$800,d0

loc_1A57A:
		move.w	d0,obInertia(a0)
		bra.s	locret_1A58C
; ---------------------------------------------------------------------------

loc_1A580:
		addi.w	#$40,d0
		bcc.s	loc_1A588
		nop

loc_1A588:
		move.w	d0,obInertia(a0)

locret_1A58C:
		rts
; End of function Obj09_MoveRight


; =============== S U B	R O U T	I N E =======================================


Obj09_Jump:
		move.b	(v_jpadpress2).w,d0
		andi.b	#btnABC,d0
		beq.s	locret_1A5D0
		move.b	(v_ssangle).w,d0
		andi.b	#$FC,d0
		neg.b	d0
		subi.b	#$40,d0
		jsr	(CalcSine).l
		muls.w	#$680,d1
		asr.l	#8,d1
		move.w	d1,obVelX(a0)
		muls.w	#$680,d0
		asr.l	#8,d0
		move.w	d0,obVelY(a0)
		bset	#1,obStatus(a0)
		move.w	#sfx_Jump,d0
		jsr	(PlaySound_Special).l

locret_1A5D0:
		rts
; End of function Obj09_Jump


; =============== S U B	R O U T	I N E =======================================


nullsub_2:
		rts
; End of function nullsub_2

; ---------------------------------------------------------------------------
		move.w	#-$400,d1
		cmp.w	obVelY(a0),d1
		ble.s	locret_1A5EC
		move.b	(v_jpadhold2).w,d0
		andi.b	#btnABC,d0
		bne.s	locret_1A5EC
		move.w	d1,obVelY(a0)

locret_1A5EC:
		rts

; =============== S U B	R O U T	I N E =======================================


S1SS_FixCamera:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		move.w	(Camera_RAM).w,d0
		subi.w	#$A0,d3
		bcs.s	loc_1A606
		sub.w	d3,d0
		sub.w	d0,(Camera_RAM).w

loc_1A606:
		move.w	(Camera_Y_pos).w,d0
		subi.w	#$70,d2
		bcs.s	locret_1A616
		sub.w	d2,d0
		sub.w	d0,(Camera_Y_pos).w

locret_1A616:
		rts
; End of function S1SS_FixCamera

; ---------------------------------------------------------------------------

loc_1A618:
		addi.w	#$40,(v_ssrotate).w
		cmpi.w	#$1800,(v_ssrotate).w
		bne.s	loc_1A62C
		move.b	#GameModeID_Level,(v_gamemode).w

loc_1A62C:
		cmpi.w	#$3000,(v_ssrotate).w
		blt.s	loc_1A64A
		move.w	#0,(v_ssrotate).w
		move.w	#$4000,(v_ssangle).w
		addq.b	#2,obRoutine(a0)
		move.w	#$3C,objoff_38(a0)

loc_1A64A:
		move.w	(v_ssangle).w,d0
		add.w	(v_ssrotate).w,d0
		move.w	d0,(v_ssangle).w
		jsr	(Sonic_Animate).l
		jsr	(LoadSonicDynPLC).l
		bsr.w	S1SS_FixCamera
		jmp	(DisplaySprite).l
; ---------------------------------------------------------------------------

loc_1A66C:
		subq.w	#1,objoff_38(a0)
		bne.s	loc_1A678
		move.b	#GameModeID_Level,(v_gamemode).w

loc_1A678:
		jsr	(Sonic_Animate).l
		jsr	(LoadSonicDynPLC).l
		bsr.w	S1SS_FixCamera
		jmp	(DisplaySprite).l

; =============== S U B	R O U T	I N E =======================================


Obj09_Fall:
		move.l	obY(a0),d2
		move.l	obX(a0),d3
		move.b	(v_ssangle).w,d0
		andi.b	#$FC,d0
		jsr	(CalcSine).l
		move.w	obVelX(a0),d4
		ext.l	d4
		asl.l	#8,d4
		muls.w	#$2A,d0
		add.l	d4,d0
		move.w	obVelY(a0),d4
		ext.l	d4
		asl.l	#8,d4
		muls.w	#$2A,d1
		add.l	d4,d1
		add.l	d0,d3
		bsr.w	sub_1A720
		beq.s	loc_1A6E8
		sub.l	d0,d3
		moveq	#0,d0
		move.w	d0,obVelX(a0)
		bclr	#1,obStatus(a0)
		add.l	d1,d2
		bsr.w	sub_1A720
		beq.s	loc_1A6FE
		sub.l	d1,d2
		moveq	#0,d1
		move.w	d1,obVelY(a0)
		rts
; ---------------------------------------------------------------------------

loc_1A6E8:
		add.l	d1,d2
		bsr.w	sub_1A720
		beq.s	loc_1A70C
		sub.l	d1,d2
		moveq	#0,d1
		move.w	d1,obVelY(a0)
		bclr	#1,obStatus(a0)

loc_1A6FE:
		asr.l	#8,d0
		asr.l	#8,d1
		move.w	d0,obVelX(a0)
		move.w	d1,obVelY(a0)
		rts
; ---------------------------------------------------------------------------

loc_1A70C:
		asr.l	#8,d0
		asr.l	#8,d1
		move.w	d0,obVelX(a0)
		move.w	d1,obVelY(a0)
		bset	#1,obStatus(a0)
		rts
; End of function Obj09_Fall


; =============== S U B	R O U T	I N E =======================================


sub_1A720:
		lea	(v_ssbuffer1).l,a1
		moveq	#0,d4
		swap	d2
		move.w	d2,d4
		swap	d2
		addi.w	#$44,d4
		divu.w	#$18,d4
		mulu.w	#$80,d4
		adda.l	d4,a1
		moveq	#0,d4
		swap	d3
		move.w	d3,d4
		swap	d3
		addi.w	#$14,d4
		divu.w	#$18,d4
		adda.w	d4,a1
		moveq	#0,d5
		move.b	(a1)+,d4
		bsr.s	sub_1A768
		move.b	(a1)+,d4
		bsr.s	sub_1A768
		adda.w	#$7E,a1
		move.b	(a1)+,d4
		bsr.s	sub_1A768
		move.b	(a1)+,d4
		bsr.s	sub_1A768
		tst.b	d5
		rts
; End of function sub_1A720


; =============== S U B	R O U T	I N E =======================================


sub_1A768:
		beq.s	locret_1A77C
		cmpi.b	#$28,d4
		beq.s	locret_1A77C
		cmpi.b	#$3A,d4
		bcs.s	loc_1A77E
		cmpi.b	#$4B,d4
		bcc.s	loc_1A77E

locret_1A77C:
		rts
; ---------------------------------------------------------------------------

loc_1A77E:
		move.b	d4,$30(a0)
		move.l	a1,$32(a0)
		moveq	#-1,d5
		rts
; End of function sub_1A768


; =============== S U B	R O U T	I N E =======================================


Obj09_ChkItems:
		lea	(v_ssbuffer1).l,a1
		moveq	#0,d4
		move.w	obY(a0),d4
		addi.w	#$50,d4
		divu.w	#$18,d4
		mulu.w	#$80,d4
		adda.l	d4,a1
		moveq	#0,d4
		move.w	obX(a0),d4
		addi.w	#$20,d4
		divu.w	#$18,d4
		adda.w	d4,a1
		move.b	(a1),d4
		bne.s	loc_1A7C4
		tst.b	objoff_3A(a0)
		bne.w	loc_1A894
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1A7C4:
		cmpi.b	#$3A,d4
		bne.s	loc_1A800
		bsr.w	sub_19EEC
		bne.s	loc_1A7D8
		move.b	#1,(a2)
		move.l	a1,4(a2)

loc_1A7D8:
		jsr	(sub_A8DE).l
		cmpi.w	#50,(v_rings).w
		bcs.s	loc_1A7FC
		bset	#0,(v_lifecount).w
		bne.s	loc_1A7FC
		addq.b	#1,(v_continues).w
		move.w	#sfx_Continue,d0
		jsr	(PlaySound).l

loc_1A7FC:
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1A800:
		cmpi.b	#$28,d4
		bne.s	loc_1A82A
		bsr.w	sub_19EEC
		bne.s	loc_1A814
		move.b	#3,(a2)
		move.l	a1,4(a2)

loc_1A814:
		addq.b	#1,(v_lives).w
		addq.b	#1,(f_lifecount).w
		move.w	#bgm_ExtraLife,d0
		jsr	(PlaySound).l
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1A82A:
		cmpi.b	#$3B,d4
		bcs.s	loc_1A870
		cmpi.b	#$40,d4
		bhi.s	loc_1A870
		bsr.w	sub_19EEC
		bne.s	loc_1A844
		move.b	#5,(a2)
		move.l	a1,4(a2)

loc_1A844:
		cmpi.b	#6,(v_emeralds).w
		beq.s	loc_1A862
		subi.b	#$3B,d4
		moveq	#0,d0
		move.b	(v_emeralds).w,d0
		lea	(v_emldlist).w,a2
		move.b	d4,(a2,d0.w)
		addq.b	#1,(v_emeralds).w

loc_1A862:
		move.w	#bgm_Emerald,d0
		jsr	(PlaySound_Special).l
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------

loc_1A870:
		cmpi.b	#$41,d4
		bne.s	loc_1A87C
		move.b	#1,objoff_3A(a0)

loc_1A87C:
		cmpi.b	#$4A,d4
		bne.s	loc_1A890
		cmpi.b	#1,objoff_3A(a0)
		bne.s	loc_1A890
		move.b	#2,objoff_3A(a0)

loc_1A890:
		moveq	#-1,d4
		rts
; ---------------------------------------------------------------------------

loc_1A894:
		cmpi.b	#2,objoff_3A(a0)
		bne.s	loc_1A8BE
		lea	(v_ssblockbuffer).l,a1
		moveq	#(v_ssblockbuffer_end-v_ssblockbuffer)/$80-1,d1

loc_1A8A4:
		moveq	#(v_ssblockbuffer_end-v_ssblockbuffer)/$80-1,d2

loc_1A8A6:
		cmpi.b	#$41,(a1)
		bne.s	loc_1A8B0
		move.b	#$2C,(a1)

loc_1A8B0:
		addq.w	#1,a1
		dbf	d2,loc_1A8A6
		lea	$40(a1),a1
		dbf	d1,loc_1A8A4

loc_1A8BE:
		clr.b	objoff_3A(a0)
		moveq	#0,d4
		rts
; End of function Obj09_ChkItems


; =============== S U B	R O U T	I N E =======================================


Obj09_ChkItems2:
		move.b	objoff_30(a0),d0
		bne.s	loc_1A8E6
		subq.b	#1,objoff_36(a0)
		bpl.s	loc_1A8D8
		move.b	#0,objoff_36(a0)

loc_1A8D8:
		subq.b	#1,objoff_37(a0)
		bpl.s	locret_1A8E4
		move.b	#0,objoff_37(a0)

locret_1A8E4:
		rts
; ---------------------------------------------------------------------------

loc_1A8E6:
		cmpi.b	#$25,d0
		bne.s	loc_1A95E
		move.l	$32(a0),d1
		subi.l	#$FFFF0001,d1
		move.w	d1,d2
		andi.w	#$7F,d1
		mulu.w	#$18,d1
		subi.w	#$14,d1
		lsr.w	#7,d2
		andi.w	#$7F,d2
		mulu.w	#$18,d2
		subi.w	#$44,d2
		sub.w	obX(a0),d1
		sub.w	obY(a0),d2
		jsr	(CalcAngle).l
		jsr	(CalcSine).l
		muls.w	#-$700,d1
		asr.l	#8,d1
		move.w	d1,obVelX(a0)
		muls.w	#-$700,d0
		asr.l	#8,d0
		move.w	d0,obVelY(a0)
		bset	#1,obStatus(a0)
		bsr.w	sub_19EEC
		bne.s	loc_1A954
		move.b	#2,(a2)
		move.l	objoff_32(a0),d0
		subq.l	#1,d0
		move.l	d0,4(a2)

loc_1A954:
		move.w	#sfx_Bumper,d0
		jmp	(PlaySound_Special).l
; ---------------------------------------------------------------------------

loc_1A95E:
		cmpi.b	#$27,d0
		bne.s	loc_1A974
		addq.b	#2,obRoutine(a0)
		move.w	#sfx_SSGoal,d0
		jsr	(PlaySound_Special).l
		rts
; ---------------------------------------------------------------------------

loc_1A974:
		cmpi.b	#$29,d0
		bne.s	loc_1A9A8
		tst.b	objoff_36(a0)
		bne.w	locret_1AA58
		move.b	#$1E,objoff_36(a0)
		btst	#6,(v_ssrotate+1).w
		beq.s	loc_1A99E
		asl	(v_ssrotate).w
		movea.l	objoff_32(a0),a1
		subq.l	#1,a1
		move.b	#$2A,(a1)

loc_1A99E:
		move.w	#sfx_SSItem,d0
		jmp	(PlaySound_Special).l
; ---------------------------------------------------------------------------

loc_1A9A8:
		cmpi.b	#$2A,d0
		bne.s	loc_1A9DC
		tst.b	objoff_36(a0)
		bne.w	locret_1AA58
		move.b	#$1E,objoff_36(a0)
		btst	#6,(v_ssrotate+1).w
		bne.s	loc_1A9D2
		asr	(v_ssrotate).w
		movea.l	objoff_32(a0),a1
		subq.l	#1,a1
		move.b	#$29,(a1)

loc_1A9D2:
		move.w	#sfx_SSItem,d0
		jmp	(PlaySound_Special).l
; ---------------------------------------------------------------------------

loc_1A9DC:
		cmpi.b	#$2B,d0
		bne.s	loc_1AA12
		tst.b	objoff_37(a0)
		bne.w	locret_1AA58
		move.b	#$1E,objoff_37(a0)
		bsr.w	sub_19EEC
		bne.s	loc_1AA04
		move.b	#4,(a2)
		move.l	objoff_32(a0),d0
		subq.l	#1,d0
		move.l	d0,4(a2)

loc_1AA04:
		neg.w	(v_ssrotate).w
		move.w	#sfx_SSItem,d0
		jmp	(PlaySound_Special).l
; ---------------------------------------------------------------------------

loc_1AA12:
		cmpi.b	#$2D,d0
		beq.s	loc_1AA2A
		cmpi.b	#$2E,d0
		beq.s	loc_1AA2A
		cmpi.b	#$2F,d0
		beq.s	loc_1AA2A
		cmpi.b	#$30,d0
		bne.s	locret_1AA58

loc_1AA2A:
		bsr.w	sub_19EEC
		bne.s	loc_1AA4E
		move.b	#6,(a2)
		movea.l	objoff_32(a0),a1
		subq.l	#1,a1
		move.l	a1,4(a2)
		move.b	(a1),d0
		addq.b	#1,d0
		cmpi.b	#$30,d0
		bls.s	loc_1AA4A
		clr.b	d0

loc_1AA4A:
		move.b	d0,4(a2)

loc_1AA4E:
		move.w	#sfx_SSGlass,d0
		jmp	(PlaySound_Special).l
; ---------------------------------------------------------------------------

locret_1AA58:
		rts
; End of function Obj09_ChkItems2