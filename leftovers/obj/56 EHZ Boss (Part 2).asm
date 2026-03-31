; ---------------------------------------------------------------------------
; Object 56 - sub object of the EHZ boss
; ---------------------------------------------------------------------------

Obj56_PB:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj56_PB_Index(pc,d0.w),d1
		jmp	Obj56_PB_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj56_PB_Index:	dc.w Obj56_PB_Init-Obj56_PB_Index
		dc.w Obj56_PB_Animate-Obj56_PB_Index
; ---------------------------------------------------------------------------

Obj56_PB_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj56_PB,obMap(a0)
		move.w	#make_art_tile(ArtTile_ArtNem_EggChoppers+$60,0,0),obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#0,obColType(a0)
		move.b	#12,obActWid(a0)
		move.b	#7,obTimeFrame(a0)
		move.b	#0,obFrame(a0)
		rts
; ---------------------------------------------------------------------------

Obj56_PB_Animate:
		subq.b	#1,obTimeFrame(a0)
		bpl.s	.loc_184BA
		move.b	#7,obTimeFrame(a0)
		addq.b	#1,obFrame(a0)
		cmpi.b	#7,obFrame(a0)
		beq.w	$17194+$40E	;	JmpTo10_DeleteObject

.loc_184BA:
		bra.w	$17194+$408	;	JmpTo8_DisplaySprite