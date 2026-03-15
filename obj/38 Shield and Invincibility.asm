; ---------------------------------------------------------------------------
; Object 38 - shield and invincibility stars
; ---------------------------------------------------------------------------

Obj38:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj38_Index(pc,d0.w),d1
		jmp	Obj38_Index(pc,d1.w)
; ===========================================================================
Obj38_Index:	dc.w Obj38_Init-Obj38_Index
		dc.w Obj38_Shield-Obj38_Index
		dc.w Obj38_Stars-Obj38_Index
; ===========================================================================

Obj38_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_obj38,obMap(a0)
		move.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#24,obActWid(a0)
		tst.b	obAnim(a0)			; is this the shield?
		bne.s	loc_1240C			; if not, branch
		move.w	#make_art_tile(ArtTile_Shield,0,0),obGfx(a0)
		cmpi.b	#id_EHZ,(Current_Zone).w		; is this Emerald Hill Zone?
		bne.s	loc_12406			; if not, branch
		move.w	#make_art_tile(ArtTile_EHZ_Shield,0,0),obGfx(a0)

loc_12406:
		bsr.w	Adjust2PArtPointer
		rts
; ===========================================================================

loc_1240C:
		addq.b	#2,obRoutine(a0)
	if FixBugs
		move.l	#Map_obj38,obMap(a0)
	else
		move.l	#Map_Sonic,obMap(a0)	; apparently use Sonic's mappings?
	endif
		move.w	#make_art_tile(ArtTile_Invincibility,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#2,obPriority(a0)
		rts
; ===========================================================================

Obj38_Shield:
		tst.b	(v_invinc).w			; is Sonic invincible?
		bne.s	locret_1245A			; if yes, branch
		tst.b	(v_shield).w			; does Sonic have a shield?
		beq.s	Obj38_Delete			; if not, branch
		move.w	(v_player+obX).w,obX(a0)
		move.w	(v_player+obY).w,obY(a0)
		move.b	(v_player+obStatus).w,obStatus(a0)
		lea	(Ani_obj38).l,a1
		jsr	(AnimateSprite).l
		jmp	(DisplaySprite).l
; ---------------------------------------------------------------------------

locret_1245A:
		rts
; ===========================================================================
; loc_1245C:
Obj38_Delete:
		jmp	(DeleteObject).l
; ===========================================================================

Obj38_Stars:
		tst.b	(v_invinc).w			; is Sonic invincible?
		beq.s	Obj38_Delete2			; if not, branch
		move.w	(RecordPos_Unused).w,d0
		move.b	obAnim(a0),d1
		subq.b	#1,d1
		move.b	#$3F,d1
		lsl.b	#2,d1
		addi.b	#4,d1
		sub.b	d1,d0
	if FixBugs
		lea	(Sonic_Pos_Record_Buf).w,a1
	else
		; Bug: This is using Tails position.
		lea	(Tails_Pos_Record_Buf).w,a1
	endif
		lea	(a1,d0.w),a1
		move.w	(a1)+,d0
		andi.w	#$3FFF,d0
		move.w	d0,obX(a0)
		move.w	(a1)+,d0
		andi.w	#$7FF,d0
		move.w	d0,obY(a0)
		move.b	(v_player+obStatus).w,obStatus(a0)
		move.b	(v_player+obFrame).w,obFrame(a0)
		move.b	(v_player+obRender).w,obRender(a0)
		jmp	(DisplaySprite).l
; ===========================================================================
; loc_124B2:
Obj38_Delete2:
		jmp	(DeleteObject).l