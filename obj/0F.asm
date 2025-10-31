; ---------------------------------------------------------------------------
; Object 0F - Mappings test?
; ---------------------------------------------------------------------------

Obj0F:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj0F_Index(pc,d0.w),d1
		jsr	Obj0F_Index(pc,d1.w)
		bra.w	DisplaySprite
; ===========================================================================
Obj0F_Index:	dc.w Obj0F_Init-Obj0F_Index
		dc.w Obj0F_Cycle-Obj0F_Index
		dc.w Obj0F_Cycle-Obj0F_Index
; ===========================================================================

Obj0F_Init:
		addq.b	#2,obRoutine(a0)
		move.w	#$90,obX(a0)
		move.w	#$90,obScreenY(a0)
		move.l	#Map_Obj0F,obMap(a0)
		move.w	#make_art_tile(ArtTile_Monitor,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer

Obj0F_Cycle:
		move.b	(v_jpadpress1).w,d0
		btst	#bitC,d0			; has C been pressed?
		beq.s	Obj0F_Toggle			; if not, branch
		addq.b	#1,obFrame(a0)			; increment mappings
		andi.b	#$F,obFrame(a0)			; if above $F, reset

Obj0F_Toggle:
		btst	#bitB,d0			; has B been pressed?
		beq.s	.donothing			; if not, branch
		bchg	#0,(unk_FFE9).w			; try turning on two player mode which will not work...

.donothing:
		rts