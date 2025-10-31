;----------------------------------------------------
; Sonic	1 Object 20 - leftover object for the
;  ball	that S1	Ballhog	throws
;----------------------------------------------------

S1Obj20:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	S1Obj20_Index(pc,d0.w),d1
		jmp	S1Obj20_Index(pc,d1.w)
; ---------------------------------------------------------------------------
S1Obj20_Index:	dc.w loc_9742-S1Obj20_Index
		dc.w loc_978A-S1Obj20_Index
; ---------------------------------------------------------------------------

loc_9742:
		addq.b	#2,obRoutine(a0)
		move.b	#7,obHeight(a0)
		move.l	#Map_S1Obj1E,obMap(a0)
		move.w	#make_art_tile($302,1,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#$87,obColType(a0)
		move.b	#8,obActWid(a0)
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		mulu.w	#60,d0
		move.w	d0,objoff_30(a0)
		move.b	#4,obFrame(a0)

loc_978A:
		jsr	(ObjectMoveAndFall).l
		tst.w	obVelY(a0)
		bmi.s	loc_97C6
		jsr	(ObjHitFloor).l
		tst.w	d1
		bpl.s	loc_97C6
		add.w	d1,obY(a0)
		move.w	#-$300,obVelY(a0)
		tst.b	d3
		beq.s	loc_97C6
		bmi.s	loc_97BC
		tst.w	obVelX(a0)
		bpl.s	loc_97C6
		neg.w	obVelX(a0)
		bra.s	loc_97C6
; ---------------------------------------------------------------------------

loc_97BC:
		tst.w	obVelX(a0)
		bmi.s	loc_97C6
		neg.w	obVelX(a0)

loc_97C6:
		subq.w	#1,objoff_30(a0)
		bpl.s	loc_97E2
		_move.b	#id_Obj24,obID(a0)
		_move.b	#id_Obj3F,obID(a0)
		move.b	#0,obRoutine(a0)
		bra.w	Obj3F				; explosion object
; ---------------------------------------------------------------------------

loc_97E2:
		subq.b	#1,obTimeFrame(a0)
		bpl.s	loc_97F4
		move.b	#5,obTimeFrame(a0)
		bchg	#0,obFrame(a0)

loc_97F4:
		move.w	(Camera_Max_Y_pos).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0
		bcs.w	DeleteObject
		bra.w	DisplaySprite