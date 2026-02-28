; ---------------------------------------------------------------------------
; Object 56 - sub object of the EHZ boss
; ---------------------------------------------------------------------------

Obj56:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj56_Index(pc,d0.w),d1
		jmp	Obj56_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj56_Index:	dc.w Obj56_Init-Obj56_Index
		dc.w Obj56_Animate-Obj56_Index
; ---------------------------------------------------------------------------

Obj56_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj56,obMap(a0)
		move.w	#make_art_tile($5A0,0,0),obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#0,obColType(a0)
		move.b	#$C,obActWid(a0)
		move.b	#7,obTimeFrame(a0)
		move.b	#0,obFrame(a0)
		rts
; ---------------------------------------------------------------------------

Obj56_Animate:
		subq.b	#1,obTimeFrame(a0)
		bpl.s	loc_184BA
		move.b	#7,obTimeFrame(a0)
		addq.b	#1,obFrame(a0)
		cmpi.b	#7,obFrame(a0)
		beq.w	loc_185DA

loc_184BA:
		bra.w	loc_185D4