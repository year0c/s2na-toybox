; ---------------------------------------------------------------------------
; Object 4C - BBat badnik from HPZ
; ---------------------------------------------------------------------------

Obj4C:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj4C_Index(pc,d0.w),d1
		jmp	Obj4C_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj4C_Index:	dc.w Obj4C_Init-Obj4C_Index
		dc.w loc_16DA2-Obj4C_Index
		dc.w loc_16E10-Obj4C_Index
; ---------------------------------------------------------------------------

Obj4C_Init:
		move.l	#Map_Obj4C,obMap(a0)
	if FixBugs
		move.w	#make_art_tile(ArtTile_BBat,0,0),obGfx(a0)
	else
		; Bug: This uses the level's palette line which makes the flames look yellow.
		move.w	#make_art_tile(ArtTile_BBat,1,0),obGfx(a0)
	endif
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#$10,obActWid(a0)
		move.b	#$10,obHeight(a0)
		move.b	#8,obWidth(a0)
		addq.b	#2,obRoutine(a0)
		move.w	obY(a0),objoff_2E(a0)
		rts
; ---------------------------------------------------------------------------

loc_16DA2:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj4C_SubIndex(pc,d0.w),d1
		jsr	Obj4C_SubIndex(pc,d1.w)
		bsr.w	sub_16DC8
		lea	(Ani_Obj4C).l,a1
		jsrto	JmpTo7_AnimateSprite
		jmpto	JmpTo5_MarkObjGone
; ---------------------------------------------------------------------------
Obj4C_SubIndex:	dc.w loc_16F2E-Obj4C_SubIndex
		dc.w loc_16F66-Obj4C_SubIndex
		dc.w loc_16F72-Obj4C_SubIndex

; =============== S U B	R O U T	I N E =======================================


sub_16DC8:
		move.b	objoff_3F(a0),d0
		jsr	(CalcSine).l
		asr.w	#6,d0
		add.w	objoff_2E(a0),d0
		move.w	d0,obY(a0)
		addq.b	#4,objoff_3F(a0)
		rts
; End of function sub_16DC8


; =============== S U B	R O U T	I N E =======================================


sub_16DE2:
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		cmpi.w	#$80,d0
		bgt.s	locret_16E0E
		cmpi.w	#-$80,d0
		blt.s	locret_16E0E
		move.b	#4,ob2ndRout(a0)
		move.b	#2,obAnim(a0)
		move.w	#8,objoff_2A(a0)
		move.b	#0,objoff_3E(a0)

locret_16E0E:
		rts
; End of function sub_16DE2

; ---------------------------------------------------------------------------

loc_16E10:
		bsr.w	sub_16F0E
		bsr.w	sub_16EB0
		bsr.w	sub_16E30
		jsrto	JmpTo7_ObjectMove
		lea	(Ani_Obj4C).l,a1
		jsrto	JmpTo7_AnimateSprite
		jmpto	JmpTo5_MarkObjGone
; ---------------------------------------------------------------------------
		rts

; =============== S U B	R O U T	I N E =======================================


sub_16E30:
		tst.b	objoff_3D(a0)
		beq.s	locret_16E42
		bset	#0,obRender(a0)
		bset	#0,obStatus(a0)

locret_16E42:
		rts
; End of function sub_16E30


; =============== S U B	R O U T	I N E =======================================


sub_16E44:
		subi.w	#1,objoff_2C(a0)
		bpl.s	locret_16E8E
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		cmpi.w	#$60,d0
		bgt.s	loc_16E90
		cmpi.w	#-$60,d0
		blt.s	loc_16E90
		tst.w	d0
		bpl.s	loc_16E68
		st.b	objoff_3D(a0)

loc_16E68:
		move.b	#$40,objoff_3F(a0)
		move.w	#$400,obInertia(a0)
		move.b	#4,obRoutine(a0)
		move.b	#3,obAnim(a0)
		move.w	#$C,objoff_2A(a0)
		move.b	#1,objoff_3E(a0)
		moveq	#0,d0

locret_16E8E:
		rts
; ---------------------------------------------------------------------------

loc_16E90:
		cmpi.w	#$80,d0
		bgt.s	loc_16E9C
		cmpi.w	#-$80,d0
		bgt.s	locret_16E8E

loc_16E9C:
		move.b	#1,obAnim(a0)
		move.b	#0,ob2ndRout(a0)
		move.w	#$18,objoff_2A(a0)
		rts
; End of function sub_16E44


; =============== S U B	R O U T	I N E =======================================


sub_16EB0:
		tst.b	objoff_3D(a0)
		bne.s	loc_16ECA
		moveq	#0,d0
		move.b	objoff_3F(a0),d0
		cmpi.w	#$C0,d0
		bge.s	loc_16EDE
		addq.b	#2,d0
		move.b	d0,objoff_3F(a0)
		rts
; ---------------------------------------------------------------------------

loc_16ECA:
		moveq	#0,d0
		move.b	objoff_3F(a0),d0
		cmpi.w	#$C0,d0
		beq.s	loc_16EDE
		subq.b	#2,d0
		move.b	d0,objoff_3F(a0)
		rts
; ---------------------------------------------------------------------------

loc_16EDE:
		sf.b	objoff_3D(a0)
		move.b	#0,obAnim(a0)
		move.b	#2,obRoutine(a0)
		move.b	#0,ob2ndRout(a0)
		move.w	#$18,objoff_2A(a0)
		move.b	#1,obAnim(a0)
		bclr	#0,obRender(a0)
		bclr	#0,obStatus(a0)
		rts
; End of function sub_16EB0


; =============== S U B	R O U T	I N E =======================================


sub_16F0E:
		move.b	objoff_3F(a0),d0
		jsr	(CalcSine).l
		muls.w	obInertia(a0),d1
		asr.l	#8,d1
		move.w	d1,obVelX(a0)
		muls.w	obInertia(a0),d0
		asr.l	#8,d0
		move.w	d0,obVelY(a0)
		rts
; End of function sub_16F0E

; ---------------------------------------------------------------------------

loc_16F2E:
		subi.w	#1,objoff_2A(a0)
		bpl.s	locret_16F64
		bsr.w	sub_16DE2
		beq.s	locret_16F64
		jsr	(RandomNumber).l
		andi.b	#$FF,d0
		bne.s	locret_16F64
		move.w	#$18,objoff_2A(a0)
		move.w	#30,objoff_2C(a0)
		addq.b	#2,ob2ndRout(a0)
		move.b	#1,obAnim(a0)
		move.b	#0,objoff_3E(a0)

locret_16F64:
		rts
; ---------------------------------------------------------------------------

loc_16F66:
		subq.b	#1,objoff_2A(a0)
		bpl.s	locret_16F70
		subq.b	#2,ob2ndRout(a0)

locret_16F70:
		rts
; ---------------------------------------------------------------------------

loc_16F72:
		bsr.w	sub_16E44
		beq.s	locret_16FB8
		subi.w	#1,objoff_2A(a0)
		bne.s	locret_16FB8
		move.b	objoff_3E(a0),d0
		beq.s	loc_16FA0
		move.b	#0,objoff_3E(a0)
		move.w	#8,objoff_2A(a0)
		bset	#0,obRender(a0)
		bset	#0,obStatus(a0)
		rts
; ---------------------------------------------------------------------------

loc_16FA0:
		move.b	#1,objoff_3E(a0)
		move.w	#$C,objoff_2A(a0)
		bclr	#0,obRender(a0)
		bclr	#0,obStatus(a0)

locret_16FB8:
		rts