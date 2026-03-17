; =============== S U B	R O U T	I N E =======================================


ChangeWaterSurfacePos:
		tst.b	(Water_flag).w
		beq.s	locret_403E
		move.w	(Camera_X_pos).w,d1
	if FixBugs
		; This function can cause the water surface's to be cut off at the
		; left when the game is paused. This is because this function pushes
		; the water surface sprite to the right every frame. To fix this,
		; just avoid pushing the sprite to the right when the game is about
		; to be paused.
		move.b	(v_jpadpress1).w,d0 ; is Start button pressed?
		or.b	(v_2Pjpadpress).w,d0 ; (either player)
		andi.b	#btnStart,d0
		bne.s	loc_402C
	endif
		btst	#0,(Timer_frames+1).w
		beq.s	loc_402C
		addi.w	#$20,d1

loc_402C:
		move.w	d1,d0
		addi.w	#$60,d0
		move.w	d0,(v_watersurface1+obX).w
		addi.w	#$120,d1
		move.w	d1,(v_watersurface2+obX).w

locret_403E:
		rts
; End of function ChangeWaterSurfacePos


; =============== S U B	R O U T	I N E =======================================


WaterEffects:
		tst.b	(Water_flag).w
		beq.s	locret_4094
		tst.b	(Deform_lock).w
		bne.s	loc_4058
		cmpi.b	#6,(v_player+obRoutine).w
		bhs.s	loc_4058
		bsr.w	DynamicWaterHeight

loc_4058:
		clr.b	(f_wtr_state).w
		moveq	#0,d0
		move.b	(v_oscillate+2).w,d0
		lsr.w	#1,d0
		add.w	(v_waterpos2).w,d0
		move.w	d0,(v_waterpos1).w
		move.w	(v_waterpos1).w,d0
		sub.w	(Camera_Y_pos).w,d0
		bhs.s	loc_4086
		tst.w	d0
		bpl.s	loc_4086
		move.b	#223,(v_hbla_line).w
		move.b	#1,(f_wtr_state).w

loc_4086:
		cmpi.w	#223,d0
		blo.s	loc_4090
		move.w	#223,d0

loc_4090:
		move.b	d0,(v_hbla_line).w

locret_4094:
		rts
; End of function WaterEffects

; ---------------------------------------------------------------------------
WaterHeight:	dc.w  $600, $328, $900,	$228

; =============== S U B	R O U T	I N E =======================================


DynamicWaterHeight:
		moveq	#0,d0
		move.b	(Current_Act).w,d0
		add.w	d0,d0
		move.w	DynWater_Index(pc,d0.w),d0
		jsr	DynWater_Index(pc,d0.w)
		moveq	#0,d1
		move.b	(f_water).w,d1
		move.w	(v_waterpos3).w,d0
		sub.w	(v_waterpos2).w,d0
		beq.s	locret_40C6
		bhs.s	loc_40C2
		neg.w	d1

loc_40C2:
		add.w	d1,(v_waterpos2).w

locret_40C6:
		rts
; End of function DynamicWaterHeight

; ---------------------------------------------------------------------------
DynWater_Index:	dc.w DynWater_HPZ1-DynWater_Index
		dc.w DynWater_HPZ2-DynWater_Index	; leftover from Sonic 1's LZ2
		dc.w DynWater_HPZ3-DynWater_Index	; leftover from Sonic 1's LZ3
		dc.w DynWater_HPZ4-DynWater_Index
; ---------------------------------------------------------------------------

DynWater_HPZ1:						; This uses the 2nd controller to make the water level move up or down
		btst	#bitUp,(v_2Pjpadhold).w
		beq.s	loc_40E2
		tst.w	(v_waterpos3).w
		beq.s	loc_40E2
		subq.w	#1,(v_waterpos3).w

loc_40E2:
		btst	#bitDn,(v_2Pjpadhold).w
		beq.s	locret_40F6
		cmpi.w	#$700,(v_waterpos3).w
		beq.s	locret_40F6
		addq.w	#1,(v_waterpos3).w

locret_40F6:
		rts
; ---------------------------------------------------------------------------

S1DynWater_LZ1:						; leftover from Sonic 1
		move.w	(Camera_X_pos).w,d0
		move.b	(v_wtr_routine).w,d2
		bne.s	loc_4164
		move.w	#$B8,d1
		cmpi.w	#$600,d0
		blo.s	loc_4148
		move.w	#$108,d1
		cmpi.w	#$200,(v_player+obY).w
		blo.s	loc_414E
		cmpi.w	#$C00,d0
		blo.s	loc_4148
		move.w	#$318,d1
		cmpi.w	#$1080,d0
		blo.s	loc_4148
		move.b	#$80,(f_switch+5).w
		move.w	#$5C8,d1
		cmpi.w	#$1380,d0
		blo.s	loc_4148
		move.w	#$3A8,d1
		cmp.w	(v_waterpos2).w,d1
		bne.s	loc_4148
		move.b	#1,(v_wtr_routine).w

loc_4148:
		move.w	d1,(v_waterpos3).w
		rts
; ---------------------------------------------------------------------------

loc_414E:
		cmpi.w	#$C80,d0
		blo.s	loc_4148
		move.w	#$E8,d1
		cmpi.w	#$1500,d0
		blo.s	loc_4148
		move.w	#$108,d1
		bra.s	loc_4148
; ---------------------------------------------------------------------------

loc_4164:
		subq.b	#1,d2
		bne.s	locret_4188
		cmpi.w	#$2E0,(v_player+obY).w
		bhs.s	locret_4188
		move.w	#$3A8,d1
		cmpi.w	#$1300,d0
		blo.s	loc_4184
		move.w	#$108,d1
		move.b	#2,(v_wtr_routine).w

loc_4184:
		move.w	d1,(v_waterpos3).w

locret_4188:
		rts
; ---------------------------------------------------------------------------

DynWater_HPZ2:
		move.w	(Camera_X_pos).w,d0		; leftover from Sonic 1's LZ2
		move.w	#$328,d1
		cmpi.w	#$500,d0
		blo.s	loc_41A6
		move.w	#$3C8,d1
		cmpi.w	#$B00,d0
		blo.s	loc_41A6
		move.w	#$428,d1

loc_41A6:
		move.w	d1,(v_waterpos3).w
		rts
; ---------------------------------------------------------------------------

DynWater_HPZ3:
		move.w	(Camera_X_pos).w,d0		; Leftover from Sonic 1's LZ3
		move.b	(v_wtr_routine).w,d2
		bne.s	loc_41F2
		move.w	#$900,d1
		cmpi.w	#$600,d0
		blo.s	loc_41E8
		cmpi.w	#$3C0,(v_player+obY).w
		blo.s	loc_41E8
		cmpi.w	#$600,(v_player+obY).w
		bhs.s	loc_41E8
		move.w	#$4C8,d1
		move.b	#$4B,(v_lvllayout+$206).w
		move.b	#1,(v_wtr_routine).w
		move.w	#sfx_Rumbling,d0
		bsr.w	QueueSound2

loc_41E8:
		move.w	d1,(v_waterpos3).w
		move.w	d1,(v_waterpos2).w
		rts
; ---------------------------------------------------------------------------

loc_41F2:
		subq.b	#1,d2
		bne.s	loc_423C
		move.w	#$4C8,d1
		cmpi.w	#$770,d0
		blo.s	loc_4236
		move.w	#$308,d1
		cmpi.w	#$1400,d0
		blo.s	loc_4236
		cmpi.w	#$508,(v_waterpos3).w
		beq.s	loc_4222
		cmpi.w	#$600,(v_player+obY).w
		bhs.s	loc_4222
		cmpi.w	#$280,(v_player+obY).w
		bhs.s	loc_4236

loc_4222:
		move.w	#$508,d1
		move.w	d1,(v_waterpos2).w
		cmpi.w	#$1770,d0
		blo.s	loc_4236
		move.b	#2,(v_wtr_routine).w

loc_4236:
		move.w	d1,(v_waterpos3).w
		rts
; ---------------------------------------------------------------------------

loc_423C:
		subq.b	#1,d2
		bne.s	loc_4266
		move.w	#$508,d1
		cmpi.w	#$1860,d0
		blo.s	loc_4260
		move.w	#$188,d1
		cmpi.w	#$1AF0,d0
		bhs.s	loc_425A
		cmp.w	(v_waterpos2).w,d1
		bne.s	loc_4260

loc_425A:
		move.b	#3,(v_wtr_routine).w

loc_4260:
		move.w	d1,(v_waterpos3).w
		rts
; ---------------------------------------------------------------------------

loc_4266:
		subq.b	#1,d2
		bne.s	loc_42A2
		move.w	#$188,d1
		cmpi.w	#$1AF0,d0
		blo.s	loc_4298
		move.w	#$900,d1
		cmpi.w	#$1BC0,d0
		blo.s	loc_4298
		move.b	#4,(v_wtr_routine).w
		move.w	#$608,(v_waterpos3).w
		move.w	#$7C0,(v_waterpos2).w
		move.b	#1,(f_switch+8).w
		rts
; ---------------------------------------------------------------------------

loc_4298:
		move.w	d1,(v_waterpos3).w
		move.w	d1,(v_waterpos2).w
		rts
; ---------------------------------------------------------------------------

loc_42A2:
		cmpi.w	#$1E00,d0
		blo.s	locret_42AE
		move.w	#$128,(v_waterpos3).w

locret_42AE:
		rts
; ---------------------------------------------------------------------------

DynWater_HPZ4:
		move.w	#$228,d1			; Leftover from Sonic 1's SBZ3
		cmpi.w	#$F00,(Camera_X_pos).w
		blo.s	loc_42C0
		move.w	#$4C8,d1

loc_42C0:
		move.w	d1,(v_waterpos3).w
		rts
; ---------------------------------------------------------------------------

S1_LZWindTunnels:					; leftover from Sonic 1's LZ
		tst.w	(Debug_placement_mode).w
		bne.w	locret_43A2
		lea	(S1LZWind_Data+8).l,a2
		moveq	#0,d0
		move.b	(Current_Act).w,d0
		lsl.w	#3,d0
		adda.w	d0,a2
		moveq	#0,d1
		tst.b	(Current_Act).w
		bne.s	loc_42EA
		moveq	#1,d1
		subq.w	#8,a2

loc_42EA:
		lea	(v_player).w,a1

loc_42EE:
		move.w	obX(a1),d0
		cmp.w	(a2),d0
		blo.w	loc_438C
		cmp.w	4(a2),d0
		bhs.w	loc_438C
		move.w	obY(a1),d2
		cmp.w	2(a2),d2
		blo.w	loc_438C
		cmp.w	6(a2),d2
		bhs.s	loc_438C
	if FixBugs
		; d0 is overwritten but later used as if it wasn't!
		move.w	d0,d1
	endif
		move.b	(Vint_runcount+3).w,d0
		andi.b	#$3F,d0
		bne.s	loc_4326
		move.w	#sfx_Waterfall,d0
		jsr	(QueueSound2).l

loc_4326:
		tst.b	(f_wtunnelallow).w
		bne.w	locret_43A2
		cmpi.b	#4,obRoutine(a1)
		bhs.s	loc_439E
		move.b	#1,(f_wtunnelmode).w
	if FixBugs
		; See above.
		move.w	d1,d0
	endif
		subi.w	#$80,d0
		cmp.w	(a2),d0
		bhs.s	loc_4354
		moveq	#2,d0
		cmpi.b	#1,(Current_Act).w
		bne.s	loc_4350
		neg.w	d0

loc_4350:
		add.w	d0,obY(a1)

loc_4354:
		addi.w	#4,obX(a1)
		move.w	#$400,obVelX(a1)
		move.w	#0,obVelY(a1)
		move.b	#AniIDSonAni_Float2,obAnim(a1)
		bset	#1,obStatus(a1)
		btst	#bitUp,(v_jpadhold1).w
		beq.s	loc_437E
		subq.w	#1,obY(a1)

loc_437E:
		btst	#bitDn,(v_jpadhold1).w
		beq.s	locret_438A
		addq.w	#1,obY(a1)

locret_438A:
		rts
; ---------------------------------------------------------------------------

loc_438C:
		addq.w	#8,a2
		dbf	d1,loc_42EE
		tst.b	(f_wtunnelmode).w
		beq.s	locret_43A2
		move.b	#AniIDSonAni_Walk,obAnim(a1)

loc_439E:
		clr.b	(f_wtunnelmode).w

locret_43A2:
		rts
; ---------------------------------------------------------------------------

		;    left, top,  right, bottom boundaries
S1LZWind_Data:	dc.w $A80, $300, $C10,  $380 ; act 1 values (set 1)
		dc.w $F80, $100, $1410,	$180 ; act 1 values (set 2)
		dc.w $460, $400, $710,  $480 ; act 2 values
		dc.w $A20, $600, $1610, $6E0 ; act 3 values
		dc.w $C80, $600, $13D0, $680 ; SBZ act 3 values
		even
; ---------------------------------------------------------------------------

S1_LZWaterSlides:
		lea	(v_player).w,a1
		btst	#1,obStatus(a1)
		bne.s	loc_4400
		move.w	obY(a1),d0
		andi.w	#$700,d0
		move.b	obX(a1),d1

loc_43E4:
		andi.w	#$7F,d1
		add.w	d1,d0
		lea	(v_lvllayout).w,a2
		move.b	(a2,d0.w),d0
		lea	Slide_Chunks_End(pc),a2
		moveq	#Slide_Chunks_End-Slide_Chunks-1,d1

loc_43F8:
		cmp.b	-(a2),d0
		dbeq	d1,loc_43F8
		beq.s	loc_4412

loc_4400:
		tst.b	(f_slidemode).w
		beq.s	locret_4410
		move.w	#5,locktime(a1)
		clr.b	(f_slidemode).w

locret_4410:
		rts
; ---------------------------------------------------------------------------

loc_4412:
		cmpi.w	#3,d1
		bhs.s	loc_441A
		nop

loc_441A:
		bclr	#0,obStatus(a1)
		move.b	Slide_Speeds(pc,d1.w),d0
		move.b	d0,obInertia(a1)
		bpl.s	loc_4430
		bset	#0,obStatus(a1)

loc_4430:
		clr.b	obInertia+1(a1)
		move.b	#AniIDSonAni_Slide,obAnim(a1)
		move.b	#1,(f_slidemode).w
		move.b	(Vint_runcount+3).w,d0
		andi.b	#$1F,d0
		bne.s	locret_4454
		move.w	#sfx_Waterfall,d0
		jsr	(QueueSound2).l

locret_4454:
		rts
; ---------------------------------------------------------------------------
Slide_Speeds:
		dc.b 10, -11, 10, -10, -11, -12, 11
		even

Slide_Chunks:
		dc.b 2, 7, 3, $4C, $4B, 8, 4
Slide_Chunks_End:
		even