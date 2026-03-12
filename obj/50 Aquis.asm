; ---------------------------------------------------------------------------
; Object 50 - Aquis badnik from HPZ
; ---------------------------------------------------------------------------

Obj50:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj50_Index(pc,d0.w),d1
		jmp	Obj50_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj50_Index:	dc.w Obj50_Init-Obj50_Index
		dc.w loc_15FDA-Obj50_Index
		dc.w loc_16006-Obj50_Index
		dc.w loc_16030-Obj50_Index
		dc.w Obj50_Routine08-Obj50_Index
		dc.w Obj50_Routine0A-Obj50_Index
; ---------------------------------------------------------------------------

Obj50_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj50,obMap(a0)
		move.w	#make_art_tile(ArtTile_Aquis,1,0),obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#$10,obActWid(a0)
		move.w	#-$100,obVelX(a0)
		move.b	obSubtype(a0),d0
		move.b	d0,d1
		andi.w	#$F0,d1
		lsl.w	#4,d1
		move.w	d1,objoff_2E(a0)
		move.w	d1,objoff_30(a0)
		andi.w	#$F,d0
		lsl.w	#4,d0
		subq.w	#1,d0
		move.w	d0,objoff_32(a0)
		move.w	d0,objoff_34(a0)
		move.w	obY(a0),objoff_2A(a0)
		bsr.w	j_FindFreeObj
		bne.s	loc_15FDA
		_move.b	#id_Obj50,obID(a1)
		move.b	#4,obRoutine(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		addi.w	#$A,obX(a1)
		addi.w	#-6,obY(a1)
		move.l	#Map_Obj50,obMap(a1)
		move.w	#make_art_tile(ArtTile_Aquis_Child,1,0),obGfx(a1)
		ori.b	#4,obRender(a1)
		move.b	#3,obPriority(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	#3,obAnim(a1)
		move.l	a1,objoff_36(a0)
		move.l	a0,objoff_36(a1)
		bset	#6,obStatus(a0)

loc_15FDA:
		lea	(Ani_Obj50).l,a1
		bsr.w	j_AnimateSprite_3
		move.w	#$39C,(v_waterpos1).w
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj50_SubIndex(pc,d0.w),d1
		jsr	Obj50_SubIndex(pc,d1.w)
		bsr.w	sub_161D8
		bra.w	loc_1677A
; ---------------------------------------------------------------------------
Obj50_SubIndex:	dc.w loc_16046-Obj50_SubIndex
		dc.w loc_16058-Obj50_SubIndex
		dc.w loc_16066-Obj50_SubIndex
; ---------------------------------------------------------------------------

loc_16006:
		movea.l	objoff_36(a0),a1
		; This check is made redundant by the one after it.
		tst.b	obID(a1)
		beq.w	loc_1676E
		cmpi.b	#id_Obj50,obID(a1)
		bne.w	loc_1676E
		btst	#7,obStatus(a1)
		bne.w	loc_1676E
		lea	(Ani_Obj50).l,a1
		bsr.w	j_AnimateSprite_3
		bra.w	loc_16768
; ---------------------------------------------------------------------------

loc_16030:
		bsr.w	loc_162FC
		bsr.w	j_ObjectMove_4
		lea	(Ani_Obj50).l,a1
		bsr.w	j_AnimateSprite_3
		bra.w	loc_1677A
; ---------------------------------------------------------------------------

loc_16046:
		bsr.w	j_ObjectMove_4
		bsr.w	sub_162DE
		bsr.w	sub_16184
		bsr.w	sub_1611C
		rts
; ---------------------------------------------------------------------------

loc_16058:
		bsr.w	j_ObjectMove_4
		bsr.w	sub_162DE
		bsr.w	sub_161A6
		rts
; ---------------------------------------------------------------------------

loc_16066:
		bsr.w	j_ObjectMoveAndFall_2
		bsr.w	sub_162DE
		bsr.w	sub_16078
		bsr.w	sub_160F4
		rts

; =============== S U B	R O U T	I N E =======================================


sub_16078:
		tst.b	objoff_2D(a0)
		bne.s	locret_16084
		tst.w	obVelY(a0)
		bpl.s	loc_16086

locret_16084:
		rts
; ---------------------------------------------------------------------------

loc_16086:
		st	objoff_2D(a0)
		bsr.w	j_FindFreeObj
		bne.s	locret_160F2
		_move.b	#id_Obj50,obID(a1)
		move.b	#6,obRoutine(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.l	#Map_Obj50,obMap(a1)
		move.w	#make_art_tile(ArtTile_Aquis_Child,1,0),obGfx(a1)
		ori.b	#4,obRender(a1)
		move.b	#3,obPriority(a1)
		move.b	#$E5,obColType(a1)
		move.b	#2,obAnim(a1)
		move.w	#$C,d0
		move.w	#$10,d1
		move.w	#-$300,d2
		btst	#0,obStatus(a0)
		beq.s	loc_160E6
		neg.w	d1
		neg.w	d2

loc_160E6:
		sub.w	d0,obY(a1)
		sub.w	d1,obX(a1)
		move.w	d2,obVelX(a1)

locret_160F2:
		rts
; End of function sub_16078


; =============== S U B	R O U T	I N E =======================================


sub_160F4:
		move.w	obY(a0),d0
		cmp.w	(v_waterpos1).w,d0
		blt.s	locret_1611A
		move.b	#2,ob2ndRout(a0)
		move.b	#0,obAnim(a0)
		move.w	objoff_30(a0),objoff_2E(a0)
		move.w	#$40,obVelY(a0)
		sf	objoff_2D(a0)

locret_1611A:
		rts
; End of function sub_160F4


; =============== S U B	R O U T	I N E =======================================


sub_1611C:
		tst.b	objoff_2C(a0)
		beq.s	locret_16182
		move.w	(v_player+obX).w,d0
		move.w	(v_player+obY).w,d1
		sub.w	obY(a0),d1
		bpl.s	locret_16182
		cmpi.w	#-$30,d1
		blt.s	locret_16182
		sub.w	obX(a0),d0
		cmpi.w	#$48,d0
		bgt.s	locret_16182
		cmpi.w	#-$48,d0
		blt.s	locret_16182
		tst.w	d0
		bpl.s	loc_1615A
		cmpi.w	#-$28,d0
		bgt.s	locret_16182
		btst	#0,obStatus(a0)
		bne.s	locret_16182
		bra.s	loc_16168
; ---------------------------------------------------------------------------

loc_1615A:
		cmpi.w	#$28,d0
		blt.s	locret_16182
		btst	#0,obStatus(a0)
		beq.s	locret_16182

loc_16168:
		moveq	#$20,d0
		cmp.w	objoff_32(a0),d0
		bgt.s	locret_16182
		move.b	#4,ob2ndRout(a0)
		move.b	#1,obAnim(a0)
		move.w	#-$400,obVelY(a0)

locret_16182:
		rts
; End of function sub_1611C


; =============== S U B	R O U T	I N E =======================================


sub_16184:
		subq.w	#1,objoff_2E(a0)
		bne.s	locret_161A4
		move.w	objoff_30(a0),objoff_2E(a0)
		addq.b	#2,ob2ndRout(a0)
		move.w	#-$40,d0
		tst.b	objoff_2C(a0)
		beq.s	loc_161A0
		neg.w	d0

loc_161A0:
		move.w	d0,obVelY(a0)

locret_161A4:
		rts
; End of function sub_16184


; =============== S U B	R O U T	I N E =======================================


sub_161A6:
		move.w	obY(a0),d0
		tst.b	objoff_2C(a0)
		bne.s	loc_161C4
		cmp.w	(v_waterpos1).w,d0
		bgt.s	locret_161C2
		subq.b	#2,ob2ndRout(a0)
		st	objoff_2C(a0)
		clr.w	obVelY(a0)

locret_161C2:
		rts
; ---------------------------------------------------------------------------

loc_161C4:
		cmp.w	objoff_2A(a0),d0
		blt.s	locret_161C2
		subq.b	#2,ob2ndRout(a0)
		sf	objoff_2C(a0)
		clr.w	obVelY(a0)
		rts
; End of function sub_161A6


; =============== S U B	R O U T	I N E =======================================


sub_161D8:
		moveq	#$A,d0
		moveq	#-6,d1
		movea.l	objoff_36(a0),a1
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	obRespawnNo(a0),obRespawnNo(a1)
		move.b	obRender(a0),obRender(a1)
		btst	#0,obStatus(a1)
		beq.s	loc_16208
		neg.w	d0

loc_16208:
		add.w	d0,obX(a1)
		add.w	d1,obY(a1)
		rts
; End of function sub_161D8

; ---------------------------------------------------------------------------

Obj50_Routine08:
		bsr.w	j_ObjectMoveAndFall_2
		bsr.w	sub_16228
		lea	(Ani_Obj50).l,a1
		bsr.w	j_AnimateSprite_3
		bra.w	loc_1677A

; =============== S U B	R O U T	I N E =======================================


sub_16228:
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	loc_16242
		add.w	d1,obY(a0)
		move.w	obVelY(a0),d0
		asr.w	#1,d0
		neg.w	d0
		move.w	d0,obVelY(a0)

loc_16242:
		subi.b	#1,obColProp(a0)
		beq.w	loc_1676E
		rts
; End of function sub_16228

; ---------------------------------------------------------------------------

Obj50_Routine0A:
		bsr.w	sub_1629E
		tst.b	ob2ndRout(a0)
		beq.s	locret_1628E
		subi.w	#1,objoff_2C(a0)
		beq.w	loc_1676E
		move.w	(v_player+obX).w,obX(a0)
		move.w	(v_player+obY).w,obY(a0)
		addi.w	#$C,obY(a0)
		subi.b	#1,objoff_2A(a0)
		bne.s	loc_16290
		move.b	#3,objoff_2A(a0)
		bchg	#0,obStatus(a0)
		bchg	#0,obRender(a0)

locret_1628E:
		rts
; ---------------------------------------------------------------------------

loc_16290:
		lea	(Ani_Obj50).l,a1
		bsr.w	j_AnimateSprite_3
		bra.w	loc_16768

; =============== S U B	R O U T	I N E =======================================


sub_1629E:
		tst.b	ob2ndRout(a0)
		bne.s	locret_162DC
		move.b	(v_player+obRoutine).w,d0
		cmpi.b	#2,d0
		bne.s	locret_162DC
		move.w	(v_player+obX).w,obX(a0)
		move.w	(v_player+obY).w,obY(a0)
		ori.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#5,obAnim(a0)
		st	ob2ndRout(a0)
		move.w	#$12C,objoff_2C(a0)
		move.b	#3,objoff_2A(a0)

locret_162DC:
		rts
; End of function sub_1629E


; =============== S U B	R O U T	I N E =======================================


sub_162DE:
		subq.w	#1,objoff_32(a0)
		bpl.s	locret_162FA
		move.w	objoff_34(a0),objoff_32(a0)
		neg.w	obVelX(a0)
		bchg	#0,obStatus(a0)
		move.b	#1,obPrevAni(a0)

locret_162FA:
		rts
; End of function sub_162DE

; ---------------------------------------------------------------------------

loc_162FC:
		tst.b	obColProp(a0)
		beq.w	locret_1639E
		moveq	#2,d3

loc_16306:
		bsr.w	j_FindFreeObj
		bne.s	loc_16378
		_move.b	obID(a0),obID(a1)
		move.b	#8,obRoutine(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.l	obMap(a0),obMap(a1)
		move.w	#make_art_tile(ArtTile_Aquis_Child,1,0),obGfx(a1)
		ori.b	#4,obRender(a1)
		move.b	#3,obPriority(a1)
		move.w	#-$100,obVelY(a1)
		move.b	#4,obAnim(a1)
		move.b	#$78,obColProp(a1)
		cmpi.w	#1,d3
		beq.s	loc_16372
		blt.s	loc_16364
		move.w	#$C0,obVelX(a1)
		addi.w	#-$C0,obVelY(a1)
		bra.s	loc_16378
; ---------------------------------------------------------------------------

loc_16364:
		move.w	#-$100,obVelX(a1)
		addi.w	#-$40,obVelY(a1)
		bra.s	loc_16378
; ---------------------------------------------------------------------------

loc_16372:
		move.w	#$40,obVelX(a1)

loc_16378:
		dbf	d3,loc_16306
		bsr.w	j_FindFreeObj
		bne.s	loc_1639A
		_move.b	obID(a0),obID(a1)
		move.b	#$A,obRoutine(a1)
		move.l	obMap(a0),obMap(a1)
		move.w	#make_art_tile(ArtTile_Aquis_Child,1,0),obGfx(a1)

loc_1639A:
		bra.w	loc_1676E
; ---------------------------------------------------------------------------

locret_1639E:
		rts