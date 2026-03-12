; ---------------------------------------------------------------------------
; Object 4D - Stegway badnik
; ---------------------------------------------------------------------------

Obj4D:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj4D_Index(pc,d0.w),d1
		jmp	Obj4D_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj4D_Index:	dc.w Obj4D_Init-Obj4D_Index
		dc.w Obj4D_Main-Obj4D_Index
; ---------------------------------------------------------------------------

Obj4D_Init:
		move.l	#Map_Obj4D,obMap(a0)
		move.w	#make_art_tile(ArtTile_Stegway,1,0),obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#$18,obActWid(a0)
		move.b	#$10,obHeight(a0)
		move.b	#$18,obWidth(a0)
		jsrto	JmpTo2_ObjectMoveAndFall
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	locret_158DC
		add.w	d1,obY(a0)
		move.w	#0,obVelY(a0)
		addq.b	#2,obRoutine(a0)

locret_158DC:
		rts
; ---------------------------------------------------------------------------

Obj4D_Main:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj4D_SubIndex(pc,d0.w),d1
		jsr	Obj4D_SubIndex(pc,d1.w)
		lea	(Ani_Obj4D).l,a1
		jsrto	JmpTo_AnimateSprite
		jmpto	JmpTo_MarkObjGone
; ---------------------------------------------------------------------------
Obj4D_SubIndex:	dc.w loc_158FE-Obj4D_SubIndex
		dc.w loc_15922-Obj4D_SubIndex
; ---------------------------------------------------------------------------

loc_158FE:
		subq.w	#1,objoff_30(a0)
		bpl.s	locret_15920
		addq.b	#2,ob2ndRout(a0)
		move.w	#-$80,obVelX(a0)
		move.b	#0,obAnim(a0)
		bchg	#0,obStatus(a0)
		bne.s	locret_15920
		neg.w	obVelX(a0)

locret_15920:
		rts
; ---------------------------------------------------------------------------

loc_15922:
		bsr.w	sub_1596C
		jsrto	JmpTo2_ObjectMoveAndFall
		jsr	(ObjHitFloor).l
		cmpi.w	#-8,d1
		blt.s	loc_15948
		cmpi.w	#$C,d1
		bge.s	locret_15946
		move.w	#0,obVelY(a0)
		add.w	d1,obY(a0)

locret_15946:
		rts
; ---------------------------------------------------------------------------

loc_15948:
		subq.b	#2,ob2ndRout(a0)
		move.w	#59,objoff_30(a0)
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,obX(a0)
		move.w	#0,obVelX(a0)
		move.b	#1,obAnim(a0)
		rts

; =============== S U B	R O U T	I N E =======================================


sub_1596C:
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		bmi.s	loc_159A0
		cmpi.w	#$60,d0
		bgt.s	locret_15990
		btst	#0,obStatus(a0)
		bne.s	loc_15992
		move.b	#2,obAnim(a0)
		move.w	#-$200,obVelX(a0)

locret_15990:
		rts
; ---------------------------------------------------------------------------

loc_15992:
		move.b	#0,obAnim(a0)
		move.w	#$80,obVelX(a0)
		rts
; ---------------------------------------------------------------------------

loc_159A0:
		cmpi.w	#-$60,d0
		blt.s	locret_15990
		btst	#0,obStatus(a0)
		beq.s	loc_159BC
		move.b	#2,obAnim(a0)
		move.w	#$200,obVelX(a0)
		rts
; ---------------------------------------------------------------------------

loc_159BC:
		move.b	#0,obAnim(a0)
		move.w	#-$80,obVelX(a0)
		rts