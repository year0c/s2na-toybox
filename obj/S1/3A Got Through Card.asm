; ---------------------------------------------------------------------------
; Object 3A - End of level results screen
; ---------------------------------------------------------------------------

Obj3A:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj3A_Index(pc,d0.w),d1
		jmp	Obj3A_Index(pc,d1.w)
; ===========================================================================
Obj3A_Index:	dc.w Obj3A_ChkPLC-Obj3A_Index
		dc.w Obj3A_ChkPos-Obj3A_Index
		dc.w Obj3A_Wait-Obj3A_Index
; uncomment the lines below to restore the Sonic 1 functions.
;		dc.w Obj3A_TimeBonus-Obj3A_Index
;		dc.w Obj3A_Wait-Obj3A_Index
		dc.w Obj3A_NextLevel-Obj3A_Index
;		dc.w Obj3A_Wait-Obj3A_Index
;		dc.w Obj3A_Move2-Obj3A_Index
;		dc.w loc_BD3A-Obj3A_Index
; ===========================================================================
; loc_BB5C:
Obj3A_ChkPLC:
		tst.l	(v_plc_buffer).w
		beq.s	Obj3A_Config
		rts
; ---------------------------------------------------------------------------
; loc_BB64:
Obj3A_Config:
		movea.l	a0,a1
		lea	(Obj3A_Conf).l,a2
		moveq	#6,d1
; loc_BB6E:
Obj3A_Init:
		_move.b	#id_Obj3A,obID(a1)
		move.w	(a2),obX(a1)
		move.w	(a2)+,objoff_32(a1)
		move.w	(a2)+,objoff_30(a1)
		move.w	(a2)+,obScreenY(a1)
		move.b	(a2)+,obRoutine(a1)
		move.b	(a2)+,d0
		cmpi.b	#6,d0
		bne.s	loc_BB94
		add.b	(Current_Act).w,d0

loc_BB94:
		move.b	d0,obFrame(a1)
		move.l	#Map_Obj3A,obMap(a1)
		move.w	#make_art_tile(ArtTile_Title_Card,0,1),obGfx(a1)
		bsr.w	Adjust2PArtPointer2
		move.b	#0,obRender(a1)
		lea	object_size(a1),a1
		dbf	d1,Obj3A_Init
; loc_BBB8:
Obj3A_ChkPos:
		moveq	#$10,d1
		move.w	objoff_30(a0),d0
		cmp.w	obX(a0),d0
		beq.s	loc_BBEA
		bge.s	Obj3A_Move
		neg.w	d1
; loc_BBC8:
Obj3A_Move
		add.w	d1,obX(a0)

loc_BBCC:
		move.w	obX(a0),d0
		bmi.s	locret_BBDE
		cmpi.w	#$200,d0
		bcc.s	locret_BBDE
; remove the rts below to restore the display code from Sonic 1.
		rts
; ---------------------------------------------------------------------------
		bra.w	DisplaySprite
; ===========================================================================

locret_BBDE:
		rts
; ===========================================================================

loc_BBE0:
		move.b	#$E,obRoutine(a0)
		bra.w	Obj3A_Move2
; ===========================================================================

loc_BBEA:
		cmpi.b	#$E,(v_endcardring+obRoutine).w
		beq.s	loc_BBE0
		cmpi.b	#4,obFrame(a0)
		bne.s	loc_BBCC
		addq.b	#2,obRoutine(a0)
		move.w	#180,obTimeFrame(a0)
; loc_BC04:
Obj3A_Wait:
		subq.w	#1,obTimeFrame(a0)
		bne.s	locret_BC0E
		addq.b	#2,obRoutine(a0)

locret_BC0E:
; remove the rts below to restore the display code from Sonic 1.
		rts
; ---------------------------------------------------------------------------
		bra.w	DisplaySprite
; ===========================================================================
; Obj3A_TimeBonus:
		bsr.w	DisplaySprite
		move.b	#1,(f_endactbonus).w
		moveq	#0,d0
		tst.w	(v_timebonus).w
		beq.s	Obj3A_RingBonus
		addi.w	#10,d0
		subi.w	#10,(v_timebonus).w
; loc_BC30:
Obj3A_RingBonus:
		tst.w	(v_ringbonus).w
		beq.s	Obj3A_ChkBonus
		addi.w	#10,d0
		subi.w	#10,(v_ringbonus).w
; loc_BC40:
Obj3A_ChkBonus:
		tst.w	d0
		bne.s	Obj3A_AddBonus
		move.w	#sfx_Cash,d0
		jsr	(PlaySound_Special).l
		addq.b	#2,obRoutine(a0)
		cmpi.w	#(id_SBZ<<8)+1,(Current_ZoneAndAct).w
		bne.s	Obj3A_SetDelay
		addq.b	#4,obRoutine(a0)
; loc_BC5E:
Obj3A_SetDelay:
		move.w	#180,obTimeFrame(a0)

locret_BC64:
		rts
; ===========================================================================
; loc_BC66:
Obj3A_AddBonus:
		jsr	(AddPoints).l
		move.b	(Vint_runcount+3).w,d0
		andi.b	#3,d0
		bne.s	locret_BC64
		move.w	#sfx_Switch,d0
		jmp	(PlaySound_Special).l
; ===========================================================================
; loc_BC80:
Obj3A_NextLevel:
		move.b	(Current_Zone).w,d0
		andi.w	#7,d0
		lsl.w	#3,d0
		move.b	(Current_Act).w,d1
		andi.w	#3,d1
		add.w	d1,d1
		add.w	d1,d0
		move.w	LevelOrder(pc,d0.w),d0
		move.w	d0,(Current_ZoneAndAct).w
		tst.w	d0
		bne.s	Obj3A_ChkSS
		move.b	#GameModeID_SegaScreen,(v_gamemode).w
		bra.s	locret_BCC2
; ===========================================================================
; loc_BCAA:
Obj3A_ChkSS:
		clr.b	(v_lastlamp).w
		tst.b	(f_bigring).w
		beq.s	loc_BCBC
		move.b	#GameModeID_SpecialStage,(v_gamemode).w
		bra.s	locret_BCC2
; ===========================================================================

loc_BCBC:
		move.w	#1,(Level_Inactive_flag).w

locret_BCC2:
; remove the rts below to restore the display code from Sonic 1.
		rts
; ---------------------------------------------------------------------------
		bra.w	DisplaySprite
; ===========================================================================
LevelOrder:
		; Green Hill Zone
		dc.b id_GHZ, 1	; Act 1
		dc.b id_GHZ, 2	; Act 2
		dc.b id_MZ, 0	; Act 3
		dc.b 0, 0

		; Labyrinth Zone
		dc.b id_LZ, 1	; Act 1
		dc.b id_LZ, 2	; Act 2
		dc.b id_SLZ, 0	; Act 3
		dc.b id_SBZ, 2	; Scrap Brain Zone Act 3

		; Marble Zone
		dc.b id_MZ, 1	; Act 1
		dc.b id_MZ, 2	; Act 2
		dc.b id_SYZ, 0	; Act 3
		dc.b 0, 0

		; Star Light Zone
		dc.b id_SLZ, 1	; Act 1
		dc.b id_SLZ, 2	; Act 2
		dc.b id_SBZ, 0	; Act 3
		dc.b 0, 0

		; Spring Yard Zone
		dc.b id_SYZ, 1	; Act 1
		dc.b id_SYZ, 2	; Act 2
		dc.b id_LZ, 0	; Act 3
		dc.b 0, 0

		; Scrap Brain Zone
		dc.b id_SBZ, 1	; Act 1
		dc.b id_LZ, 3	; Act 2
		dc.b 0, 0	; Final Zone
		dc.b 0, 0
		even
; ---------------------------------------------------------------------------

Obj3A_Move2:
		moveq	#$20,d1
		move.w	objoff_32(a0),d0
		cmp.w	obX(a0),d0
		beq.s	Obj3A_SBZ2
		bge.s	Obj3A_ChgPos2
		neg.w	d1

Obj3A_ChgPos2:
		add.w	d1,obX(a0)
		move.w	obX(a0),d0
		bmi.s	locret_BD1C
		cmpi.w	#$200,d0
		bcc.s	locret_BD1C
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

locret_BD1C:
		rts
; ---------------------------------------------------------------------------

Obj3A_SBZ2:
		cmpi.b	#4,obFrame(a0)
		bne.w	DeleteObject
		addq.b	#2,obRoutine(a0)
		clr.b	(f_lockctrl).w
		move.w	#bgm_FZ,d0
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------

; loc_BD3A:	; Routine $10
		addq.w	#2,(Camera_Max_X_pos).w
		cmpi.w	#$2100,(Camera_Max_X_pos).w
		beq.w	DeleteObject
		rts
; ---------------------------------------------------------------------------
Obj3A_Conf:	dc.w	 4, $124,  $BC,	$200
		dc.w $FEE0, $120,  $D0,	$201
		dc.w  $40C, $14C,  $D6,	$206
		dc.w  $520, $120,  $EC,	$202
		dc.w  $540, $120,  $FC,	$203
		dc.w  $560, $120, $10C,	$204
		dc.w  $20C, $14C,  $CC,	$205