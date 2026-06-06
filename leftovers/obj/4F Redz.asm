; ---------------------------------------------------------------------------
; Object 4F - Redz (dinosaur badnik) from HPZ
; ---------------------------------------------------------------------------

Obj4F_PB:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj4F_PB_Index(pc,d0.w),d1
		jmp	Obj4F_PB_Index(pc,d1.w)
; ===========================================================================
Obj4F_PB_Index:	dc.w Obj4F_PB_Init-Obj4F_PB_Index
		dc.w Obj4F_PB_Main-Obj4F_PB_Index
		dc.w Obj4F_PB_Delete-Obj4F_PB_Index
; ===========================================================================

Obj4F_PB_Init:
		move.l	#Map_Obj4F_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_Redz,0,0),obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#16,obActWid(a0)
		move.b	#16,obHeight(a0)
		move.b	#6,obWidth(a0)
		move.b	#$C,obColType(a0)
		bsr.w	$14DF8+$156	;	JmpTo3_ObjectMoveAndFall
		jsr	(ObjHitFloor_PB).l
		tst.w	d1
		bpl.s	.locret_15E0C
		add.w	d1,obY(a0)
		move.w	#0,obVelY(a0)
		addq.b	#2,obRoutine(a0)
		bchg	#0,obStatus(a0)

.locret_15E0C:
		rts
; ===========================================================================

Obj4F_PB_Main:
		moveq	#0,d0
		move.b	ob2ndRout(a0),d0
		move.w	Obj4F_PB_SubIndex(pc,d0.w),d1
		jsr	Obj4F_PB_SubIndex(pc,d1.w)
		lea	(Ani_Obj4F_PB).l,a1
		bsr.w	$14DF8+$150	;	JmpTo3_AnimateSprite
		out_of_range.w	.loc_15E3E
		bra.w	$14DF8+$144	;	JmpTo4_DisplaySprite
; ---------------------------------------------------------------------------

.loc_15E3E:
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		beq.s	.loc_15E50
		bclr	#7,2(a2,d0.w)

.loc_15E50:
		bra.w	$14DF8+$14A	;	JmpTo4_DeleteObject
; ===========================================================================
Obj4F_PB_SubIndex:	dc.w Obj4F_PB_MoveLeft-Obj4F_PB_SubIndex
		dc.w Obj4F_PB_ChkFloor-Obj4F_PB_SubIndex
; ===========================================================================
; loc_15E58:
Obj4F_PB_MoveLeft:
		subq.w	#1,objoff_30(a0)		; is Redz not moving?
		bpl.s	.locret_15E7A			; if not, branch
		addq.b	#2,ob2ndRout(a0)
		move.w	#-$80,obVelX(a0)
		move.b	#1,obAnim(a0)
		bchg	#0,obStatus(a0)
		bne.s	.locret_15E7A
		neg.w	obVelX(a0)

.locret_15E7A:
		rts
; ===========================================================================
; loc_15E7C:
Obj4F_PB_ChkFloor:
		bsr.w	$14DF8+$15C	;	JmpTo4_ObjectMove
		jsr	(ObjHitFloor_PB).l
		cmpi.w	#-8,d1
		blt.s	Obj4F_PB_StopMoving
		cmpi.w	#$C,d1
		bge.s	Obj4F_PB_StopMoving
		add.w	d1,obY(a0)
		rts
; ---------------------------------------------------------------------------
; loc_15E98:
Obj4F_PB_StopMoving:
		subq.b	#2,ob2ndRout(a0)
		move.w	#60-1,objoff_30(a0)		; pause for 1 second
		move.w	#0,obVelX(a0)
		move.b	#0,obAnim(a0)
		rts
; ===========================================================================

Obj4F_PB_Delete:
		bra.w	$14DF8+$14A	;	JmpTo4_DeleteObject