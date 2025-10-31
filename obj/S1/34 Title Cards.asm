;----------------------------------------------------
; Object 34 - leftover Sonic 1 title cards
;----------------------------------------------------

Obj34:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj34_Index(pc,d0.w),d1
		jmp	Obj34_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj34_Index:	dc.w Obj34_CheckLZ4-Obj34_Index
		dc.w Obj34_CheckPos-Obj34_Index
		dc.w Obj34_Wait-Obj34_Index
		dc.w Obj34_Wait-Obj34_Index
; ---------------------------------------------------------------------------

Obj34_CheckLZ4:
		movea.l	a0,a1
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		cmpi.w	#(id_LZ<<8)+3,(Current_ZoneAndAct).w
		bne.s	Obj34_CheckFZ
		moveq	#5,d0

Obj34_CheckFZ:
		move.w	d0,d2
		cmpi.w	#(id_SBZ<<8)+2,(Current_ZoneAndAct).w
		bne.s	Obj34_CheckConfig
		moveq	#6,d0
		moveq	#$B,d2

Obj34_CheckConfig:
		lea	(Obj34_Config).l,a3
		lsl.w	#4,d0
		adda.w	d0,a3
		lea	(Obj34_ItemData).l,a2
		moveq	#3,d1

Obj34_Loop:
		_move.b	#id_Obj34,obID(a1)
		move.w	(a3),obX(a1)
		move.w	(a3)+,objoff_32(a1)
		move.w	(a3)+,objoff_30(a1)
		move.w	(a2)+,obScreenY(a1)
		move.b	(a2)+,obRoutine(a1)
		move.b	(a2)+,d0
		bne.s	Obj34_ActNumber
		move.b	d2,d0

Obj34_ActNumber:
		cmpi.b	#7,d0
		bne.s	Obj34_MakeSprite
		add.b	(Current_Act).w,d0
		cmpi.b	#3,(Current_Act).w
		bne.s	Obj34_MakeSprite
		subq.b	#1,d0

Obj34_MakeSprite:
		move.b	d0,obFrame(a1)
		move.l	#Map_Obj34,obMap(a1)
		move.w	#make_art_tile(ArtTile_Title_Card,0,1),obGfx(a1)
		bsr.w	Adjust2PArtPointer2
		move.b	#$78,obActWid(a1)
		move.b	#0,obRender(a1)
		move.b	#0,obPriority(a1)
		move.w	#60,obTimeFrame(a1)
		lea	object_size(a1),a1
		dbf	d1,Obj34_Loop

Obj34_CheckPos:
		moveq	#$10,d1
		move.w	objoff_30(a0),d0
		cmp.w	obX(a0),d0
		beq.s	loc_B98E
		bge.s	Obj34_Move
		neg.w	d1

Obj34_Move:
		add.w	d1,obX(a0)

loc_B98E:
		move.w	obX(a0),d0
		bmi.s	Obj34_NoDisplay
		cmpi.w	#$200,d0
		bcc.s	Obj34_NoDisplay
; remove the rts below to restore the display code from Sonic 1.
		rts
; ---------------------------------------------------------------------------
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

Obj34_NoDisplay:
		rts
; ---------------------------------------------------------------------------

Obj34_Wait:
		tst.w	obTimeFrame(a0)
		beq.s	Obj34_CheckPos2
		subq.w	#1,obTimeFrame(a0)
; remove the rts below to restore the display code from Sonic 1.
		rts
; ---------------------------------------------------------------------------
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

Obj34_CheckPos2:
		tst.b	obRender(a0)
		bpl.s	Obj34_ChangeArt
		moveq	#$20,d1
		move.w	objoff_32(a0),d0
		cmp.w	obX(a0),d0
		beq.s	Obj34_ChangeArt
		bge.s	Obj34_Move2
		neg.w	d1

Obj34_Move2:
		add.w	d1,obX(a0)
		move.w	obX(a0),d0
		bmi.s	Obj34_NoDisplay2
		cmpi.w	#$200,d0
		bcc.s	Obj34_NoDisplay2
; remove the rts below to restore the display code from Sonic 1.
		rts
; ---------------------------------------------------------------------------
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

Obj34_NoDisplay2:
		rts
; ---------------------------------------------------------------------------

Obj34_ChangeArt:
		cmpi.b	#4,obRoutine(a0)
		bne.s	Obj34_Delete
		moveq	#plcid_Explode,d0
		jsr	(LoadPLC).l
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		addi.w	#plcid_GHZAnimals,d0
		jsr	(LoadPLC).l

Obj34_Delete:
		bra.w	DeleteObject
; ---------------------------------------------------------------------------
Obj34_ItemData:	dc.w $D0
		dc.b   2,  0
		dc.w $E4
		dc.b   2,  6
		dc.w $EA
		dc.b   2,  7
		dc.w $E0
		dc.b   2, $A
Obj34_Config:	dc.w	 0, $120,$FEFC,	$13C, $414, $154, $214,	$154
		dc.w	 0, $120,$FEF4,	$134, $40C, $14C, $20C,	$14C
		dc.w	 0, $120,$FEE0,	$120, $3F8, $138, $1F8,	$138
		dc.w	 0, $120,$FEFC,	$13C, $414, $154, $214,	$154
		dc.w	 0, $120,$FF04,	$144, $41C, $15C, $21C,	$15C
		dc.w	 0, $120,$FF04,	$144, $41C, $15C, $21C,	$15C
		dc.w	 0, $120,$FEE4,	$124, $3EC, $3EC, $1EC,	$12C