; ---------------------------------------------------------------------------
; Object 4E - Gator badnik from HPZ
; ---------------------------------------------------------------------------

Obj4E_PB:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj4E_PB_Index(pc,d0.w),d1
		jmp	Obj4E_PB_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj4E_PB_Index:	dc.w Obj4E_PB_Init-Obj4E_PB_Index
		dc.w Obj4E_PB_Main-Obj4E_PB_Index
; ---------------------------------------------------------------------------

Obj4E_PB_Init:
		move.l	#Map_Obj4E_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_Gator,1,0),obGfx(a0)
		ori.b	#4,obRender(a0)
		move.b	#$A,obColType(a0)
		move.b	#4,obPriority(a0)
		move.b	#16,obActWid(a0)
		move.b	#16,obHeight(a0)
		move.b	#8,obWidth(a0)
		bsr.w	$16200+$2EC	;	JmpTo6_ObjectMoveAndFall
		jsr	($128C6).l	; ObjHitFloor
		tst.w	d1
		bpl.s	.locret_17238
		add.w	d1,obY(a0)
		move.w	#0,obVelY(a0)
		addq.b	#2,obRoutine(a0)

.locret_17238:
		rts
; ---------------------------------------------------------------------------

Obj4E_PB_Main:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj4E_PB_SubIndex(pc,d0.w),d1
		jsr	Obj4E_PB_SubIndex(pc,d1.w)
		lea	(Ani_Obj4E_PB).l,a1
		bsr.w	$16200+$2E6	;	JmpTo8_AnimateSprite
		bra.w	$16200+$2E0	;	JmpTo6_MarkObjGone
; ---------------------------------------------------------------------------
Obj4E_PB_SubIndex:	dc.w .loc_1725A-Obj4E_PB_SubIndex
		dc.w .loc_1727E-Obj4E_PB_SubIndex
; ---------------------------------------------------------------------------

.loc_1725A:
		subq.w	#1,objoff_30(a0)
		bpl.s	.locret_1727C
		addq.b	#2,ob2ndRout(a0)
		move.w	#-$C0,obVelX(a0)
		move.b	#0,obAnim(a0)
		bchg	#0,obStatus(a0)
		bne.s	.locret_1727C
		neg.w	obVelX(a0)

.locret_1727C:
		rts
; ---------------------------------------------------------------------------

.loc_1727E:
		bsr.w	.sub_172B6
		bsr.w	$16200+$2F2	;	JmpTo8_ObjectMove
		jsr	($128C6).l	; ObjHitFloor
		cmpi.w	#-8,d1
		blt.s	.loc_1729E
		cmpi.w	#$C,d1
		bge.s	.loc_1729E
		add.w	d1,obY(a0)
		rts
; ---------------------------------------------------------------------------

.loc_1729E:
		subq.b	#2,ob2ndRout(a0)
		move.w	#60-1,objoff_30(a0)
		move.w	#0,obVelX(a0)
		move.b	#1,obAnim(a0)
		rts

; =============== S U B	R O U T	I N E =======================================


.sub_172B6:
		move.w	obX(a0),d0
		sub.w	(v_player+obX).w,d0
		bmi.s	.loc_172D0
		cmpi.w	#$40,d0
		bgt.s	.loc_172E6
		btst	#0,obStatus(a0)
		beq.s	.loc_172DE
		rts
; ---------------------------------------------------------------------------

.loc_172D0:
		cmpi.w	#-$40,d0
		blt.s	.loc_172E6
		btst	#0,obStatus(a0)
		beq.s	.loc_172E6

.loc_172DE:
		move.b	#2,obAnim(a0)
		rts
; ---------------------------------------------------------------------------

.loc_172E6:
		move.b	#0,obAnim(a0)
		rts
; End of function sub_172B6