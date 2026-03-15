; ---------------------------------------------------------------------------
; Object 16 - the HTZ platform that goes down diagonally and stops after a while (in final, it falls)
; ---------------------------------------------------------------------------

Obj16:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj16_Index(pc,d0.w),d1
		jmp	Obj16_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj16_Index:	dc.w Obj16_Init-Obj16_Index
		dc.w Obj16_Main-Obj16_Index
; ---------------------------------------------------------------------------

Obj16_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj16,obMap(a0)
		move.w	#make_art_tile(ArtTile_HtzZipline,2,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
	if FixBugs
		ori.b	#4,obRender(a0)
	else
		; Bug: This does not correctly flip the object.
		move.b	#4,obRender(a0)
	endif
		move.b	#32,obActWid(a0)
		move.b	#0,obFrame(a0)
		move.b	#1,obPriority(a0)
		move.w	obX(a0),objoff_30(a0)
		move.w	obY(a0),objoff_32(a0)

Obj16_Main:
		move.w	obX(a0),-(sp)
		bsr.w	sub_15184
		moveq	#0,d1
		move.b	obActWid(a0),d1
		move.w	#-$28,d3
		move.w	(sp)+,d4
		bsr.w	sub_F78A
	if FixBugs=0
		; Redundant line of code.
		move.w	objoff_30(a0),d0
	endif
		out_of_range.w	JmpTo_DeleteObject
		jmpto	JmpTo_DisplaySprite

	if RemoveJmpTos
JmpTo_DeleteObject	; JmpTo
		jmp	(DeleteObject).l
	endif

; =============== S U B	R O U T	I N E =======================================


sub_15184:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#$F,d0
		add.w	d0,d0
		move.w	Obj16_SubIndex(pc,d0.w),d1
		jmp	Obj16_SubIndex(pc,d1.w)
; End of function sub_15184

; ---------------------------------------------------------------------------
Obj16_SubIndex:	dc.w Obj16_InitMove-Obj16_SubIndex
		dc.w Obj16_Move-Obj16_SubIndex
		dc.w Obj16_NoMove-Obj16_SubIndex
; ---------------------------------------------------------------------------

Obj16_InitMove:
		move.b	obStatus(a0),d0
		andi.b	#$18,d0
		beq.s	locret_151BE
		addq.b	#1,obSubtype(a0)
		move.w	#$200,obVelX(a0)
	if FixBugs
		btst	#0,obStatus(a0)
		beq.s	.facingright
		neg.w	obVelX(a0)

.facingright:
	else
		; This object does not work when being flipped horizontally.
	endif
		move.w	#$100,obVelY(a0)
		move.w	#160,objoff_34(a0)	; set wait time to 5.3 seconds

locret_151BE:
		rts
; ---------------------------------------------------------------------------

Obj16_Move:
		jsrto	JmpTo_ObjectMove
		subq.w	#1,objoff_34(a0)
		bne.s	locret_151CE
		addq.b	#1,obSubtype(a0)

locret_151CE:
		rts
; ---------------------------------------------------------------------------

Obj16_NoMove:
		rts