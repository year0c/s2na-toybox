; ---------------------------------------------------------------------------
; Object 4A - Octus badnik
; ---------------------------------------------------------------------------

Obj4A_PB:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj4A_PB_Index(pc,d0.w),d1
		jmp	Obj4A_PB_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj4A_PB_Index:	dc.w .loc_16ADE-Obj4A_PB_Index
		dc.w .loc_16B44-Obj4A_PB_Index
		dc.w .loc_16AD2-Obj4A_PB_Index
		dc.w .loc_16AB6-Obj4A_PB_Index
; ---------------------------------------------------------------------------

.loc_16AB6:
		subi.w	#1,objoff_2C(a0)
		bmi.s	.loc_16AC0
		rts
; ---------------------------------------------------------------------------

.loc_16AC0:
		bsr.w	$15AC8+$2A8	;	JmpTo5_ObjectMoveAndFall
		lea	(Ani_Obj4A_PB).l,a1
		bsr.w	$15AC8+$2A2	;	JmpTo6_AnimateSprite
		bra.w	$15AC8+$29C	;	JmpTo4_MarkObjGone
; ---------------------------------------------------------------------------

.loc_16AD2:
		subq.w	#1,objoff_2C(a0)
		beq.w	$15AC8+$296	;	JmpTo7_DeleteObject
		bra.w	$15AC8+$290	;	JmpTo6_DisplaySprite
; ---------------------------------------------------------------------------

.loc_16ADE:
		move.l	#Map_Obj4A_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_Octus,1,0),obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#16,obActWid(a0)
		move.b	#16,obHeight(a0)
		move.b	#8,obWidth(a0)
		bsr.w	$15AC8+$2A8	;	JmpTo5_ObjectMoveAndFall
		jsr	(ObjHitFloor_PB).l
		tst.w	d1
		bpl.s	.loc_16B3C
		add.w	d1,obY(a0)
		move.w	#0,obVelY(a0)
		addq.b	#2,obRoutine(a0)
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		bpl.s	.loc_16B3C
		bchg	#0,obStatus(a0)

.loc_16B3C:
		move.w	obY(a0),objoff_2A(a0)
		rts
; ---------------------------------------------------------------------------

.loc_16B44:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj4A_PB_SubIndex(pc,d0.w),d1
		jsr	Obj4A_PB_SubIndex(pc,d1.w)
		lea	(Ani_Obj4A_PB).l,a1
		bsr.w	$15AC8+$2A2	;	JmpTo6_AnimateSprite
		bra.w	$15AC8+$29C	;	JmpTo4_MarkObjGone
; ---------------------------------------------------------------------------
Obj4A_PB_SubIndex:	dc.w Obj4A_PB_Init-Obj4A_PB_SubIndex
		dc.w Obj4A_PB_Main-Obj4A_PB_SubIndex
		dc.w Obj4A_PB_Main.loc_16BAA-Obj4A_PB_SubIndex
		dc.w Obj4A_PB_Main.loc_16C7C-Obj4A_PB_SubIndex
; ---------------------------------------------------------------------------

Obj4A_PB_Init:
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		cmpi.w	#$80,d0
		bgt.s	.locret_16B86
		cmpi.w	#-$80,d0
		blt.s	.locret_16B86
		addq.b	#2,ob2ndRout(a0)
		move.b	#1,obAnim(a0)

.locret_16B86:
		rts
; ---------------------------------------------------------------------------

Obj4A_PB_Main:
		subi.l	#$18000,obY(a0)
		move.w	objoff_2A(a0),d0
		sub.w	obY(a0),d0
		cmpi.w	#$20,d0
		ble.s	.locret_16BA8
		addq.b	#2,ob2ndRout(a0)
		move.w	#0,objoff_2C(a0)

.locret_16BA8:
		rts
; ---------------------------------------------------------------------------

.loc_16BAA:
		subi.w	#1,objoff_2C(a0)
		beq.w	.loc_16C76
		bpl.w	.locret_16C74
		move.w	#30,objoff_2C(a0)
		jsr	(FindFreeObj_PB).l
		bne.s	.loc_16C10
		_move.b	#id_Obj4A,obID(a1)
		move.b	#4,obRoutine(a1)
		move.l	#Map_Obj4A_PB,obMap(a1)
		move.b	#4,obFrame(a1)
		move.w	#make_art_tile(ArtTile_Octus_Child,1,0),obGfx(a1)
		move.b	#3,obPriority(a1)
		move.b	#16,obActWid(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	#$1E,objoff_2C(a1)
		move.b	obRender(a0),obRender(a1)
		move.b	obStatus(a0),obStatus(a1)

.loc_16C10:
		jsr	(FindFreeObj_PB).l
		bne.s	.locret_16C74
		_move.b	#id_Obj4A,obID(a1)
		move.b	#6,obRoutine(a1)
		move.l	#Map_Obj4A_PB,obMap(a1)
		move.w	#make_art_tile(ArtTile_Octus_Child,1,0),obGfx(a1)
		move.b	#4,obPriority(a1)
		move.b	#16,obActWid(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	#$F,objoff_2C(a1)
		move.b	obRender(a0),obRender(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	#2,obAnim(a1)
		move.w	#-$580,obVelX(a1)
		btst	#0,obRender(a1)
		beq.s	.locret_16C74
		neg.w	obVelX(a1)

.locret_16C74:
		rts
; ---------------------------------------------------------------------------

.loc_16C76:
		addq.b	#2,ob2ndRout(a0)
		rts
; ---------------------------------------------------------------------------

.loc_16C7C:
		move.w	#-6,d0
		btst	#0,obRender(a0)
		beq.s	.loc_16C8A
		neg.w	d0

.loc_16C8A:
		add.w	d0,obX(a0)
		bra.w	$15AC8+$29C	;	JmpTo4_MarkObjGone