; =============== S U B	R O U T	I N E =======================================

; Sonic_AnglePos:
AnglePos:
		move.l	#v_colladdr1,(Collision_addr).w
		cmpi.b	#$C,top_solid_bit(a0)
		beq.s	loc_12A14
		move.l	#v_colladdr2,(Collision_addr).w

loc_12A14:
		move.b	top_solid_bit(a0),d5
		btst	#3,obStatus(a0)
		beq.s	loc_12A2C
		moveq	#0,d0
		move.b	d0,(Primary_Angle).w
		move.b	d0,(Secondary_Angle).w
		rts
; ---------------------------------------------------------------------------

loc_12A2C:
		moveq	#3,d0
		move.b	d0,(Primary_Angle).w
		move.b	d0,(Secondary_Angle).w
		move.b	obAngle(a0),d0
		addi.b	#$20,d0
		bpl.s	loc_12A4E
		move.b	obAngle(a0),d0
		bpl.s	loc_12A48
		subq.b	#1,d0

loc_12A48:
		addi.b	#$20,d0
		bra.s	loc_12A5A
; ---------------------------------------------------------------------------

loc_12A4E:
		move.b	obAngle(a0),d0
		bpl.s	loc_12A56
		addq.b	#1,d0

loc_12A56:
		addi.b	#$1F,d0

loc_12A5A:
		andi.b	#$C0,d0
		cmpi.b	#$40,d0
		beq.w	Sonic_WalkVertL
		cmpi.b	#$80,d0
		beq.w	Sonic_WalkCeiling
		cmpi.b	#$C0,d0
		beq.w	Sonic_WalkVertR
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(Primary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindFloor
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		neg.w	d0
		add.w	d0,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindFloor
		move.w	(sp)+,d0
		bsr.w	Sonic_Angle
		tst.w	d1
		beq.s	locret_12AE4
		bpl.s	loc_12AE6
		cmpi.w	#-$E,d1
		blt.s	locret_12B0C
		add.w	d1,obY(a0)

locret_12AE4:
		rts
; ---------------------------------------------------------------------------

loc_12AE6:
		cmpi.w	#$E,d1
		bgt.s	loc_12AF2

loc_12AEC:
		add.w	d1,obY(a0)
		rts
; ---------------------------------------------------------------------------

loc_12AF2:
		tst.b	sticktoconvex(a0)
		bne.s	loc_12AEC
		bset	#1,obStatus(a0)
		bclr	#5,obStatus(a0)
		move.b	#1,obPrevAni(a0)
		rts
; ---------------------------------------------------------------------------

locret_12B0C:
		rts
; End of function AnglePos

; ---------------------------------------------------------------------------
		move.l	obX(a0),d2
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,d2
		move.l	d2,obX(a0)
		move.w	#$38,d0
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,d3
		move.l	d3,obY(a0)
		rts
; ---------------------------------------------------------------------------

locret_12B30:
		rts
; ---------------------------------------------------------------------------
		move.l	obY(a0),d3
		move.w	obVelY(a0),d0
		subi.w	#$38,d0
		move.w	d0,obVelY(a0)
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,d3
		move.l	d3,obY(a0)
		rts
; ---------------------------------------------------------------------------
		rts
; ---------------------------------------------------------------------------
		move.l	obX(a0),d2
		move.l	obY(a0),d3
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,d2
		move.w	obVelY(a0),d0
		ext.l	d0
		asl.l	#8,d0
		sub.l	d0,d3
		move.l	d2,obX(a0)
		move.l	d3,obY(a0)
		rts

; =============== S U B	R O U T	I N E =======================================


Sonic_Angle:
		move.b	(Secondary_Angle).w,d2
		cmp.w	d0,d1
		ble.s	loc_12B84
		move.b	(Primary_Angle).w,d2
		move.w	d0,d1

loc_12B84:
		btst	#0,d2
		bne.s	loc_12B90
		move.b	d2,obAngle(a0)
		rts
; ---------------------------------------------------------------------------

loc_12B90:
		move.b	obAngle(a0),d2
		addi.b	#$20,d2
		andi.b	#$C0,d2
		move.b	d2,obAngle(a0)
		rts
; End of function Sonic_Angle

; ---------------------------------------------------------------------------

Sonic_WalkVertR:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		neg.w	d0
		add.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(Primary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindWall
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#$10,a3
		move.w	#0,d6
		bsr.w	FindWall
		move.w	(sp)+,d0
		bsr.w	Sonic_Angle
		tst.w	d1
		beq.s	locret_12C12
		bpl.s	loc_12C14
		cmpi.w	#-$E,d1
		blt.w	locret_12B30
		add.w	d1,obX(a0)

locret_12C12:
		rts
; ---------------------------------------------------------------------------

loc_12C14:
		cmpi.w	#$E,d1
		bgt.s	loc_12C20

loc_12C1A:
		add.w	d1,obX(a0)
		rts
; ---------------------------------------------------------------------------

loc_12C20:
		tst.b	sticktoconvex(a0)
		bne.s	loc_12C1A
		bset	#1,obStatus(a0)
		bclr	#5,obStatus(a0)
		move.b	#1,obPrevAni(a0)
		rts
; ---------------------------------------------------------------------------

Sonic_WalkCeiling:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d3
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		bsr.w	FindFloor
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d2
		eori.w	#$F,d2
		move.b	obWidth(a0),d0
		ext.w	d0
		sub.w	d0,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$800,d6
		bsr.w	FindFloor
		move.w	(sp)+,d0
		bsr.w	Sonic_Angle
		tst.w	d1
		beq.s	locret_12CB0
		bpl.s	loc_12CB2
		cmpi.w	#-$E,d1
		blt.w	locret_12B0C
		sub.w	d1,obY(a0)

locret_12CB0:
		rts
; ---------------------------------------------------------------------------

loc_12CB2:
		cmpi.w	#$E,d1
		bgt.s	loc_12CBE

loc_12CB8:
		sub.w	d1,obY(a0)
		rts
; ---------------------------------------------------------------------------

loc_12CBE:
		tst.b	sticktoconvex(a0)
		bne.s	loc_12CB8
		bset	#1,obStatus(a0)
		bclr	#5,obStatus(a0)
		move.b	#1,obPrevAni(a0)
		rts
; ---------------------------------------------------------------------------

Sonic_WalkVertL:
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		sub.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	(Primary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6
		bsr.w	FindWall
		move.w	d1,-(sp)
		move.w	obY(a0),d2
		move.w	obX(a0),d3
		moveq	#0,d0
		move.b	obWidth(a0),d0
		ext.w	d0
		add.w	d0,d2
		move.b	obHeight(a0),d0
		ext.w	d0
		sub.w	d0,d3
		eori.w	#$F,d3
		lea	(Secondary_Angle).w,a4
		movea.w	#-$10,a3
		move.w	#$400,d6
		bsr.w	FindWall
		move.w	(sp)+,d0
		bsr.w	Sonic_Angle
		tst.w	d1
		beq.s	locret_12D4E
		bpl.s	loc_12D50
		cmpi.w	#-$E,d1
		blt.w	locret_12B30
		sub.w	d1,obX(a0)

locret_12D4E:
		rts
; ---------------------------------------------------------------------------

loc_12D50:
		cmpi.w	#$E,d1
		bgt.s	loc_12D5C

loc_12D56:
		sub.w	d1,obX(a0)
		rts
; ---------------------------------------------------------------------------

loc_12D5C:
		tst.b	sticktoconvex(a0)
		bne.s	loc_12D56
		bset	#1,obStatus(a0)
		bclr	#5,obStatus(a0)
		move.b	#1,obPrevAni(a0)
		rts