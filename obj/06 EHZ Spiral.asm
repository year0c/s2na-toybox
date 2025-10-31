;----------------------------------------------------
; Object 06 - spiral loop in EHZ
;----------------------------------------------------

Obj06:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj06_Index(pc,d0.w),d1
		jsr	Obj06_Index(pc,d1.w)
		tst.w	(Two_player_mode).w
		beq.s	loc_14986
		rts
; ---------------------------------------------------------------------------

loc_14986:
		out_of_range.s	loc_1499A
		rts
; ---------------------------------------------------------------------------

loc_1499A:
		jmp	(DeleteObject).l
; ---------------------------------------------------------------------------
Obj06_Index:	dc.w Obj06_Init-Obj06_Index
		dc.w Obj06_Main-Obj06_Index
; ---------------------------------------------------------------------------

Obj06_Init:
		addq.b	#2,obRoutine(a0)
		move.b	#$D0,obActWid(a0)

Obj06_Main:
		lea	(v_player).w,a1
		moveq	#3,d6
		bsr.s	sub_149BC
		lea	(v_player2).w,a1
		addq.b	#1,d6

; =============== S U B	R O U T	I N E =======================================


sub_149BC:
		btst	d6,obStatus(a0)
		bne.w	loc_14A56
		btst	#1,obStatus(a1)
		bne.w	locret_14A54
		btst	#3,obStatus(a1)
		bne.s	loc_14A16
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		tst.w	obVelX(a1)
		bmi.s	loc_149F2
		cmpi.w	#-$C0,d0
		bgt.s	locret_14A54
		cmpi.w	#-$D0,d0
		blt.s	locret_14A54
		bra.s	loc_149FE
; ---------------------------------------------------------------------------

loc_149F2:
		cmpi.w	#$C0,d0
		blt.s	locret_14A54
		cmpi.w	#$D0,d0
		bgt.s	locret_14A54

loc_149FE:
		move.w	obY(a1),d1
		sub.w	obY(a0),d1
		subi.w	#$10,d1
		cmpi.w	#$30,d1
		bcc.s	locret_14A54
		bsr.w	RideObject_SetRide
		rts
; ---------------------------------------------------------------------------

loc_14A16:
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		tst.w	obVelX(a1)
		bmi.s	loc_14A32
		cmpi.w	#-$B0,d0
		bgt.s	locret_14A54
		cmpi.w	#-$C0,d0
		blt.s	locret_14A54
		bra.s	loc_14A3E
; ---------------------------------------------------------------------------

loc_14A32:
		cmpi.w	#$B0,d0
		blt.s	locret_14A54
		cmpi.w	#$C0,d0
		bgt.s	locret_14A54

loc_14A3E:
		move.w	obY(a1),d1
		sub.w	obY(a0),d1
		subi.w	#$10,d1
		cmpi.w	#$30,d1
		bcc.s	locret_14A54
		bsr.w	RideObject_SetRide

locret_14A54:
		rts
; ---------------------------------------------------------------------------

loc_14A56:
		move.w	obInertia(a1),d0
		bpl.s	loc_14A5E
		neg.w	d0

loc_14A5E:
		cmpi.w	#$600,d0
		bcs.s	loc_14A80
		btst	#1,obStatus(a1)
		bne.s	loc_14A80
		move.w	obX(a1),d0
		sub.w	obX(a0),d0
		addi.w	#$D0,d0
		bmi.s	loc_14A80
		cmpi.w	#$1A0,d0
		bcs.s	loc_14A98

loc_14A80:
		bclr	#3,obStatus(a1)
		bclr	d6,obStatus(a0)
		move.b	#0,objoff_2C(a1)
		move.b	#4,objoff_2D(a1)
		rts
; ---------------------------------------------------------------------------

loc_14A98:
		btst	#3,obStatus(a1)
		beq.s	locret_14A54
		move.b	Obj06_PlayerDeltaYArray(pc,d0.w),d1
		ext.w	d1
		move.w	obY(a0),d2
		add.w	d1,d2
		moveq	#0,d1
		move.b	obHeight(a1),d1
		subi.w	#$13,d1
		sub.w	d1,d2
		move.w	d2,obY(a1)
		lsr.w	#3,d0
		andi.w	#$3F,d0
		move.b	Obj06_PlayerAngleArray(pc,d0.w),objoff_27(a1)
		rts
; End of function sub_149BC