; ---------------------------------------------------------------------------
; Object 4B - Buzzer from EHZ
; ---------------------------------------------------------------------------

Obj4B_PB:
		bra.w	$157E0+$2D0	; JmpTo6_DeleteObject
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj4B_PB_Index(pc,d0.w),d1
		jmp	Obj4B_PB_Index(pc,d1.w)
; ===========================================================================
Obj4B_PB_Index:	dc.w Obj4B_PB_Init-Obj4B_PB_Index
		dc.w Obj4B_PB_Main-Obj4B_PB_Index
		dc.w Obj4B_PB_Flame-Obj4B_PB_Index
		dc.w Obj4B_PB_Projectile-Obj4B_PB_Index
; ===========================================================================
; loc_167AA:
Obj4B_PB_Projectile:
		bsr.w	$157E0+$2E2	;	JmpTo6_ObjectMove
		lea	(Ani_Obj4B_PB).l,a1
		bsr.w	$157E0+$2D6	;	JmpTo5_AnimateSprite
		bra.w	$157E0+$2DC	;	JmpTo_MarkObjGone_P1
; ===========================================================================
; loc_167BC:
Obj4B_PB_Flame:
		movea.l	Obj4B_parent(a0),a1
		tst.b	(a1)
		beq.w	$157E0+$2D0	; JmpTo6_DeleteObject
		tst.w	Obj4B_turn_delay(a1)
		bmi.s	.loc_167CE
		rts
; ---------------------------------------------------------------------------

.loc_167CE:
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		move.b	obStatus(a1),obStatus(a0)
		move.b	obRender(a1),obRender(a0)
		lea	(Ani_Obj4B_PB).l,a1
		bsr.w	$157E0+$2D6	;	JmpTo5_AnimateSprite
		bra.w	$157E0+$2DC	;	JmpTo_MarkObjGone_P1
; ===========================================================================

Obj4B_PB_Init:
		move.l	#Map_Obj4B_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_Buzzer,0,0),obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#16,obActWid(a0)
		move.b	#16,obHeight(a0)
		move.b	#24,obWidth(a0)
		move.b	#3,obPriority(a0)
		addq.b	#2,obRoutine(a0)		; => Obj4B_PB_Main

		; load exhaust flame object
		bsr.w	FindNextFreeObj_PB
		bne.s	.locret_1689E

		_move.b	#id_Obj4B,obID(a1)			; load obj4B
		move.b	#4,obRoutine(a1)		; => Obj4B_PB_Flame
		move.l	#Map_Obj4B_PB,obMap(a1)
		move.w	#make_art_tile(ArtTile_Buzzer,0,0),obGfx(a1)
		move.b	#4,obPriority(a1)
		move.b	#16,obActWid(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	obRender(a0),obRender(a1)
		move.b	#1,obAnim(a1)
		move.l	a0,Obj4B_parent(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	#$100,Obj4B_move_timer(a0)
		move.w	#-$100,obVelX(a0)
		btst	#0,obRender(a0)
		beq.s	.locret_1689E
		neg.w	obVelX(a0)

.locret_1689E:
		rts
; ===========================================================================

Obj4B_PB_Main:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj4B_PB_Main_Index(pc,d0.w),d1
		jsr	Obj4B_PB_Main_Index(pc,d1.w)
		lea	(Ani_Obj4B_PB).l,a1
		bsr.w	$157E0+$2D6	;	JmpTo5_AnimateSprite
		bra.w	$157E0+$2DC	;	JmpTo_MarkObjGone_P1
; ===========================================================================
Obj4B_PB_Main_Index:	dc.w Obj4B_PB_Roaming-Obj4B_PB_Main_Index
		dc.w Obj4B_PB_Shooting-Obj4B_PB_Main_Index
; ===========================================================================
; loc_168C0:
Obj4B_PB_Roaming:
		bsr.w	Obj4B_PB_ChkPlayers
		subq.w	#1,Obj4B_turn_delay(a0)
		move.w	Obj4B_turn_delay(a0),d0
		cmpi.w	#15,d0
		beq.s	Obj4B_PB_TurnAround
		tst.w	d0
		bpl.s	.locret_168E4
		subq.w	#1,Obj4B_move_timer(a0)
		bgt.w	$157E0+$2E2	;	JmpTo6_ObjectMove
		move.w	#30,Obj4B_turn_delay(a0)

.locret_168E4:
		rts
; ---------------------------------------------------------------------------
; loc_168E6:
Obj4B_PB_TurnAround:
		sf.b	Obj4B_shooting_flag(a0)			; reenable shooting
		neg.w	obVelX(a0)			; reverse movement direction
		bchg	#0,obRender(a0)
		bchg	#0,obStatus(a0)
		move.w	#256,Obj4B_move_timer(a0)
		rts

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; sub_16902:
Obj4B_PB_ChkPlayers:
		tst.b	Obj4B_shooting_flag(a0)
		bne.w	Obj4B_PB_ReadyToShoot.locret_1694E			; branch, if shooting is disabled
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0		; a1=character
		move.w	d0,d1
		bpl.s	.loc_16918
		neg.w	d0

.loc_16918:
		; test if player is inside an 8 pixel wide strip
		cmpi.w	#$28,d0
		blt.s	Obj4B_PB_ReadyToShoot.locret_1694E
		cmpi.w	#$30,d0
		bgt.s	Obj4B_PB_ReadyToShoot.locret_1694E

		tst.w	d1				; test sign of distance
		bpl.s	Obj4B_PB_PlayerIsLeft		; branch, if player is left from object
		btst	#0,obRender(a0)
		beq.s	Obj4B_PB_ReadyToShoot.locret_1694E			; branch, if object is facing right
		bra.s	Obj4B_PB_ReadyToShoot
; ---------------------------------------------------------------------------
; loc_16932:
Obj4B_PB_PlayerIsLeft:
		btst	#0,obRender(a0)
		bne.s	Obj4B_PB_ReadyToShoot.locret_1694E			; branch, if object is facing left
; loc_1693A:
Obj4B_PB_ReadyToShoot:
		st.b	Obj4B_shooting_flag(a0)			; disable shooting
		addq.b	#2,ob2ndRout(a0)		; => Obj4B_Shooting
		move.b	#3,obAnim(a0)			; play shooting animation
		move.w	#50,Obj4B_shot_timer(a0)

.locret_1694E:
		rts
; End of function Obj4B_PB_ChkPlayers

; ===========================================================================
; loc_16950:
Obj4B_PB_Shooting:
		move.w	Obj4B_shot_timer(a0),d0		; get timer value
		subq.w	#1,d0				; decrement
		blt.s	Obj4B_PB_DoneShooting		; branch, if timer has expired
		move.w	d0,Obj4B_shot_timer(a0)		; update timer value
		cmpi.w	#$14,d0				; has timer reached a certain value?
		beq.s	Obj4B_PB_ShootProjectile		; if yes, branch
		rts
; ===========================================================================
; loc_16964:
Obj4B_PB_DoneShooting:
		subq.b	#2,ob2ndRout(a0)		; => Obj4B_Roaming
		rts
; ===========================================================================
; loc_1696A:
Obj4B_PB_ShootProjectile:
		jsr	(FindNextFreeObj_PB).l
		bne.s	.locret_169D8

		_move.b	#id_Obj4B,obID(a1)			; load obj4B
		move.b	#6,obRoutine(a1)		; => Obj4B_Projectile
		move.l	#Map_Obj4B_PB,obMap(a1)
		move.w	#make_art_tile(ArtTile_Buzzer,0,0),obGfx(a1)
		move.b	#4,obPriority(a1)
		move.b	#16,obActWid(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	obRender(a0),obRender(a1)
		move.b	#2,obAnim(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	#$180,obVelY(a1)
		move.w	#-$180,obVelX(a1)
		btst	#0,obRender(a1)			; is object facing left?
		beq.s	.locret_169D8			; if not, branch
		neg.w	obVelX(a1)			; move in other direction

.locret_169D8:
		rts