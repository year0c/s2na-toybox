; ---------------------------------------------------------------------------
; Object 58 - sub object of the	EHZ boss
; ---------------------------------------------------------------------------

Obj58:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	off_17AFC(pc,d0.w),d1
		jmp	off_17AFC(pc,d1.w)
; ---------------------------------------------------------------------------
off_17AFC:	dc.w loc_17B2A-off_17AFC
		dc.w loc_17BB0-off_17AFC
		dc.w loc_17C02-off_17AFC
		dc.w loc_17CE4-off_17AFC
		dc.w loc_17B06-off_17AFC
; ---------------------------------------------------------------------------

loc_17B06:
		subi.w	#1,obY(a0)
		subi.w	#1,objoff_2A(a0)
		bpl.w	loc_181A8
		move.b	#0,obRoutine(a0)
		lea	(Ani_Obj58).l,a1
		bsr.w	j_AnimateSprite_9
		bra.w	loc_181A8
; ---------------------------------------------------------------------------

loc_17B2A:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	off_17B38(pc,d0.w),d1
		jmp	off_17B38(pc,d1.w)
; ---------------------------------------------------------------------------
off_17B38:	dc.w loc_17B3C-off_17B38
		dc.w loc_17B86-off_17B38
; ---------------------------------------------------------------------------

loc_17B3C:
		movea.l	objoff_34(a0),a1
		cmpi.b	#id_Obj55,obID(a1)
		bne.w	loc_181AE
		btst	#0,objoff_2D(a1)
		beq.s	loc_17B60
		move.b	#1,obAnim(a0)
		move.w	#$18,objoff_2A(a0)
		addq.b	#2,ob2ndRout(a0)

loc_17B60:
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		move.b	obStatus(a1),obStatus(a0)
		move.b	obRender(a1),obRender(a0)
		lea	(Ani_Obj58).l,a1
		bsr.w	j_AnimateSprite_9
		bra.w	loc_181A8
; ---------------------------------------------------------------------------

loc_17B86:
		subi.w	#1,objoff_2A(a0)
		bpl.s	loc_17BA2
		cmpi.w	#-$10,objoff_2A(a0)
		ble.w	loc_181AE
		addi.w	#1,obY(a0)
		bra.w	loc_181A8
; ---------------------------------------------------------------------------

loc_17BA2:
		lea	(Ani_Obj58).l,a1
		bsr.w	j_AnimateSprite_9
		bra.w	loc_181A8
; ---------------------------------------------------------------------------

loc_17BB0:
		movea.l	objoff_34(a0),a1
		cmpi.b	#id_Obj55,obID(a1)
		bne.w	loc_181AE
		btst	#1,objoff_2D(a1)
		beq.w	loc_181A8
		btst	#2,objoff_2D(a1)
		bne.w	loc_17BF2
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		addi.w	#8,obY(a0)
		move.b	obStatus(a1),obStatus(a0)
		move.b	obRender(a1),obRender(a0)
		bra.w	loc_181A8
; ---------------------------------------------------------------------------

loc_17BF2:
		move.b	#8,obFrame(a0)
		move.b	#0,obPriority(a0)
		bra.w	loc_181A8
; ---------------------------------------------------------------------------

loc_17C02:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	off_17C10(pc,d0.w),d1
		jmp	off_17C10(pc,d1.w)
; ---------------------------------------------------------------------------
off_17C10:	dc.w loc_17C18-off_17C10
		dc.w loc_17C36-off_17C10
		dc.w loc_17C96-off_17C10
		dc.w loc_17CC2-off_17C10
; ---------------------------------------------------------------------------

loc_17C18:
		movea.l	objoff_34(a0),a1
		cmpi.b	#id_Obj55,obID(a1)
		bne.w	loc_181AE
		btst	#1,objoff_2D(a1)
		beq.w	loc_181A8
		addq.b	#2,ob2ndRout(a0)
		bra.w	loc_181A8
; ---------------------------------------------------------------------------

loc_17C36:
		movea.l	objoff_34(a0),a1
		cmpi.b	#id_Obj55,obID(a1)
		bne.w	loc_181AE
		move.b	obStatus(a1),obStatus(a0)
		move.b	obRender(a1),obRender(a0)
		tst.b	obStatus(a0)
		bpl.s	loc_17C58
		addq.b	#2,ob2ndRout(a0)

loc_17C58:
		bsr.w	sub_17A6A
		bsr.w	j_ObjectMoveAndFall_6
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	loc_17C6E
		add.w	d1,obY(a0)

loc_17C6E:
		move.w	#$100,obVelY(a0)
		cmpi.b	#1,obPriority(a0)
		bne.s	loc_17C88
		move.w	obY(a0),d0
		movea.l	objoff_34(a0),a1
		add.w	d0,objoff_2E(a1)

loc_17C88:
		lea	(Ani_Obj58a).l,a1
		bsr.w	j_AnimateSprite_9
		bra.w	loc_181A8
; ---------------------------------------------------------------------------

loc_17C96:
		subi.w	#1,objoff_2A(a0)
		bpl.w	loc_181A8
		addq.b	#2,ob2ndRout(a0)
		move.w	#$A,objoff_2A(a0)
		move.w	#-$300,obVelY(a0)
		cmpi.b	#1,obPriority(a0)
		beq.w	loc_181A8
		neg.w	obVelX(a0)
		bra.w	loc_181A8
; ---------------------------------------------------------------------------

loc_17CC2:
		subq.w	#1,objoff_2A(a0)
		bpl.w	loc_181A8
		bsr.w	j_ObjectMoveAndFall_6
		bsr.w	ObjHitFloor
		tst.w	d1
		bpl.s	loc_17CE0
		move.w	#-$200,obVelY(a0)
		add.w	d1,obY(a0)

loc_17CE0:
		bra.w	loc_181B4
; ---------------------------------------------------------------------------

loc_17CE4:
		movea.l	objoff_34(a0),a1
		cmpi.b	#id_Obj55,obID(a1)
		bne.w	loc_181AE
		btst	#3,objoff_2D(a1)
		bne.s	loc_17D4A
		bsr.w	sub_17D6A
		btst	#1,objoff_2D(a1)
		beq.w	loc_181A8
		move.b	#$8B,obColType(a0)
		move.w	obX(a1),obX(a0)
		move.w	obY(a1),obY(a0)
		move.b	obStatus(a1),obStatus(a0)
		move.b	obRender(a1),obRender(a0)
		addi.w	#$10,obY(a0)
		move.w	#-$36,d0
		btst	#0,obStatus(a0)
		beq.s	loc_17D38
		neg.w	d0

loc_17D38:
		add.w	d0,obX(a0)
		lea	(Ani_Obj58a).l,a1
		bsr.w	j_AnimateSprite_9
		bra.w	loc_181A8
; ---------------------------------------------------------------------------

loc_17D4A:
		move.w	#-3,d0
		btst	#0,obStatus(a0)
		beq.s	loc_17D58
		neg.w	d0

loc_17D58:
		add.w	d0,obX(a0)
		lea	(Ani_Obj58a).l,a1
		bsr.w	j_AnimateSprite_9
		bra.w	loc_181A8

; =============== S U B	R O U T	I N E =======================================


sub_17D6A:
		cmpi.b	#1,obColProp(a1)
		beq.s	loc_17D74
		rts
; ---------------------------------------------------------------------------

loc_17D74:
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		bpl.s	loc_17D88
		btst	#0,obStatus(a1)
		bne.s	loc_17D92
		rts
; ---------------------------------------------------------------------------

loc_17D88:
		btst	#0,obStatus(a1)
		beq.s	loc_17D92
		rts
; ---------------------------------------------------------------------------

loc_17D92:
		bset	#3,objoff_2D(a1)
		rts
; End of function sub_17D6A


; =============== S U B	R O U T	I N E =======================================


sub_17D9A:
		jsr	(FindNextFreeObj).l
		bne.s	loc_17E0E
		_move.b	#id_Obj58,obID(a1)
		move.l	a0,objoff_34(a1)
		move.l	#Map_Obj58a,obMap(a1)
		move.w	#make_art_tile($4C0,1,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$10,obActWid(a1)
		move.b	#1,obPriority(a1)
		move.b	#$10,obHeight(a1)
		move.b	#$10,obWidth(a1)
		move.l	obX(a0),obX(a1)
		move.l	obY(a0),obY(a1)
		addi.w	#$1C,obX(a1)
		addi.w	#$C,obY(a1)
		move.w	#-$200,obVelX(a1)
		move.b	#4,obRoutine(a1)
		move.b	#4,obFrame(a1)
		move.b	#1,obAnim(a1)
		move.w	#$16,objoff_2A(a1)

loc_17E0E:
		jsr	(FindNextFreeObj).l
		bne.s	loc_17E82
		_move.b	#id_Obj58,obID(a1)
		move.l	a0,objoff_34(a1)
		move.l	#Map_Obj58a,obMap(a1)
		move.w	#make_art_tile($4C0,1,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$10,obActWid(a1)
		move.b	#1,obPriority(a1)
		move.b	#$10,obHeight(a1)
		move.b	#$10,obWidth(a1)
		move.l	obX(a0),obX(a1)
		move.l	obY(a0),obY(a1)
		addi.w	#-$C,obX(a1)
		addi.w	#$C,obY(a1)
		move.w	#-$200,obVelX(a1)
		move.b	#4,obRoutine(a1)
		move.b	#4,obFrame(a1)
		move.b	#1,obAnim(a1)
		move.w	#$4B,objoff_2A(a1)

loc_17E82:
		jsr	(FindNextFreeObj).l
		bne.s	loc_17EF6
		_move.b	#id_Obj58,obID(a1)
		move.l	a0,objoff_34(a1)
		move.l	#Map_Obj58a,obMap(a1)
		move.w	#make_art_tile($4C0,1,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$10,obActWid(a1)
		move.b	#2,obPriority(a1)
		move.b	#$10,obHeight(a1)
		move.b	#$10,obWidth(a1)
		move.l	obX(a0),obX(a1)
		move.l	obY(a0),obY(a1)
		addi.w	#-$2C,obX(a1)
		addi.w	#$C,obY(a1)
		move.w	#-$200,obVelX(a1)
		move.b	#4,obRoutine(a1)
		move.b	#6,obFrame(a1)
		move.b	#2,obAnim(a1)
		move.w	#$30,objoff_2A(a1)

loc_17EF6:
		jsr	(FindNextFreeObj).l
		bne.s	locret_17F52
		_move.b	#id_Obj58,obID(a1)
		move.l	a0,objoff_34(a1)
		move.l	#Map_Obj58a,obMap(a1)
		move.w	#make_art_tile($4C0,1,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$10,obActWid(a1)
		move.b	#1,obPriority(a1)
		move.l	obX(a0),obX(a1)
		move.l	obY(a0),obY(a1)
		addi.w	#-$36,obX(a1)
		addi.w	#8,obY(a1)
		move.b	#6,obRoutine(a1)
		move.b	#1,obFrame(a1)
		move.b	#0,obAnim(a1)

locret_17F52:
		rts
; End of function sub_17D9A

; ---------------------------------------------------------------------------

loc_17F54:
		jsr	(FindNextFreeObj).l
		bne.s	loc_17F98
		_move.b	#id_Obj58,obID(a1)
		move.l	a0,objoff_34(a1)
		move.l	#Map_Obj58a,obMap(a1)
		move.w	#make_art_tile($4C0,0,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$20,obActWid(a1)
		move.b	#2,obPriority(a1)
		move.l	obX(a0),obX(a1)
		move.l	obY(a0),obY(a1)
		move.b	#2,obRoutine(a1)

loc_17F98:
		bsr.w	sub_17D9A
		subi.w	#8,objoff_38(a0)
		move.w	#$2A00,obX(a0)
		move.w	#$2C0,obY(a0)
		jsr	(FindNextFreeObj).l
		bne.s	locret_17FF8
		_move.b	#id_Obj58,obID(a1)
		move.l	a0,objoff_34(a1)
		move.l	#Map_Obj58,obMap(a1)
		move.w	#make_art_tile($540,1,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$20,obActWid(a1)
		move.b	#4,obPriority(a1)
		move.l	obX(a0),obX(a1)
		move.l	obY(a0),obY(a1)
		move.w	#$1E,objoff_2A(a1)
		move.b	#0,obRoutine(a1)

locret_17FF8:
		rts