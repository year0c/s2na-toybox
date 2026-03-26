; ===========================================================================
;----------------------------------------------------------------------------
; Object 25 - Rings
;----------------------------------------------------------------------------

Obj25:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj25_Index(pc,d0.w),d1
		jmp	Obj25_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj25_Index:	dc.w loc_A81C-Obj25_Index
		dc.w loc_A88A-Obj25_Index
		dc.w loc_A8A6-Obj25_Index
		dc.w loc_A8CC-Obj25_Index
		dc.w loc_A8DA-Obj25_Index
; ---------------------------------------------------------------------------
; Distances between rings (format: horizontal, vertical)
; ---------------------------------------------------------------------------
; unused table from S1
;Ring_PosData:
		dc.b $10, 0		; horizontal tight
		dc.b $18, 0		; horizontal normal
		dc.b $20, 0		; horizontal wide
		dc.b 0,	$10		; vertical tight
		dc.b 0,	$18		; vertical normal
		dc.b 0,	$20		; vertical wide
		dc.b $10, $10		; diagonal
		dc.b $18, $18
		dc.b $20, $20
		dc.b $F0, $10
		dc.b $E8, $18
		dc.b $E0, $20
		dc.b $10, 8
		dc.b $18, $10
		dc.b $F0, 8
		dc.b $E8, $10
; ---------------------------------------------------------------------------

loc_A81C:
		movea.l	a0,a1
		moveq	#0,d1
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		bra.s	loc_A832
; ---------------------------------------------------------------------------

loc_A82A:
		swap	d1
		bsr.w	FindFreeObj
		bne.s	loc_A88A

loc_A832:
		_move.b	#id_Obj25,obID(a1)
		addq.b	#2,obRoutine(a1)
		move.w	d2,obX(a1)
		move.w	obX(a0),objoff_32(a1)
		move.w	d3,obY(a1)
		move.l	#Map_Ring,obMap(a1)
		move.w	#make_art_tile(ArtTile_Ring,1,0),obGfx(a1)
		bsr.w	Adjust2PArtPointer2
		move.b	#4,obRender(a1)
		move.b	#2,obPriority(a1)
		move.b	#$47,obColType(a1)
		move.b	#8,obActWid(a1)
		move.b	obRespawnNo(a0),obRespawnNo(a1)
		move.b	d1,objoff_34(a1)
		addq.w	#1,d1
		add.w	d5,d2
		add.w	d6,d3
		swap	d1
		dbf	d1,loc_A82A

loc_A88A:
		move.b	(v_ani1_frame).w,obFrame(a0)
		out_of_range.s	loc_A8DA,objoff_32(a0)
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_A8A6:
		addq.b	#2,obRoutine(a0)
		move.b	#0,obColType(a0)
		move.b	#1,obPriority(a0)
		bsr.w	CollectRing
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		move.b	objoff_34(a0),d1
		bset	d1,2(a2,d0.w)

loc_A8CC:
		lea	(Ani_Obj25).l,a1
		bsr.w	AnimateSprite
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_A8DA:
		bra.w	DeleteObject

; =============== S U B	R O U T	I N E =======================================


CollectRing:
		addq.w	#1,(v_rings).w	; add 1 to rings
		ori.b	#1,(f_ringcount).w ; update the rings counter
		move.w	#sfx_Ring,d0	; play ring sound
		cmpi.w	#100,(v_rings).w ; do you have < 100 rings?
		blo.s	.playsnd	; if yes, branch
		bset	#1,(v_lifecount).w ; update lives counter
		beq.s	.got100
		cmpi.w	#200,(v_rings).w ; do you have < 200 rings?
		blo.s	.playsnd	; if yes, branch
		bset	#2,(v_lifecount).w ; update lives counter
		bne.s	.playsnd

.got100:
		addq.b	#1,(v_lives).w	; add 1 to the number of lives you have
		addq.b	#1,(f_lifecount).w ; update the lives counter
		move.w	#bgm_ExtraLife,d0 ; play extra life music

.playsnd:
		jmp	(QueueSound2).l
; End of function CollectRing

; ---------------------------------------------------------------------------
;----------------------------------------------------
; Object 37 - Rings flying out of you when you get hit
;----------------------------------------------------

Obj37:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj37_Index(pc,d0.w),d1
		jmp	Obj37_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj37_Index:	dc.w loc_A936-Obj37_Index
		dc.w loc_A9FA-Obj37_Index
		dc.w loc_AA4C-Obj37_Index
		dc.w loc_AA60-Obj37_Index
		dc.w loc_AA6E-Obj37_Index
; ---------------------------------------------------------------------------

loc_A936:
		movea.l	a0,a1
		moveq	#0,d5
		move.w	(v_rings).w,d5
		moveq	#32,d0
		cmp.w	d0,d5
		blo.s	loc_A946
		move.w	d0,d5

loc_A946:
		subq.w	#1,d5
		move.w	#$288,d4
		bra.s	loc_A956
; ---------------------------------------------------------------------------

loc_A94E:
		bsr.w	FindFreeObj
		bne.w	loc_A9DE

loc_A956:
		_move.b	#id_Obj37,obID(a1)
		addq.b	#2,obRoutine(a1)
		move.b	#8,obHeight(a1)
		move.b	#8,obWidth(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.l	#Map_Ring,obMap(a1)
		move.w	#make_art_tile(ArtTile_Ring,1,0),obGfx(a1)
		bsr.w	Adjust2PArtPointer2
		move.b	#4,obRender(a1)
		move.b	#3,obPriority(a1)
		move.b	#$47,obColType(a1)
		move.b	#8,obActWid(a1)
	if FixBugs=0
		; This resets the timer for all spilled rings,
		; even if they were already close to getting deleted
		; https://info.sonicretro.org/SCHG_How-to:Fix_Ring_Timers
		move.b	#-1,(v_ani3_time).w
	endif
		tst.w	d4
		bmi.s	loc_A9CE
		move.w	d4,d0
		bsr.w	CalcSine
		move.w	d4,d2
		lsr.w	#8,d2
		asl.w	d2,d0
		asl.w	d2,d1
		move.w	d0,d2
		move.w	d1,d3
		addi.b	#$10,d4
		bcc.s	loc_A9CE
		subi.w	#$80,d4
		bcc.s	loc_A9CE
		move.w	#$288,d4

loc_A9CE:
		move.w	d2,obVelX(a1)
		move.w	d3,obVelY(a1)
		neg.w	d2
		neg.w	d4
		dbf	d5,loc_A94E

loc_A9DE:
		move.w	#0,(v_rings).w
		move.b	#$80,(f_ringcount).w
		move.b	#0,(v_lifecount).w

	if FixBugs
		; Fix Ring Timers
		; https://info.sonicretro.org/SCHG_How-to:Fix_Ring_Timers
		moveq	#-1,d0			; Move 255 to d0
		move.b	d0,obDelayAni(a0)	; Move d0 to new timer
		move.b	d0,(v_ani3_time).w	; Move d0 to old timer (for animated purposes)
	endif
		move.w	#sfx_RingLoss,d0
		jsr	(QueueSound2).l

loc_A9FA:
		move.b	(v_ani3_frame).w,obFrame(a0)
		bsr.w	ObjectMove
		addi.w	#$18,obVelY(a0)
		bmi.s	loc_AA34
		move.b	(Vint_runcount+3).w,d0
		add.b	d7,d0
		andi.b	#3,d0
		bne.s	loc_AA34
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	loc_AA34
		add.w	d1,obY(a0)
		move.w	obVelY(a0),d0
		asr.w	#2,d0
		sub.w	d0,obVelY(a0)
		neg.w	obVelY(a0)

loc_AA34:
	if FixBugs
		; Fix Ring Timers
		; https://info.sonicretro.org/SCHG_How-to:Fix_Ring_Timers
		subq.b	#1,obDelayAni(a0)	; Subtract 1
		beq.w	DeleteObject		; If 0, delete
	else
		tst.b	(v_ani3_time).w
		beq.s	loc_AA6E
	endif

	if FixBugs
		; Fix Accidental Deletion of Scattered Rings
		; https://info.sonicretro.org/SCHG_How-to:Fix_Accidental_Deletion_of_Scattered_Rings
		tst.w	(v_limittop2).w		; is vertical wrapping enabled?
		bmi.w	DisplaySprite		; if so, don't delete rings by boundary
	endif
		move.w	(Camera_Max_Y_pos).w,d0
		addi.w	#224,d0
		cmp.w	obY(a0),d0
		blo.s	loc_AA6E
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_AA4C:
		addq.b	#2,obRoutine(a0)
		move.b	#0,obColType(a0)
		move.b	#1,obPriority(a0)
		bsr.w	CollectRing

loc_AA60:
		lea	(Ani_Obj25).l,a1
		bsr.w	AnimateSprite
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_AA6E:
		bra.w	DeleteObject