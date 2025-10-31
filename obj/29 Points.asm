;----------------------------------------------------
; Object 29 - points that appear when you destroy something
;----------------------------------------------------

Obj29:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj29_Index(pc,d0.w),d1
		jmp	Obj29_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj29_Index:	dc.w loc_9FB2-Obj29_Index
		dc.w loc_9FE0-Obj29_Index
; ---------------------------------------------------------------------------

loc_9FB2:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj29,obMap(a0)
		move.w	#make_art_tile($4AC,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#8,obActWid(a0)
		move.w	#-$300,obVelY(a0)

loc_9FE0:
		tst.w	obVelY(a0)
		bpl.w	DeleteObject
		bsr.w	ObjectMove
		addi.w	#$18,obVelY(a0)
		bra.w	DisplaySprite