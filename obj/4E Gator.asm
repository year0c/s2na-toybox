; ---------------------------------------------------------------------------
; Object 4E - Gator badnik from HPZ
; ---------------------------------------------------------------------------

Obj4E:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj4E_Index(pc,d0.w),d1
		jmp	Obj4E_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj4E_Index:	dc.w Obj4E_Init-Obj4E_Index
		dc.w Obj4E_Main-Obj4E_Index
; ---------------------------------------------------------------------------

Obj4E_Init:
		move.l	#Map_Obj4E,obMap(a0)
		move.w	#make_art_tile(ArtTile_Gator,1,0),obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#$10,obActWid(a0)
		move.b	#$10,obHeight(a0)
		move.b	#8,obWidth(a0)
		bsr.w	j_ObjectMoveAndFall_4
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	locret_17238
		add.w	d1,obY(a0)
		move.w	#0,obVelY(a0)
		addq.b	#2,obRoutine(a0)

locret_17238:
		rts
; ---------------------------------------------------------------------------

Obj4E_Main:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj4E_SubIndex(pc,d0.w),d1
		jsr	Obj4E_SubIndex(pc,d1.w)
		lea	(Ani_Obj4E).l,a1
		bsr.w	j_AnimateSprite_7
		bra.w	loc_174B8
; ---------------------------------------------------------------------------
Obj4E_SubIndex:	dc.w loc_1725A-Obj4E_SubIndex
		dc.w loc_1727E-Obj4E_SubIndex
; ---------------------------------------------------------------------------

loc_1725A:
		subq.w	#1,objoff_30(a0)
		bpl.s	locret_1727C
		addq.b	#2,ob2ndRout(a0)
		move.w	#-$C0,obVelX(a0)
		move.b	#0,obAnim(a0)
		bchg	#0,obStatus(a0)
		bne.s	locret_1727C
		neg.w	obVelX(a0)

locret_1727C:
		rts
; ---------------------------------------------------------------------------

loc_1727E:
		bsr.w	sub_172B6
		bsr.w	j_ObjectMove_6
		jsr	(ObjHitFloor).l
		cmpi.w	#-8,d1
		blt.s	loc_1729E
		cmpi.w	#$C,d1
		bge.s	loc_1729E
		add.w	d1,obY(a0)
		rts
; ---------------------------------------------------------------------------

loc_1729E:
		subq.b	#2,ob2ndRout(a0)
		move.w	#60-1,objoff_30(a0)
		move.w	#0,obVelX(a0)
		move.b	#1,obAnim(a0)
		rts

; =============== S U B	R O U T	I N E =======================================


sub_172B6:
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		bmi.s	loc_172D0
		cmpi.w	#$40,d0
		bgt.s	loc_172E6
		btst	#0,obStatus(a0)
		beq.s	loc_172DE
		rts
; ---------------------------------------------------------------------------

loc_172D0:
		cmpi.w	#-$40,d0
		blt.s	loc_172E6
		btst	#0,obStatus(a0)
		beq.s	loc_172E6

loc_172DE:
		move.b	#2,obAnim(a0)
		rts
; ---------------------------------------------------------------------------

loc_172E6:
		move.b	#0,obAnim(a0)
		rts
; End of function sub_172B6