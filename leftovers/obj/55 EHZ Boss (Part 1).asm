; ---------------------------------------------------------------------------
; Object 55 - EHZ boss
; ---------------------------------------------------------------------------

Obj55_PB:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj55_PB_Index(pc,d0.w),d1
		jmp	Obj55_PB_Index(pc,d1.w)
; ===========================================================================
Obj55_PB_Index:	dc.w Obj55_PB_Init-Obj55_PB_Index
		dc.w Obj55_PB_Init.loc_18302-Obj55_PB_Index
		dc.w Obj55_PB_Init.loc_18340-Obj55_PB_Index
		dc.w Obj55_PB_Init.loc_18372-Obj55_PB_Index
		dc.w Obj55_PB_Init.loc_18410-Obj55_PB_Index
; ===========================================================================
; loc_181E4:
Obj55_PB_Init:
		move.l	#Map_Obj55_PB,obMap(a0)
		move.w	#make_art_tile($400,1,0),obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#32,obActWid(a0)
		move.b	#3,obPriority(a0)
		move.b	#$F,obColType(a0)
		move.b	#2,obColProp(a0)
		addq.b	#2,obRoutine(a0)
		move.w	obX(a0),objoff_30(a0)
		move.w	obY(a0),objoff_38(a0)
		move.b	obSubtype(a0),d0
		cmpi.b	#$81,d0
		bne.s	.loc_18230
		addi.w	#$60,obGfx(a0)

.loc_18230:
		jsr	(FindNextFreeObj_PB).l
		bne.w	.loc_182E8
		_move.b	#id_Obj55,obID(a1)
		move.l	a0,objoff_34(a1)
		move.l	a1,objoff_34(a0)
		move.l	#Map_Obj55_PB,obMap(a1)
		move.w	#make_art_tile($400,0,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#32,obActWid(a1)
		move.b	#3,obPriority(a1)
		move.l	obX(a0),obX(a1)
		move.l	obY(a0),obY(a1)
		addq.b	#4,obRoutine(a1)
		move.b	#1,obAnim(a1)
		move.b	obRender(a0),obRender(a1)
		move.b	obSubtype(a0),d0
		cmpi.b	#$81,d0
		bne.s	.loc_18294
		addi.w	#$60,obGfx(a1)

.loc_18294:
		tst.b	obSubtype(a0)
		bmi.s	.loc_182E8
		jsr	(FindNextFreeObj_PB).l
		bne.s	.loc_182E8
		_move.b	#id_Obj55,obID(a1)
		move.l	a0,objoff_34(a1)
		move.l	#Map_Obj55a_PB,obMap(a1)
		move.w	#make_art_tile(ArtTile_ArtNem_EHZBoss+$10,0,0),obGfx(a1)
		move.b	#1,obTimeFrame(a0)
		move.b	#4,obRender(a1)
		move.b	#32,obActWid(a1)
		move.b	#3,obPriority(a1)
		move.l	obX(a0),obX(a1)
		move.l	obY(a0),obY(a1)
		addq.b	#6,obRoutine(a1)
		move.b	obRender(a0),obRender(a1)

.loc_182E8:
		move.b	obSubtype(a0),d0
		andi.w	#$7F,d0
		add.w	d0,d0
		add.w	d0,d0
		movea.l	.dword_182FA(pc,d0.w),a1
		jmp	(a1)
; ===========================================================================
.dword_182FA:	dc.l 0
		dc.l Obj58_PB.loc_17F54
; ===========================================================================

.loc_18302:
		move.b	obSubtype(a0),d0
		andi.w	#$7F,d0
		add.w	d0,d0
		add.w	d0,d0
		movea.l	.dword_18338(pc,d0.w),a1
		jsr	(a1)
		lea	(Ani_Obj55a_PB).l,a1
		jsr	(AnimateSprite_PB).l
		move.b	obStatus(a0),d0
		andi.b	#3,d0
		andi.b	#$FC,obRender(a0)
		or.b	d0,obRender(a0)
		jmp	(DisplaySprite_PB).l
; ===========================================================================
.dword_18338:	dc.l 0
		dc.l Obj57_PB
; ===========================================================================

.loc_18340:
		movea.l	objoff_34(a0),a1
		move.l	obX(a1),obX(a0)
		move.l	obY(a1),obY(a0)
		move.b	obStatus(a1),obStatus(a0)
		move.b	obRender(a1),obRender(a0)
		movea.l	#Ani_Obj55a_PB,a1
		jsr	(AnimateSprite_PB).l
		jmp	(DisplaySprite_PB).l
; ===========================================================================
.byte_1836E:	dc.b   0,$FF,  1,  0
; ===========================================================================

.loc_18372:
		btst	#7,obStatus(a0)
		bne.s	.loc_183C6
		movea.l	objoff_34(a0),a1
		move.l	obX(a1),obX(a0)
		move.l	obY(a1),obY(a0)
		move.b	obStatus(a1),obStatus(a0)
		move.b	obRender(a1),obRender(a0)
		subq.b	#1,obTimeFrame(a0)
		bpl.s	.loc_183BA
		move.b	#1,obTimeFrame(a0)
		move.b	objoff_2A(a0),d0
		addq.b	#1,d0
		cmpi.b	#2,d0
		ble.s	.loc_183B0
		moveq	#0,d0

.loc_183B0:
		move.b	.byte_1836E(pc,d0.w),obFrame(a0)
		move.b	d0,objoff_2A(a0)

.loc_183BA:
		cmpi.b	#$FF,obFrame(a0)
		bne.w	$17194+$408	;	JmpTo8_DisplaySprite
		rts
; ===========================================================================

.loc_183C6:
		movea.l	objoff_34(a0),a1
		btst	#6,objoff_2E(a1)
		bne.s	.loc_183D4
		rts
; ===========================================================================

.loc_183D4:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj55b_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_ArtNem_EHZBoss+$18,0,0),obGfx(a0)
		move.b	#0,obFrame(a0)
		move.b	#5,obTimeFrame(a0)
		movea.l	objoff_34(a0),a1
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		addi.w	#4,obY(a0)
		subi.w	#$28,obX(a0)
		rts
; ===========================================================================

.loc_18410:
		subq.b	#1,obTimeFrame(a0)
		bpl.s	.loc_18452
		move.b	#5,obTimeFrame(a0)
		addq.b	#1,obFrame(a0)
		cmpi.b	#4,obFrame(a0)
		bne.w	.loc_18452
		move.b	#0,obFrame(a0)
		movea.l	objoff_34(a0),a1
		move.b	(a1),d0
		beq.w	$17194+$40E	;	JmpTo10_DeleteObject
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		addi.w	#4,obY(a0)
		subi.w	#$28,obX(a0)

.loc_18452:
		bra.w	$17194+$408	;	JmpTo8_DisplaySprite