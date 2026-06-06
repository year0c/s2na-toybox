; ---------------------------------------------------------------------------
; Object 48 - ball on a	chain that Eggman swings (GHZ)
; ---------------------------------------------------------------------------

Obj48_PB:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	GBall_PB_Index(pc,d0.w),d1
		jmp	GBall_PB_Index(pc,d1.w)
; ===========================================================================
GBall_PB_Index:	dc.w GBall_PB_Main-GBall_PB_Index
		dc.w GBall_PB_Base-GBall_PB_Index
		dc.w GBall_PB_Display2-GBall_PB_Index
		dc.w GBall_PB_Display2.loc_19274-GBall_PB_Index
		dc.w GBall_PB_ChkVanish-GBall_PB_Index
; ===========================================================================

GBall_PB_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.w	#$4080,obAngle(a0)
		move.w	#-$200,objoff_3E(a0)
		move.l	#Map_BossItems_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_Eggman_Weapons,0,0),obGfx(a0)
		bsr.w	$17CC4+$7E2	;	JmpTo6_Adjust2PArtPointer
		lea	obSubtype(a0),a2
		move.b	#0,(a2)+
		moveq	#5,d1
		movea.l	a0,a1
		bra.s	GBall_PB_MakeLinks.loc_1916A
; ===========================================================================

GBall_PB_MakeLinks:
		jsr	(FindNextFreeObj_PB).l
		bne.s	GBall_PB_MakeBall
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		_move.b	#id_Obj48,obID(a1) ; load chain link object
		move.b	#6,obRoutine(a1)
		move.l	#Map_Obj15_PB,obMap(a1)
		move.w	#make_art_tile(ArtTile_GHZ_MZ_Swing,0,0),obGfx(a1)
		bsr.w	$17CC4+$7DC	;	JmpTo3_Adjust2PArtPointer2
		move.b	#1,obFrame(a1)
		addq.b	#1,obSubtype(a0)

.loc_1916A:
		move.w	a1,d5
		subi.w	#v_objspace,d5
		lsr.w	#object_size_bits,d5
		andi.w	#$7F,d5
		move.b	d5,(a2)+
		move.b	#4,obRender(a1)
		move.b	#8,obActWid(a1)
		move.b	#6,obPriority(a1)
		move.l	objoff_34(a0),objoff_34(a1)
		dbf	d1,GBall_PB_MakeLinks ; repeat sequence 5 more times

GBall_PB_MakeBall:
		move.b	#8,obRoutine(a1)
		move.l	#Map_Obj48_PB,obMap(a1)	; load different mappings for final link
		move.w	#make_art_tile(ArtTile_GHZ_Giant_Ball,2,0),obGfx(a1) ; use different graphics
		bsr.w	$17CC4+$7DC	;	JmpTo3_Adjust2PArtPointer2
		move.b	#1,obFrame(a1)
		move.b	#5,obPriority(a1)
		move.b	#$81,obColType(a1) ; make object hurt Sonic
		rts
; ===========================================================================

GBall_PB_PosData:	dc.b 0,	$10, $20, $30, $40, $60	; y-position data for links and	giant ball
		even
; ===========================================================================

GBall_PB_Base:	; Routine 2
		lea	GBall_PB_PosData(pc),a3
		lea	obSubtype(a0),a2
		moveq	#0,d6
		move.b	(a2)+,d6

.loc_191D2:
		moveq	#0,d4
		move.b	(a2)+,d4
		lsl.w	#object_size_bits,d4
		addi.l	#v_objspace,d4
		movea.l	d4,a1
		move.b	(a3)+,d0
		cmp.b	objoff_3C(a1),d0
		beq.s	.loc_191EC
		addq.b	#1,objoff_3C(a1)

.loc_191EC:
		dbf	d6,.loc_191D2

		cmp.b	objoff_3C(a1),d0
		bne.s	.loc_19206
		movea.l	objoff_34(a0),a1
		cmpi.b	#6,ob2ndRout(a1)
		bne.s	.loc_19206
		addq.b	#2,obRoutine(a0)

.loc_19206:
		cmpi.w	#$20,objoff_32(a0)
		beq.s	GBall_PB_Display
		addq.w	#1,objoff_32(a0)

GBall_PB_Display:
		bsr.w	GBall_PB_Display2.sub_19236
		move.b	obAngle(a0),d0
		jsr	(Swing_Move2_PB).l
		jmp	(DisplaySprite_PB).l
; ===========================================================================

GBall_PB_Display2:	; Routine 4
		bsr.w	.sub_19236
		jsr	(Obj48_Move_PB).l
		jmp	(DisplaySprite_PB).l

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


.sub_19236:
		movea.l	objoff_34(a0),a1
		addi.b	#$20,obAniFrame(a0)
		bhs.s	.loc_19248
		bchg	#0,obFrame(a0)

.loc_19248:
		move.w	obX(a1),objoff_3A(a0)
		move.w	obY(a1),d0
		add.w	objoff_32(a0),d0
		move.w	d0,objoff_38(a0)
		move.b	obStatus(a1),obStatus(a0)
		tst.b	obStatus(a1)
		bpl.s	.locret_19272
		_move.b	#id_Obj3F,obID(a0)
		move.b	#0,obRoutine(a0)

.locret_19272:
		rts	
; End of function sub_17C2A

; ===========================================================================

.loc_19274:	; Routine 6
		movea.l	objoff_34(a0),a1
		tst.b	obStatus(a1)
		bpl.s	GBall_PB_Display3
		_move.b	#id_Obj3F,obID(a0)
		move.b	#0,obRoutine(a0)

GBall_PB_Display3:
		jmp	(DisplaySprite_PB).l
; ===========================================================================

GBall_PB_ChkVanish:; Routine 8
		moveq	#0,d0
		tst.b	obFrame(a0)
		bne.s	GBall_PB_Vanish
		addq.b	#1,d0

GBall_PB_Vanish:
		move.b	d0,obFrame(a0)
		movea.l	objoff_34(a0),a1
		tst.b	obStatus(a1)
		bpl.s	GBall_PB_Display4
		move.b	#0,obColType(a0)
		bsr.w	BossDefeated_PB
		subq.b	#1,objoff_3C(a0)
		bpl.s	GBall_PB_Display4
		move.b	#id_Obj3F,obID(a0)
		move.b	#0,obRoutine(a0)

GBall_PB_Display4:
		jmp	(DisplaySprite_PB).l
