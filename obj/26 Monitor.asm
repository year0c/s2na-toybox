;----------------------------------------------------
; Object 26 - monitor
;----------------------------------------------------

Obj26:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj26_Index(pc,d0.w),d1
		jmp	Obj26_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj26_Index:	dc.w loc_AE70-Obj26_Index
		dc.w loc_AED6-Obj26_Index
		dc.w loc_AFDC-Obj26_Index
		dc.w loc_AFBA-Obj26_Index
		dc.w loc_AFC4-Obj26_Index
; ---------------------------------------------------------------------------

loc_AE70:
		addq.b	#2,obRoutine(a0)
		move.b	#$E,obHeight(a0)
		move.b	#$E,obWidth(a0)
		move.l	#Map_Obj26,obMap(a0)
		move.w	#make_art_tile(ArtTile_Monitor,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#$F,obActWid(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
	if FixBugs
		; If you spawn a monitor in Debug Mode and destroy it, then every
		; monitor that is spawned with Debug Mode afterwards will be broken.
		; The cause of the bug is that the spawned monitor does not have a
		; respawn entry, but this object fails to check for that before
		; accessing the respawn table.
		; Knuckles in Sonic 2 contains this half of the bugfix, but not the
		; other half under 'Obj26_SpawnSmoke'.
		beq.s	loc_AECA
	endif
		bclr	#7,2(a2,d0.w)
		btst	#0,2(a2,d0.w)
		beq.s	loc_AECA
		move.b	#8,obRoutine(a0)
		move.b	#$B,obFrame(a0)
		rts
; ---------------------------------------------------------------------------

loc_AECA:
		move.b	#$46,obColType(a0)
		move.b	obSubtype(a0),obAnim(a0)

loc_AED6:
		move.b	ob2ndRout(a0),d0
		beq.s	loc_AF30
		subq.b	#2,d0
		bne.s	loc_AF10
		moveq	#0,d1
		move.b	obActWid(a0),d1
		addi.w	#$B,d1
		bsr.w	sub_F9C8
		btst	#3,obStatus(a1)
		bne.w	loc_AF00
		clr.b	ob2ndRout(a0)
		bra.w	loc_AFBA
; ---------------------------------------------------------------------------

loc_AF00:
		move.w	#$10,d3
		move.w	obX(a0),d2
		bsr.w	MvSonicOnPtfm
		bra.w	loc_AFBA
; ---------------------------------------------------------------------------

loc_AF10:
		bsr.w	ObjectMoveAndFall
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.w	loc_AFBA
		add.w	d1,obY(a0)
		clr.w	obVelY(a0)
		clr.b	ob2ndRout(a0)
		bra.w	loc_AFBA
; ---------------------------------------------------------------------------

loc_AF30:
		move.w	#$1A,d1
		move.w	#$F,d2
		bsr.w	Obj26_SolidSides
		beq.w	loc_AFA0
		tst.w	obVelY(a1)
		bmi.s	loc_AF4E
		cmpi.b	#AniIDSonAni_Roll,obAnim(a1)
		beq.s	loc_AFA0

loc_AF4E:
		tst.w	d1
		bpl.s	loc_AF64
		sub.w	d3,obY(a1)
		bsr.w	RideObject_SetRide
		move.b	#2,ob2ndRout(a0)
		bra.w	loc_AFBA
; ---------------------------------------------------------------------------

loc_AF64:
		tst.w	d0
		beq.w	loc_AF8A
		bmi.s	loc_AF74
		tst.w	obVelX(a1)
		bmi.s	loc_AF8A
		bra.s	loc_AF7A
; ---------------------------------------------------------------------------

loc_AF74:
		tst.w	obVelX(a1)
		bpl.s	loc_AF8A

loc_AF7A:
		sub.w	d0,obX(a1)
		move.w	#0,obInertia(a1)
		move.w	#0,obVelX(a1)

loc_AF8A:
		btst	#1,obStatus(a1)
		bne.s	loc_AFAE
		bset	#5,obStatus(a1)
		bset	#5,obStatus(a0)
		bra.s	loc_AFBA
; ---------------------------------------------------------------------------

loc_AFA0:
		btst	#5,obStatus(a0)
		beq.s	loc_AFBA
		move.w	#1,obAnim(a1)

loc_AFAE:
		bclr	#5,obStatus(a0)
		bclr	#5,obStatus(a1)

loc_AFBA:
		lea	(Ani_obj26).l,a1
		bsr.w	AnimateSprite

loc_AFC4:
		out_of_range.w	DeleteObject
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_AFDC:
		addq.b	#2,obRoutine(a0)
		move.b	#0,obColType(a0)
		bsr.w	FindFreeObj
		bne.s	loc_B004
		_move.b	#id_Obj2E,obID(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	obAnim(a0),obAnim(a1)

loc_B004:
		bsr.w	FindFreeObj
		bne.s	loc_B020
		_move.b	#id_Obj27,obID(a1)
		addq.b	#2,obRoutine(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)

loc_B020:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
	if FixBugs
		; If you spawn a monitor in Debug Mode and destroy it, then every
		; monitor that is spawned with Debug Mode afterwards will be broken.
		; The cause of the bug is that the spawned monitor does not have a
		; respawn entry, but this object fails to check for that before
		; accessing the respawn table.
		beq.s	.next
	endif
		bset	#0,2(a2,d0.w)

.next:
		move.b	#$A,obAnim(a0)
		bra.w	DisplaySprite