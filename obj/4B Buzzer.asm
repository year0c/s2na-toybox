; ---------------------------------------------------------------------------
; Object 4B - Buzzer from EHZ
; ---------------------------------------------------------------------------

Obj4B:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj4B_Index(pc,d0.w),d1
		jmp	Obj4B_Index(pc,d1.w)
; ===========================================================================
Obj4B_Index:	dc.w Obj4B_Init-Obj4B_Index
		dc.w Obj4B_Main-Obj4B_Index
		dc.w Obj4B_Flame-Obj4B_Index
		dc.w Obj4B_Projectile-Obj4B_Index
; ===========================================================================
; loc_167AA:
Obj4B_Projectile:
		bsr.w	j_ObjectMove_5
		lea	(Ani_obj4B).l,a1
		bsr.w	j_AnimateSprite_4
		bra.w	loc_16A8C
; ===========================================================================
; loc_167BC:
Obj4B_Flame:
		movea.l	objoff_2A(a0),a1
		tst.b	(a1)
		beq.w	loc_16A74
		tst.w	objoff_30(a1)
		bmi.s	loc_167CE
		rts
; ---------------------------------------------------------------------------

loc_167CE:
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		move.b	obStatus(a1),obStatus(a0)
		move.b	obRender(a1),obRender(a0)
		lea	(Ani_obj4B).l,a1
		bsr.w	j_AnimateSprite_4
		bra.w	loc_16A8C
; ===========================================================================

Obj4B_Init:
		move.l	#Map_obj4B,obMap(a0)
		move.w	#make_art_tile(ArtTile_Buzzer,0,0),obGfx(a0)
		bsr.w	j_Adjust2PArtPointer_2
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#$10,obActWid(a0)
		move.b	#$10,obHeight(a0)
		move.b	#$18,obWidth(a0)
		move.b	#3,obPriority(a0)
		addq.b	#2,obRoutine(a0)		; => Obj4B_Main

		; load exhaust flame object
		bsr.w	j_FindNextFreeObj_0
		bne.s	locret_1689E

		_move.b	#id_Obj4B,obID(a1)			; load obj4B
		move.b	#4,obRoutine(a1)		; => Obj4B_Flame
		move.l	#Map_obj4B,obMap(a1)
		move.w	#make_art_tile(ArtTile_Buzzer,0,0),obGfx(a1)
		bsr.w	j_Adjust2PArtPointer2
		move.b	#4,obPriority(a1)
		move.b	#$10,obActWid(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	obRender(a0),obRender(a1)
		move.b	#1,obAnim(a1)
		move.l	a0,objoff_2A(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	#$100,objoff_2E(a0)
		move.w	#-$100,obVelX(a0)
		btst	#0,obRender(a0)
		beq.s	locret_1689E
		neg.w	obVelX(a0)

locret_1689E:
		rts
; ===========================================================================

Obj4B_Main:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj4B_Main_Index(pc,d0.w),d1
		jsr	Obj4B_Main_Index(pc,d1.w)
		lea	(Ani_obj4B).l,a1
		bsr.w	j_AnimateSprite_4
		bra.w	loc_16A8C
; ===========================================================================
Obj4B_Main_Index:	dc.w Obj4B_Roaming-Obj4B_Main_Index
		dc.w Obj4B_Shooting-Obj4B_Main_Index
; ===========================================================================
; loc_168C0:
Obj4B_Roaming:
		bsr.w	Obj4B_ChkPlayers
		subq.w	#1,objoff_30(a0)
		move.w	objoff_30(a0),d0
		cmpi.w	#15,d0
		beq.s	Obj4B_TurnAround
		tst.w	d0
		bpl.s	locret_168E4
		subq.w	#1,objoff_2E(a0)
		bgt.w	j_ObjectMove_5
		move.w	#30,objoff_30(a0)

locret_168E4:
		rts
; ---------------------------------------------------------------------------
; loc_168E6:
Obj4B_TurnAround:
		sf	objoff_32(a0)			; reenable shooting
		neg.w	obVelX(a0)			; reverse movement direction
		bchg	#0,obRender(a0)
		bchg	#0,obStatus(a0)
		move.w	#$100,objoff_2E(a0)
		rts

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; sub_16902:
Obj4B_ChkPlayers:
		tst.b	objoff_32(a0)
		bne.w	locret_1694E			; branch, if shooting is disabled
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0		; a1=character
		move.w	d0,d1
		bpl.s	loc_16918
		neg.w	d0

loc_16918:
		; test if player is inside an 8 pixel wide strip
		cmpi.w	#$28,d0
		blt.s	locret_1694E
		cmpi.w	#$30,d0
		bgt.s	locret_1694E

		tst.w	d1				; test sign of distance
		bpl.s	Obj4B_PlayerIsLeft		; branch, if player is left from object
		btst	#0,obRender(a0)
		beq.s	locret_1694E			; branch, if object is facing right
		bra.s	Obj4B_ReadyToShoot
; ---------------------------------------------------------------------------
; loc_16932:
Obj4B_PlayerIsLeft:
		btst	#0,obRender(a0)
		bne.s	locret_1694E			; branch, if object is facing left
; loc_1693A:
Obj4B_ReadyToShoot:
		st	objoff_32(a0)			; disable shooting
		addq.b	#2,ob2ndRout(a0)		; => Obj4B_Shooting
		move.b	#3,obAnim(a0)			; play shooting animation
		move.w	#$32,objoff_34(a0)

locret_1694E:
		rts
; End of function Obj4B_ChkPlayers

; ===========================================================================
; loc_16950:
Obj4B_Shooting:
		move.w	objoff_34(a0),d0		; get timer value
		subq.w	#1,d0				; decrement
		blt.s	Obj4B_DoneShooting		; branch, if timer has expired
		move.w	d0,objoff_34(a0)		; update timer value
		cmpi.w	#$14,d0				; has timer reached a certain value?
		beq.s	Obj4B_ShootProjectile		; if yes, branch
		rts
; ===========================================================================
; loc_16964:
Obj4B_DoneShooting:
		subq.b	#2,ob2ndRout(a0)		; => Obj4B_Roaming
		rts
; ===========================================================================
; loc_1696A:
Obj4B_ShootProjectile:
		jsr	(FindNextFreeObj).l
		bne.s	locret_169D8

		_move.b	#id_Obj4B,obID(a1)			; load obj4B
		move.b	#6,obRoutine(a1)		; => Obj4B_Projectile
		move.l	#Map_obj4B,obMap(a1)
		move.w	#make_art_tile(ArtTile_Buzzer,0,0),obGfx(a1)
		bsr.w	j_Adjust2PArtPointer2
		move.b	#4,obPriority(a1)
		move.b	#$98,obColType(a1)
		move.b	#$10,obActWid(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	obRender(a0),obRender(a1)
		move.b	#2,obAnim(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
	if FixBugs
		move.w	#13,d0				; absolute horizontal offset for stinger
	else
		; Bug: This object is missing an absolute horizontal offset for the stinger.
	endif
		move.w	#$180,obVelY(a1)
		move.w	#-$180,obVelX(a1)
		btst	#0,obRender(a1)			; is object facing left?
		beq.s	locret_169D8			; if not, branch
		neg.w	obVelX(a1)			; move in other direction
	if FixBugs
		neg.w	d0				; make offset negative
	endif

locret_169D8:
	if FixBugs
		add.w	d0,obX(a1)			; align horizontally with stinger
	endif
		rts