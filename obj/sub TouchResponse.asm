; ---------------------------------------------------------------------------
; Subroutine to react to obColType(a0)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


TouchResponse:
		nop
		jsrto	JmpTo_Touch_Rings
		move.w	obX(a0),d2
		move.w	obY(a0),d3
		subi.w	#8,d2
		moveq	#0,d5
		move.b	obHeight(a0),d5
		subq.b	#3,d5
		sub.w	d5,d3
	if FixBugs
		cmpi.b	#AniIDSonAni_Duck,obAnim(a0)
	else
		; Bug: This does not check either player's ducking frame!
		; Sonic's ducking frame is $80, and Tails's frame is $5B.
		; However, this does work for Sonic 1's mapping frames.
		cmpi.b	#$39,obFrame(a0)
	endif
		bne.s	loc_19812
		addi.w	#$C,d3
		moveq	#10,d5

loc_19812:
		move.w	#16,d4
		add.w	d5,d5
		lea	(v_lvlobjspace).w,a1
		move.w	#bytesToXcnt(v_lvlobjend-v_lvlobjspace,object_size),d6

loc_19820:
		move.b	obColType(a1),d0
		bne.s	Touch_Height

loc_19826:
		lea	object_size(a1),a1
		dbf	d6,loc_19820
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------
Touch_Sizes:
		dc.b $14,$14
		dc.b  $C,$14
		dc.b $14, $C
		dc.b   4,$10
		dc.b  $C,$12
		dc.b $10,$10
		dc.b   6,  6
		dc.b $18, $C
		dc.b  $C,$10
		dc.b $10, $C
		dc.b   8,  8
		dc.b $14,$10
		dc.b $14,  8
		dc.b  $E, $E
		dc.b $18,$18
		dc.b $28,$10
		dc.b $10,$18
		dc.b   8,$10
		dc.b $20,$70
		dc.b $40,$20
		dc.b $80,$20
		dc.b $20,$20
		dc.b   8,  8
		dc.b   4,  4
		dc.b $20,  8
		dc.b  $C, $C
		dc.b   8,  4
		dc.b $18,  4
		dc.b $28,  4
		dc.b   4,  8
		dc.b   4,$18
		dc.b   4,$28
		dc.b   4,$20
		dc.b $18,$18
		dc.b  $C,$18
		dc.b $48,  8
; ---------------------------------------------------------------------------

Touch_Height:
		andi.w	#$3F,d0
		add.w	d0,d0
		lea	Touch_Sizes-2(pc,d0.w),a2
		moveq	#0,d1
		move.b	(a2)+,d1
		move.w	obX(a1),d0
		sub.w	d1,d0
		sub.w	d2,d0
		bhs.s	loc_1989C
		add.w	d1,d1
		add.w	d1,d0
		blo.s	loc_198A2
		bra.w	loc_19826
; ---------------------------------------------------------------------------

loc_1989C:
		cmp.w	d4,d0
		bhi.w	loc_19826

loc_198A2:
		moveq	#0,d1
		move.b	(a2)+,d1
		move.w	obY(a1),d0
		sub.w	d1,d0
		sub.w	d3,d0
		bhs.s	loc_198BA
		add.w	d1,d1
		add.w	d1,d0
		blo.s	loc_198C0
		bra.w	loc_19826
; ---------------------------------------------------------------------------

loc_198BA:
		cmp.w	d5,d0
		bhi.w	loc_19826

loc_198C0:
		move.b	obColType(a1),d1
		andi.b	#$C0,d1
		beq.w	loc_1993A
		cmpi.b	#$C0,d1
		beq.w	Touch_Special
		tst.b	d1
		bmi.w	loc_199F2
		move.b	obColType(a1),d0
		andi.b	#$3F,d0
		cmpi.b	#6,d0
		beq.s	loc_198FA
		cmpi.w	#90,flashtime(a0)
		bhs.w	locret_198F8
		move.b	#4,obRoutine(a1)

locret_198F8:
		rts
; ---------------------------------------------------------------------------

loc_198FA:
		tst.w	obVelY(a0)
		bpl.s	loc_19926
		move.w	obY(a0),d0
		subi.w	#$10,d0
		cmp.w	obY(a1),d0
		blo.s	locret_19938

loc_1990E:
		neg.w	obVelY(a0)

loc_19912:
		move.w	#-$180,obVelY(a1)
		tst.b	ob2ndRout(a1)
		bne.s	locret_19938
		move.b	#4,ob2ndRout(a1)
		rts
; ---------------------------------------------------------------------------

loc_19926:
		cmpi.b	#AniIDSonAni_Roll,obAnim(a0)
		bne.s	locret_19938
		neg.w	obVelY(a0)
		move.b	#4,obRoutine(a1)

locret_19938:
		rts
; ---------------------------------------------------------------------------

loc_1993A:
		tst.b	(v_invinc).w
		bne.s	loc_19952
		cmpi.b	#AniIDSonAni_Spindash,obAnim(a0)
		beq.s	loc_19952
		cmpi.b	#AniIDSonAni_Roll,obAnim(a0)
		bne.w	loc_199F2

loc_19952:
		tst.b	obColProp(a1)
		beq.s	Touch_KillEnemy
		neg.w	obVelX(a0)
		neg.w	obVelY(a0)
		asr.w	obVelX(a0)
		asr.w	obVelY(a0)
		move.b	#0,obColType(a1)
		subq.b	#1,obColProp(a1)
		bne.s	locret_1997A
		bset	#7,obStatus(a1)

locret_1997A:
		rts
; ---------------------------------------------------------------------------

Touch_KillEnemy:
		bset	#7,obStatus(a1)
		moveq	#0,d0
		move.w	(v_itembonus).w,d0
		addq.w	#2,(v_itembonus).w
		cmpi.w	#6,d0
		blo.s	loc_19994
		moveq	#6,d0

loc_19994:
		move.w	d0,objoff_3E(a1)
		move.w	Enemy_Points(pc,d0.w),d0
		cmpi.w	#$20,(v_itembonus).w
		blo.s	loc_199AE
		move.w	#1000,d0
		move.w	#10,objoff_3E(a1)

loc_199AE:
		bsr.w	AddPoints
		_move.b	#id_Obj27,obID(a1)
		move.b	#0,obRoutine(a1)
		tst.w	obVelY(a0)
		bmi.s	loc_199D4
		move.w	obY(a0),d0
		cmp.w	obY(a1),d0
		bhs.s	loc_199DC
		neg.w	obVelY(a0)
		rts
; ---------------------------------------------------------------------------

loc_199D4:
		addi.w	#$100,obVelY(a0)
		rts
; ---------------------------------------------------------------------------

loc_199DC:
		subi.w	#$100,obVelY(a0)
		rts
; ---------------------------------------------------------------------------
Enemy_Points:
		dc.w	10
		dc.w	20
		dc.w	50
		dc.w	100
; ---------------------------------------------------------------------------

loc_199EC:
		bset	#7,obStatus(a1)

loc_199F2:
		tst.b	(v_invinc).w
		beq.s	Touch_Hurt

loc_199F8:
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

Touch_Hurt:
		nop
		tst.w	flashtime(a0)
		bne.s	loc_199F8
		movea.l	a1,a2
; End of function TouchResponse


; =============== S U B	R O U T	I N E =======================================


HurtSonic:
		tst.b	(v_shield).w
		bne.s	.hasshield
		tst.w	(v_rings).w
		beq.w	.norings

		jsr	(FindFreeObj).l
		bne.s	.hasshield
		_move.b	#id_Obj37,obID(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)

.hasshield:
		move.b	#0,(v_shield).w
		move.b	#4,obRoutine(a0)
		jsrto	JmpTo_Sonic_ResetOnFloor
		bset	#1,obStatus(a0)
		move.w	#-$400,obVelY(a0)
		move.w	#-$200,obVelX(a0)
		btst	#6,obStatus(a0)
		beq.s	.isdry

		move.w	#-$200,obVelY(a0)
		move.w	#-$100,obVelX(a0)

.isdry:
		move.w	obX(a0),d0
		cmp.w	obX(a2),d0
		blo.s	.isleft
		neg.w	obVelX(a0)

.isleft:
		move.w	#0,obInertia(a0)
		move.b	#AniIDSonAni_Hurt,obAnim(a0)
		move.w	#120,flashtime(a0)
	if FixBugs
		move.w	#sfx_HitSpikes,d0
		cmpi.b	#id_Obj36,obID(a2)	; was damage caused by spikes?
		beq.s	.sound
		cmpi.b	#id_Obj16,obID(a2)	; was damage caused by LZ harpoon?
		beq.s	.sound
		move.w	#sfx_Death,d0
	else
		; This is bugged: the harpoon will never play the spike sound!
		move.w	#sfx_Death,d0
		cmpi.b	#id_Obj36,obID(a2)	; was damage caused by spikes?
		bne.s	.sound
		cmpi.b	#id_Obj16,obID(a2)	; was damage caused by LZ harpoon?
		bne.s	.sound
		move.w	#sfx_HitSpikes,d0
	endif

.sound:
		jsr	(QueueSound2).l
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------

.norings:
		tst.w	(Debug_mode_flag).w
		bne.w	.hasshield
; End of function HurtSonic


; =============== S U B	R O U T	I N E =======================================


KillCharacter:
		tst.w	(Debug_placement_mode).w
		bne.s	Kill_NoDeath
		move.b	#0,(v_invinc).w
		move.b	#6,obRoutine(a0)
		jsrto	JmpTo_Sonic_ResetOnFloor
		bset	#1,obStatus(a0)
		move.w	#-$700,obVelY(a0)
		move.w	#0,obVelX(a0)
		move.w	#0,obInertia(a0)
	if FixBugs=0
		; Leftover line from the prototype, where objoff_38 was used to respawn Sonic at his last y position.
		; sticktoconvex gets overwritten with the high byte of Sonic's y position.
		; It is made redundant as Sonic doesn't react to solids when he dies.
		; It was removed in the CENSOR prototype of Sonic 2 onwards.
		move.w	obY(a0),objoff_38(a0)
	endif
		move.b	#AniIDSonAni_Death,obAnim(a0)
		bset	#7,obGfx(a0)
		move.w	#sfx_Death,d0
		cmpi.b	#id_Obj36,obID(a2)
		bne.s	loc_19AF8
		move.w	#sfx_HitSpikes,d0

loc_19AF8:
		jsr	(QueueSound2).l

Kill_NoDeath:
		moveq	#-1,d0
		rts
; End of function KillCharacter

; ---------------------------------------------------------------------------

Touch_Special:
		move.b	obColType(a1),d1
		andi.b	#$3F,d1
		cmpi.b	#$B,d1
		beq.s	Touch_Caterkiller
		cmpi.b	#$C,d1
		beq.s	Touch_Yadrin
		cmpi.b	#$17,d1
		beq.s	Touch_D7
		cmpi.b	#$21,d1
		beq.s	Touch_E1
		rts
; ---------------------------------------------------------------------------

Touch_Caterkiller:
		bra.w	loc_199EC
; ---------------------------------------------------------------------------

Touch_Yadrin:
		sub.w	d0,d5
		cmpi.w	#8,d5
		bhs.s	loc_19B56
		move.w	obX(a1),d0
		subq.w	#4,d0
		btst	#0,obStatus(a1)
		beq.s	loc_19B42
		subi.w	#$10,d0

loc_19B42:
		sub.w	d2,d0
		bhs.s	loc_19B4E
		addi.w	#$18,d0
		blo.s	loc_19B52
		bra.s	loc_19B56
; ---------------------------------------------------------------------------

loc_19B4E:
		cmp.w	d4,d0
		bhi.s	loc_19B56

loc_19B52:
		bra.w	loc_199F2
; ---------------------------------------------------------------------------

loc_19B56:
		bra.w	loc_1993A
; ---------------------------------------------------------------------------

Touch_D7:
		move.w	a0,d1
		subi.w	#v_objspace,d1
		beq.s	loc_19B66
		addq.b	#1,obColProp(a1)

loc_19B66:
		addq.b	#1,obColProp(a1)
		rts
; ---------------------------------------------------------------------------

Touch_E1:
		addq.b	#1,obColProp(a1)
		rts