; ---------------------------------------------------------------------------
; Object 57 - sub object of the	EHZ boss
; ---------------------------------------------------------------------------

Obj57:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	off_17892(pc,d0.w),d1
		jmp	off_17892(pc,d1.w)
; ---------------------------------------------------------------------------
off_17892:	dc.w loc_1789E-off_17892
		dc.w loc_178C4-off_17892
		dc.w loc_17920-off_17892
		dc.w loc_17952-off_17892
		dc.w loc_1797C-off_17892
		dc.w loc_17996-off_17892
; ---------------------------------------------------------------------------

loc_1789E:
		move.b	#0,obColType(a0)
		cmpi.w	#$29D0,obX(a0)
		ble.s	loc_178B6
		subi.w	#1,obX(a0)
		jmpto	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

loc_178B6:
		move.w	#$29D0,obX(a0)
		addq.b	#2,ob2ndRout(a0)
		jmpto	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

loc_178C4:
		moveq	#0,d0
		move.b	objoff_2C(a0),d0
		move.w	off_178D2(pc,d0.w),d1
		jmp	off_178D2(pc,d1.w)
; ---------------------------------------------------------------------------
off_178D2:	dc.w loc_178D6-off_178D2
		dc.w loc_178FC-off_178D2
; ---------------------------------------------------------------------------

loc_178D6:
		cmpi.w	#$41E,obY(a0)
		bge.s	loc_178E8
		addi.w	#1,obY(a0)
		jmpto	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

loc_178E8:
		addq.b	#2,objoff_2C(a0)
		bset	#0,objoff_2D(a0)
		move.w	#$3C,objoff_2A(a0)
		jmpto	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

loc_178FC:
		subi.w	#1,objoff_2A(a0)
		bpl.w	JmpTo7_DisplaySprite
		move.w	#-$200,obVelX(a0)
		addq.b	#2,ob2ndRout(a0)
		move.b	#$F,obColType(a0)
		bset	#1,objoff_2D(a0)

	if RemoveJmpTos
JmpTo7_DisplaySprite	; JmpTo
	endif
		jmpto	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

loc_17920:
		bsr.w	sub_17A8C
		bsr.w	sub_17A6A
		move.w	objoff_2E(a0),d0
		lsr.w	#1,d0
		subi.w	#$14,d0
		move.w	d0,obY(a0)
		move.w	#0,objoff_2E(a0)
		move.l	obX(a0),d2
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d2
		move.l	d2,obX(a0)
		jmpto	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

loc_17952:
		subq.w	#1,objoff_3C(a0)
		bpl.w	BossDefeated
		bset	#0,obStatus(a0)
		bclr	#7,obStatus(a0)
		clr.w	obVelX(a0)
		addq.b	#2,ob2ndRout(a0)
		move.w	#-$26,objoff_3C(a0)
		move.w	#$C,objoff_2A(a0)
		rts
; ---------------------------------------------------------------------------

loc_1797C:
		addq.w	#1,obY(a0)
		subq.w	#1,objoff_2A(a0)
		bpl.w	JmpTo7_DisplaySprite
		addq.b	#2,ob2ndRout(a0)
		move.b	#0,objoff_2C(a0)
		jmpto	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------

loc_17996:
		moveq	#0,d0
		move.b	objoff_2C(a0),d0
		move.w	off_179A8(pc,d0.w),d1
		jsr	off_179A8(pc,d1.w)
		jmpto	JmpTo7_DisplaySprite
; ---------------------------------------------------------------------------
off_179A8:	dc.w loc_179AE-off_179A8
		dc.w loc_17A22-off_179A8
		dc.w loc_17A3C-off_179A8
; ---------------------------------------------------------------------------

loc_179AE:
		bclr	#0,objoff_2D(a0)
		jsrto	JmpTo3_FindNextFreeObj
		bne.w	JmpTo7_DisplaySprite
		_move.b	#id_Obj58,obID(a1)
		move.l	a0,objoff_34(a1)
		move.l	#Map_Obj58,obMap(a1)
		move.w	#make_art_tile(ArtTile_ArtNem_EggChoppers,1,0),obGfx(a1)
		move.b	#4,obRender(a1)
		move.b	#$20,obActWid(a1)
		move.b	#4,obPriority(a1)
		move.l	obX(a0),obX(a1)
		move.l	obY(a0),obY(a1)
		addi.w	#$C,obY(a1)
		move.b	obStatus(a0),obStatus(a1)
		move.b	obRender(a0),obRender(a1)
		move.b	#8,obRoutine(a1)
		move.b	#2,obAnim(a1)
		move.w	#$10,objoff_2A(a1)
		move.w	#$32,objoff_2A(a0)
		addq.b	#2,objoff_2C(a0)
		rts
; ---------------------------------------------------------------------------

loc_17A22:
		subi.w	#1,objoff_2A(a0)
		bpl.s	locret_17A3A
		bset	#2,objoff_2D(a0)
		move.w	#$60,objoff_2A(a0)
		addq.b	#2,objoff_2C(a0)

locret_17A3A:
		rts
; ---------------------------------------------------------------------------

loc_17A3C:
		subq.w	#1,obY(a0)
		subi.w	#1,objoff_2A(a0)
		bpl.s	locret_17A68
		addq.w	#1,obY(a0)
		addq.w	#2,obX(a0)
		cmpi.w	#$2B08,obX(a0)
		blo.s	locret_17A68
		tst.b	(Boss_defeated_flag).w
		bne.s	locret_17A68
		move.b	#1,(Boss_defeated_flag).w
		jmpto	JmpTo9_DeleteObject
; ---------------------------------------------------------------------------

locret_17A68:
		rts

; =============== S U B	R O U T	I N E =======================================


sub_17A6A:
		move.w	obX(a0),d0
		cmpi.w	#$2720,d0
		ble.s	loc_17A7A
		cmpi.w	#$2B08,d0
		blt.s	locret_17A8A

loc_17A7A:
		bchg	#0,obStatus(a0)
		bchg	#0,obRender(a0)
		neg.w	obVelX(a0)

locret_17A8A:
		rts
; End of function sub_17A6A


; =============== S U B	R O U T	I N E =======================================


sub_17A8C:
		cmpi.b	#6,ob2ndRout(a0)
		bhs.s	locret_17AD2
		tst.b	obStatus(a0)
		bmi.s	loc_17AD4
		tst.b	obColType(a0)
		bne.s	locret_17AD2
		tst.b	objoff_3E(a0)
		bne.s	loc_17AB6
		move.b	#$20,objoff_3E(a0)
		move.w	#sfx_HitBoss,d0
		jsr	(QueueSound2).l

loc_17AB6:
		lea	(v_palette+$22).w,a1
		moveq	#0,d0
		tst.w	(a1)
		bne.s	loc_17AC4
		move.w	#cWhite,d0

loc_17AC4:
		move.w	d0,(a1)
		subq.b	#1,objoff_3E(a0)
		bne.s	locret_17AD2
		move.b	#$F,obColType(a0)

locret_17AD2:
		rts
; ---------------------------------------------------------------------------

loc_17AD4:
		moveq	#100,d0
		bsr.w	AddPoints
		move.b	#6,ob2ndRout(a0)
		move.w	#180-1,objoff_3C(a0)
		bset	#3,objoff_2D(a0)
		rts
; End of function sub_17A8C