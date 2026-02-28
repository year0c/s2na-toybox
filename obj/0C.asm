; ---------------------------------------------------------------------------
; Object 0C -
; ---------------------------------------------------------------------------

Obj0C:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj0C_Index(pc,d0.w),d1
		jmp	Obj0C_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj0C_Index:	dc.w Obj0C_Init-Obj0C_Index
		dc.w Obj0C_Main-Obj0C_Index
; ---------------------------------------------------------------------------

Obj0C_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj0C,obMap(a0)
		move.w	#make_art_tile($418,3,1),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		ori.b	#4,obRender(a0)
		move.b	#$10,obActWid(a0)
		move.b	#4,obPriority(a0)
		move.w	obY(a0),d0
		subi.w	#$10,d0
		move.w	d0,objoff_3A(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#$F0,d0
		addi.w	#$10,d0
		move.w	d0,d1
		subq.w	#1,d0
		move.w	d0,objoff_30(a0)
		move.w	d0,objoff_32(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		andi.w	#$F,d0
		move.b	d0,objoff_3E(a0)
		move.b	d0,objoff_3F(a0)

Obj0C_Main:
		move.b	objoff_3C(a0),d0
		beq.s	loc_1438C
		cmpi.b	#$80,d0
		bne.s	loc_1439C
		move.b	objoff_3D(a0),d1
		bne.s	loc_1436E
		subq.b	#1,objoff_3E(a0)
		bpl.s	loc_1436E
		move.b	objoff_3F(a0),objoff_3E(a0)
		bra.s	loc_1439C
; ---------------------------------------------------------------------------

loc_1436E:
		addq.b	#1,objoff_3D(a0)
		move.b	d1,d0
		bsr.w	j_CalcSine
		addi.w	#8,d0
		asr.w	#6,d0
		subi.w	#$10,d0
		add.w	objoff_3A(a0),d0
		move.w	d0,obY(a0)
		bra.s	loc_143B2
; ---------------------------------------------------------------------------

loc_1438C:
		move.w	(Vint_runcount+2).w,d1
		andi.w	#$3FF,d1
		bne.s	loc_143A0
		move.b	#1,objoff_3D(a0)

loc_1439C:
		addq.b	#1,objoff_3C(a0)

loc_143A0:
		bsr.w	j_CalcSine
		addi.w	#8,d1
		asr.w	#4,d1
		add.w	objoff_3A(a0),d1
		move.w	d1,obY(a0)

loc_143B2:
		moveq	#0,d1
		move.b	obActWid(a0),d1
		moveq	#9,d3
		move.w	obX(a0),d4
		bsr.w	sub_F78A
		bra.w	MarkObjGone