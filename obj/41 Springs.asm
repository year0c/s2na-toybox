; ---------------------------------------------------------------------------
; Object 41 - springs
; ---------------------------------------------------------------------------

Obj41:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj41_Index(pc,d0.w),d1
		jsr	Obj41_Index(pc,d1.w)
		tst.w	(Two_player_mode).w
		beq.s	loc_E1E0
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

loc_E1E0:
		out_of_range.w	DeleteObject
		bra.w	DisplaySprite
; ===========================================================================
Obj41_Index:	dc.w Obj41_Init-Obj41_Index		; 0
		dc.w Obj41_Up-Obj41_Index		; 2
		dc.w Obj41_Horizontal-Obj41_Index	; 4
		dc.w Obj41_Down-Obj41_Index		; 6
		dc.w Obj41_DiagonallyUp-Obj41_Index	; 8
		dc.w Obj41_DiagonallyDown-Obj41_Index	; $A
; ============================================================================
; loc_E204:
Obj41_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_obj41_GHZ,obMap(a0)
		move.w	#make_art_tile(ArtTile_S1_Spring_Horizontal,0,0),obGfx(a0)
		tst.b	(Current_Zone).w
		beq.s	loc_E22A
		move.l	#Map_obj41,obMap(a0)
		move.w	#make_art_tile(ArtTile_Spring_Vertical,0,0),obGfx(a0)

loc_E22A:
		ori.b	#4,obRender(a0)
		move.b	#$10,obActWid(a0)
		move.b	#4,obPriority(a0)
		move.b	obSubtype(a0),d0
		lsr.w	#3,d0
		andi.w	#$E,d0
		move.w	Obj41_Init_Subtypes(pc,d0.w),d0
		jmp	Obj41_Init_Subtypes(pc,d0.w)
; ===========================================================================
Obj41_Init_Subtypes:
		dc.w Obj41_Init_Common-Obj41_Init_Subtypes
		dc.w Obj41_Init_Horizontal-Obj41_Init_Subtypes
		dc.w Obj41_Init_Down-Obj41_Init_Subtypes
		dc.w Obj41_Init_DiagonallyUp-Obj41_Init_Subtypes
		dc.w Obj41_Init_DiagonallyDown-Obj41_Init_Subtypes
; ===========================================================================
; loc_E258:
Obj41_Init_Horizontal:
		move.b	#4,obRoutine(a0)
		move.b	#2,obAnim(a0)
		move.b	#3,obFrame(a0)
		move.w	#make_art_tile(ArtTile_S1_Spring_Vertical,0,0),obGfx(a0)
		tst.b	(Current_Zone).w
		beq.s	loc_E27C
		move.w	#make_art_tile(ArtTile_Spring_Horizontal,0,0),obGfx(a0)

loc_E27C:
		move.b	#8,obActWid(a0)
		bra.s	Obj41_Init_Common
; ===========================================================================
; loc_E284:
Obj41_Init_Down:
		move.b	#6,obRoutine(a0)
		move.b	#6,obFrame(a0)
		bset	#1,obStatus(a0)
		bra.s	Obj41_Init_Common
; ===========================================================================
; loc_E298:
Obj41_Init_DiagonallyUp:
		move.b	#8,obRoutine(a0)
		move.b	#4,obAnim(a0)
		move.b	#7,obFrame(a0)
		move.w	#make_art_tile(ArtTile_Spring_Diagonal,0,0),obGfx(a0)
		bra.s	Obj41_Init_Common
; ===========================================================================
; loc_E2B2:
Obj41_Init_DiagonallyDown:
		move.b	#$A,obRoutine(a0)
		move.b	#4,obAnim(a0)
		move.b	#$A,obFrame(a0)
		move.w	#make_art_tile(ArtTile_Spring_Diagonal,0,0),obGfx(a0)
		bset	#1,obStatus(a0)
; loc_E2D0:
Obj41_Init_Common:
		move.b	obSubtype(a0),d0
		andi.w	#2,d0
		move.w	Obj41_Strengths(pc,d0.w),$30(a0)
		btst	#1,d0
		beq.s	loc_E2F8
		bset	#5,obGfx(a0)
		tst.b	(Current_Zone).w
		beq.s	loc_E2F8
		move.l	#Map_obj41a,obMap(a0)

loc_E2F8:
		bsr.w	Adjust2PArtPointer
		rts
; ===========================================================================
; word_E2FE:
Obj41_Strengths:
		dc.w -$1000
		dc.w -$A00
; ===========================================================================
; loc_E302:
Obj41_Up:
		move.w	#$1B,d1
		move.w	#8,d2
		move.w	#$10,d3
		move.w	obX(a0),d4
		lea	(v_player).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObject_Always_SingleCharacter
		btst	#3,obStatus(a0)
		beq.s	loc_E32A
		bsr.s	sub_E34E

loc_E32A:
		movem.l	(sp)+,d1-d4
		lea	(v_player2).w,a1
		moveq	#4,d6
		bsr.w	SolidObject_Always_SingleCharacter
		btst	#4,obStatus(a0)
		beq.s	loc_E342
		bsr.s	sub_E34E

loc_E342:
		lea	(Ani_obj41).l,a1
		bra.w	AnimateSprite
; ===========================================================================
		rts

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


sub_E34E:
		move.w	#$100,obAnim(a0)
		addq.w	#8,obY(a1)
		move.w	objoff_30(a0),obVelY(a1)
		bset	#1,obStatus(a1)
		bclr	#3,obStatus(a1)
		move.b	#$10,obAnim(a1)
		move.b	#2,obRoutine(a1)
		move.b	obSubtype(a0),d0
		bpl.s	loc_E382
		move.w	#0,obVelX(a1)

loc_E382:
		btst	#0,d0
		beq.s	loc_E3C2
		move.w	#1,obInertia(a1)
		move.b	#1,objoff_27(a1)
		move.b	#0,obAnim(a1)
		move.b	#0,objoff_2C(a1)
		move.b	#4,objoff_2D(a1)
		btst	#1,d0
		bne.s	loc_E3B2
		move.b	#1,objoff_2C(a1)

loc_E3B2:
		btst	#0,obStatus(a1)
		beq.s	loc_E3C2
		neg.b	objoff_27(a1)
		neg.w	obInertia(a1)

loc_E3C2:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_E3D8
		move.b	#$C,obTopSolidBit(a1)
		move.b	#$D,obLRBSolidBit(a1)

loc_E3D8:
		cmpi.b	#8,d0
		bne.s	loc_E3EA
		move.b	#$E,obTopSolidBit(a1)
		move.b	#$F,obLRBSolidBit(a1)

loc_E3EA:
		move.w	#sfx_Spring,d0
		jmp	(PlaySound_Special).l
; End of function sub_E34E

; ===========================================================================
; loc_E3F4:
Obj41_Horizontal:
		move.w	#$13,d1
		move.w	#$E,d2
		move.w	#$F,d3
		move.w	obX(a0),d4
		lea	(v_player).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObject_Always_SingleCharacter
		btst	#5,obStatus(a0)
		beq.s	loc_E434
		move.b	obStatus(a0),d1
		move.w	obX(a0),d0
		sub.w	obX(a1),d0
		bcs.s	loc_E42C
		eori.b	#1,d1

loc_E42C:
		andi.b	#1,d1
		bne.s	loc_E434
		bsr.s	sub_E474

loc_E434:
		movem.l	(sp)+,d1-d4
		lea	(v_player2).w,a1
		moveq	#4,d6
		bsr.w	SolidObject_Always_SingleCharacter
		btst	#6,obStatus(a0)
		beq.s	loc_E464
		move.b	obStatus(a0),d1
		move.w	obX(a0),d0
		sub.w	obX(a1),d0
		bcs.s	loc_E45C
		eori.b	#1,d1

loc_E45C:
		andi.b	#1,d1
		bne.s	loc_E464
		bsr.s	sub_E474

loc_E464:
		bsr.w	sub_E54C
		lea	(Ani_obj41).l,a1
		bra.w	AnimateSprite
; ===========================================================================
		rts

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


sub_E474:
		move.w	#$300,obAnim(a0)
		move.w	objoff_30(a0),obVelX(a1)
		addq.w	#8,obX(a1)
		bset	#0,obStatus(a1)
		btst	#0,obStatus(a0)
		bne.s	loc_E4A2
		bclr	#0,obStatus(a1)
		subi.w	#$10,obX(a1)
		neg.w	obVelX(a1)

loc_E4A2:
		move.w	#$F,objoff_2E(a1)
		move.w	obVelX(a1),obInertia(a1)
		btst	#2,obStatus(a1)
		bne.s	loc_E4BC
		move.b	#0,obAnim(a1)

loc_E4BC:
		move.b	obSubtype(a0),d0
		bpl.s	loc_E4C8
		move.w	#0,obVelY(a1)

loc_E4C8:
		btst	#0,d0
		beq.s	loc_E508
		move.w	#1,obInertia(a1)
		move.b	#1,objoff_27(a1)
		move.b	#0,obAnim(a1)
		move.b	#1,objoff_2C(a1)
		move.b	#8,objoff_2D(a1)
		btst	#1,d0
		bne.s	loc_E4F8
		move.b	#3,objoff_2C(a1)

loc_E4F8:
		btst	#0,obStatus(a1)
		beq.s	loc_E508
		neg.b	objoff_27(a1)
		neg.w	obInertia(a1)

loc_E508:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_E51E
		move.b	#$C,obTopSolidBit(a1)
		move.b	#$D,obLRBSolidBit(a1)

loc_E51E:
		cmpi.b	#8,d0
		bne.s	loc_E530
		move.b	#$E,obTopSolidBit(a1)
		move.b	#$F,obLRBSolidBit(a1)

loc_E530:
		bclr	#5,obStatus(a0)
		bclr	#6,obStatus(a0)
		bclr	#5,obStatus(a1)
		move.w	#sfx_Spring,d0
		jmp	(PlaySound_Special).l
; End of function sub_E474


; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


sub_E54C:
		cmpi.b	#3,obAnim(a0)
		beq.w	locret_E604
		move.w	obX(a0),d0
		move.w	d0,d1
		addi.w	#$28,d1
		btst	#0,obStatus(a0)
		beq.s	loc_E56E
		move.w	d0,d1
		subi.w	#$28,d0

loc_E56E:
		move.w	obY(a0),d2
		move.w	d2,d3
		subi.w	#$18,d2
		addi.w	#$18,d3
		lea	(v_player).w,a1
		btst	#1,obStatus(a1)
		bne.s	loc_E5C2
		move.w	obInertia(a1),d4
		btst	#0,obStatus(a0)
		beq.s	loc_E596
		neg.w	d4

loc_E596:
		tst.w	d4
		bmi.s	loc_E5C2
		move.w	obX(a1),d4
		cmp.w	d0,d4
		bcs.w	loc_E5C2
		cmp.w	d1,d4
		bcc.w	loc_E5C2
		move.w	obY(a1),d4
		cmp.w	d2,d4
		bcs.w	loc_E5C2
		cmp.w	d3,d4
		bcc.w	loc_E5C2
		move.w	d0,-(sp)
		bsr.w	sub_E474
		move.w	(sp)+,d0

loc_E5C2:
		lea	(v_player2).w,a1
		btst	#1,obStatus(a1)
		bne.s	locret_E604
		move.w	obInertia(a1),d4
		btst	#0,obStatus(a0)
		beq.s	loc_E5DC
		neg.w	d4

loc_E5DC:
		tst.w	d4
		bmi.s	locret_E604
		move.w	obX(a1),d4
		cmp.w	d0,d4
		bcs.w	locret_E604
		cmp.w	d1,d4
		bcc.w	locret_E604
		move.w	obY(a1),d4
		cmp.w	d2,d4
		bcs.w	locret_E604
		cmp.w	d3,d4
		bcc.w	locret_E604
		bsr.w	sub_E474

locret_E604:
		rts
; End of function sub_E54C

; ===========================================================================
; loc_E606:
Obj41_Down:
		move.w	#$1B,d1
		move.w	#8,d2
		move.w	#$10,d3
		move.w	obX(a0),d4
		lea	(v_player).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObject_Always_SingleCharacter
		cmpi.w	#-2,d4
		bne.s	loc_E62C
		bsr.s	sub_E64E

loc_E62C:
		movem.l	(sp)+,d1-d4
		lea	(v_player2).w,a1
		moveq	#4,d6
		bsr.w	SolidObject_Always_SingleCharacter
		cmpi.w	#-2,d4
		bne.s	loc_E642
		bsr.s	sub_E64E

loc_E642:
		lea	(Ani_obj41).l,a1
		bra.w	AnimateSprite
; ===========================================================================
		rts

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


sub_E64E:
		move.w	#$100,obAnim(a0)
		subq.w	#8,obY(a1)
		move.w	objoff_30(a0),obVelY(a1)
		neg.w	obVelY(a1)
		move.b	obSubtype(a0),d0
		bpl.s	loc_E66E
		move.w	#0,obVelX(a1)

loc_E66E:
		btst	#0,d0
		beq.s	loc_E6AE
		move.w	#1,obInertia(a1)
		move.b	#1,objoff_27(a1)
		move.b	#0,obAnim(a1)
		move.b	#0,objoff_2C(a1)
		move.b	#4,objoff_2D(a1)
		btst	#1,d0
		bne.s	loc_E69E
		move.b	#1,objoff_2C(a1)

loc_E69E:
		btst	#0,obStatus(a1)
		beq.s	loc_E6AE
		neg.b	objoff_27(a1)
		neg.w	obInertia(a1)

loc_E6AE:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_E6C4
		move.b	#$C,obTopSolidBit(a1)
		move.b	#$D,obLRBSolidBit(a1)

loc_E6C4:
		cmpi.b	#8,d0
		bne.s	loc_E6D6
		move.b	#$E,obTopSolidBit(a1)
		move.b	#$F,obLRBSolidBit(a1)

loc_E6D6:
		bset	#1,obStatus(a1)
		bclr	#3,obStatus(a1)
		move.b	#2,obRoutine(a1)
		move.w	#sfx_Spring,d0
		jmp	(PlaySound_Special).l
; End of function sub_E64E

; ===========================================================================
; loc_E6F2:
Obj41_DiagonallyUp:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	obX(a0),d4
		lea	Obj41_SlopeData_DiagUp(pc),a2
		lea	(v_player).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SlopedSolid_SingleCharacter
		btst	#3,obStatus(a0)
		beq.s	loc_E71A
		bsr.s	sub_E73E

loc_E71A:
		movem.l	(sp)+,d1-d4
		lea	(v_player2).w,a1
		moveq	#4,d6
		bsr.w	SlopedSolid_SingleCharacter
		btst	#4,obStatus(a0)
		beq.s	loc_E732
		bsr.s	sub_E73E

loc_E732:
		lea	(Ani_obj41).l,a1
		bra.w	AnimateSprite
; ===========================================================================
		rts

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


sub_E73E:
		btst	#0,obStatus(a0)
		bne.s	loc_E754
		move.w	obX(a0),d0
		subq.w	#4,d0
		cmp.w	obX(a1),d0
		bcs.s	loc_E762
		rts
; ===========================================================================

loc_E754:
		move.w	obX(a0),d0
		addq.w	#4,d0
		cmp.w	obX(a1),d0
		bcc.s	loc_E762
		rts
; ===========================================================================

loc_E762:
		move.w	#$500,obAnim(a0)
		move.w	objoff_30(a0),obVelY(a1)
		move.w	objoff_30(a0),obVelX(a1)
		addq.w	#6,obY(a1)
		addq.w	#6,obX(a1)
		bset	#0,obStatus(a1)
		btst	#0,obStatus(a0)
		bne.s	loc_E79A
		bclr	#0,obStatus(a1)
		subi.w	#$C,obX(a1)
		neg.w	obVelX(a1)

loc_E79A:
		bset	#1,obStatus(a1)
		bclr	#3,obStatus(a1)
		move.b	#$10,obAnim(a1)
		move.b	#2,obRoutine(a1)
		move.b	obSubtype(a0),d0
		btst	#0,d0
		beq.s	loc_E7F6
		move.w	#1,obInertia(a1)
		move.b	#1,objoff_27(a1)
		move.b	#0,obAnim(a1)
		move.b	#1,objoff_2C(a1)
		move.b	#8,objoff_2D(a1)
		btst	#1,d0
		bne.s	loc_E7E6
		move.b	#3,objoff_2C(a1)

loc_E7E6:
		btst	#0,obStatus(a1)
		beq.s	loc_E7F6
		neg.b	objoff_27(a1)
		neg.w	obInertia(a1)

loc_E7F6:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_E80C
		move.b	#$C,obTopSolidBit(a1)
		move.b	#$D,obLRBSolidBit(a1)

loc_E80C:
		cmpi.b	#8,d0
		bne.s	loc_E81E
		move.b	#$E,obTopSolidBit(a1)
		move.b	#$F,obLRBSolidBit(a1)

loc_E81E:
		move.w	#sfx_Spring,d0
		jmp	(PlaySound_Special).l
; End of function sub_E73E

; ===========================================================================
; loc_E828:
Obj41_DiagonallyDown:
		move.w	#$1B,d1
		move.w	#$10,d2
		move.w	obX(a0),d4
		lea	Obj41_SlopeData_DiagDown(pc),a2
		lea	(v_player).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SlopedSolid_SingleCharacter
		cmpi.w	#-2,d4
		bne.s	loc_E84E
		bsr.s	sub_E870

loc_E84E:
		movem.l	(sp)+,d1-d4
		lea	(v_player2).w,a1
		moveq	#4,d6
		bsr.w	SlopedSolid_SingleCharacter
		cmpi.w	#-2,d4
		bne.s	loc_E864
		bsr.s	sub_E870

loc_E864:
		lea	(Ani_obj41).l,a1
		bra.w	AnimateSprite
; ===========================================================================
		rts

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


sub_E870:
		move.w	#$500,obAnim(a0)
		move.w	objoff_30(a0),obVelY(a1)
		neg.w	obVelY(a1)
		move.w	objoff_30(a0),obVelX(a1)
		subq.w	#6,obY(a1)
		addq.w	#6,obX(a1)
		bset	#0,obStatus(a1)
		btst	#0,obStatus(a0)
		bne.s	loc_E8AC
		bclr	#0,obStatus(a1)
		subi.w	#$C,obX(a1)
		neg.w	obVelX(a1)

loc_E8AC:
		bset	#1,obStatus(a1)
		bclr	#3,obStatus(a1)
		move.b	#2,obRoutine(a1)
		move.b	obSubtype(a0),d0
		btst	#0,d0
		beq.s	loc_E902
		move.w	#1,obInertia(a1)
		move.b	#1,objoff_27(a1)
		move.b	#0,obAnim(a1)
		move.b	#1,objoff_2C(a1)
		move.b	#8,objoff_2D(a1)
		btst	#1,d0
		bne.s	loc_E8F2
		move.b	#3,objoff_2C(a1)

loc_E8F2:
		btst	#0,obStatus(a1)
		beq.s	loc_E902
		neg.b	objoff_27(a1)
		neg.w	obInertia(a1)

loc_E902:
		andi.b	#$C,d0
		cmpi.b	#4,d0
		bne.s	loc_E918
		move.b	#$C,obTopSolidBit(a1)
		move.b	#$D,obLRBSolidBit(a1)

loc_E918:
		cmpi.b	#8,d0
		bne.s	loc_E92A
		move.b	#$E,obTopSolidBit(a1)
		move.b	#$F,obLRBSolidBit(a1)

loc_E92A:
		move.w	#sfx_Spring,d0
		jmp	(PlaySound_Special).l
; End of function sub_E870