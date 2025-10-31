; ---------------------------------------------------------------------------
; Object 0D - End of level signpost
; ---------------------------------------------------------------------------

Obj0D:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj0D_Index(pc,d0.w),d1
		jsr	Obj0D_Index(pc,d1.w)
		lea	(Ani_obj0D).l,a1
		bsr.w	AnimateSprite
		out_of_range.w	DeleteObject
		bra.w	DisplaySprite
; ===========================================================================
Obj0D_Index:	dc.w Obj0D_Init-Obj0D_Index
		dc.w Obj0D_Main-Obj0D_Index
		dc.w Obj0D_Spin-Obj0D_Index
		dc.w Obj0D_EndLevel-Obj0D_Index
		dc.w locret_F18A-Obj0D_Index
; ===========================================================================
; loc_EFD6:
Obj0D_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_obj0D,obMap(a0)
		move.w	#make_art_tile(ArtTile_Signpost,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#$18,obActWid(a0)
		move.b	#4,obPriority(a0)
; loc_EFFE:
Obj0D_Main:
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		blo.s	locret_F026
		cmpi.w	#32,d0
		bhs.s	locret_F026
		move.w	#sfx_Signpost,d0
		jsr	(PlaySound).l
		clr.b	(f_timecount).w
		move.w	(Camera_Max_X_pos).w,(Camera_Min_X_pos).w
		addq.b	#2,obRoutine(a0)

locret_F026:
		rts
; ===========================================================================
; loc_F028:
Obj0D_Spin:
		subq.w	#1,objoff_30(a0)
		bpl.s	Obj0D_Sparkle
		move.w	#60,objoff_30(a0)
		addq.b	#1,obAnim(a0)
		cmpi.b	#3,obAnim(a0)
		bne.s	Obj0D_Sparkle
		addq.b	#2,obRoutine(a0)
; loc_F044:
Obj0D_Sparkle:
		subq.w	#1,objoff_32(a0)
		bpl.s	locret_F0B2
		move.w	#12-1,objoff_32(a0)
		moveq	#0,d0
		move.b	objoff_34(a0),d0
		addq.b	#2,objoff_34(a0)
		andi.b	#$E,objoff_34(a0)
		lea	Obj0D_RingSparklePositions(pc,d0.w),a2
		bsr.w	FindFreeObj
		bne.s	locret_F0B2
		_move.b	#id_Obj25,obID(a1)
		move.b	#6,obRoutine(a1)
		move.b	(a2)+,d0
		ext.w	d0
		add.w	obX(a0),d0
		move.w	d0,obX(a1)
		move.b	(a2)+,d0
		ext.w	d0
		add.w	obY(a0),d0
		move.w	d0,obY(a1)
		move.l	#Map_Ring,obMap(a1)
		move.w	#make_art_tile(ArtTile_S1_Ring,1,0),obGfx(a1)
		bsr.w	Adjust2PArtPointer2
		move.b	#4,obRender(a1)
		move.b	#2,obPriority(a1)
		move.b	#8,obActWid(a1)

locret_F0B2:
		rts
; ===========================================================================
; dword_F0B4:
Obj0D_RingSparklePositions:
		dc.b -$18,-$10		; x-position, y-position
		dc.b	8,   8
		dc.b -$10,   0
		dc.b  $18,  -8
		dc.b	0,  -8
		dc.b  $10,   0
		dc.b -$18,   8
		dc.b  $18, $10
; ===========================================================================
; loc_F0C4:
Obj0D_EndLevel:
		tst.w	(Debug_placement_mode).w
		bne.w	locret_F15E
		btst	#1,(v_player+obStatus).w
		bne.s	loc_F0E0
		move.b	#1,(f_lockctrl).w
		move.w	#8<<btnR,(v_jpadhold2).w

loc_F0E0:
		; This check here is for S1's Big Ring, which would set Sonic's Object ID to 0
		tst.b	(v_player).w
		beq.s	loc_F0F6
		move.w	(v_player+obX).w,d0
		move.w	(Camera_Max_X_pos).w,d1
		addi.w	#320-24,d1
		cmp.w	d1,d0
		bcs.s	locret_F15E

loc_F0F6:
		addq.b	#2,obRoutine(a0)

; ---------------------------------------------------------------------------
; Subroutine to load the end of act results screen
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; GotThroughAct:
Load_EndOfAct:
		tst.b	(v_endcard).w
		bne.s	locret_F15E
		move.w	(Camera_Max_X_pos).w,(Camera_Min_X_pos).w
		clr.b	(v_invinc).w
		clr.b	(f_timecount).w
		move.b	#id_Obj3A,(v_endcard).w
		moveq	#plcid_TitleCard,d0
		jsr	(NewPLC).l
		move.b	#1,(f_endactbonus).w
		moveq	#0,d0
		move.b	(v_timemin).w,d0
		mulu.w	#60,d0
		moveq	#0,d1
		move.b	(v_timesec).w,d1
		add.w	d1,d0
		divu.w	#15,d0
		moveq	#$14,d1
		cmp.w	d1,d0
		blo.s	loc_F140
		move.w	d1,d0

loc_F140:
		add.w	d0,d0
		move.w	TimeBonuses(pc,d0.w),(v_timebonus).w
		move.w	(v_rings).w,d0
		mulu.w	#10,d0
		move.w	d0,(v_ringbonus).w
		move.w	#bgm_GotThrough,d0
		jsr	(PlaySound_Special).l

locret_F15E:
		rts
; End of function Load_EndOfAct

; ===========================================================================
; word_F160:
TimeBonuses:	dc.w  5000, 5000, 1000,	 500
		dc.w   400,  400,  300,	 300
		dc.w   200,  200,  200,	 200
		dc.w   100,  100,  100,	 100
		dc.w	50,   50,   50,	  50
		dc.w	0
; ===========================================================================

locret_F18A:
		rts