; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

FindWall:
		bsr.w	FindNearestTile
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$3FF,d0
		beq.s	loc_12EFA
		btst	d5,d4
		bne.s	loc_12F08

loc_12EFA:
		add.w	a3,d3
		bsr.w	FindWall2
		sub.w	a3,d3
		addi.w	#$10,d1
		rts
; ===========================================================================

loc_12F08:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.w	(a2,d0.w),d0
		beq.s	loc_12EFA
		lea	(AngleMap).l,a2
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d2,d1
		btst	#$B,d4
		beq.s	loc_12F34
		not.w	d1
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

loc_12F34:
		btst	#$A,d4
		beq.s	loc_12F3A
		neg.b	(a4)

loc_12F3A:
		andi.w	#$F,d1
		add.w	d0,d1
		lea	(CollArray2).l,a2
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$A,d4
		beq.s	loc_12F58
		neg.w	d0

loc_12F58:
		tst.w	d0
		beq.s	loc_12EFA
		bmi.s	loc_12F74
		cmpi.b	#$10,d0
		beq.s	loc_12F80
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ===========================================================================

loc_12F74:
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_12EFA

loc_12F80:
		sub.w	a3,d3
		bsr.w	FindWall2
		add.w	a3,d3
		subi.w	#$10,d1
		rts
; End of function FindWall

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

FindWall2:
		bsr.w	FindNearestTile
		move.w	(a1),d0
		move.w	d0,d4
		andi.w	#$3FF,d0
		beq.s	loc_12FA0
		btst	d5,d4
		bne.s	loc_12FAE

loc_12FA0:
		move.w	#$F,d1
		move.w	d3,d0
		andi.w	#$F,d0
		sub.w	d0,d1
		rts
; ===========================================================================

loc_12FAE:
		movea.l	(Collision_addr).w,a2
		add.w	d0,d0
		move.w	(a2,d0.w),d0
		beq.s	loc_12FA0
		lea	(AngleMap).l,a2
		move.b	(a2,d0.w),(a4)
		lsl.w	#4,d0
		move.w	d2,d1
		btst	#$B,d4
		beq.s	loc_12FDA
		not.w	d1
		addi.b	#$40,(a4)
		neg.b	(a4)
		subi.b	#$40,(a4)

loc_12FDA:
		btst	#$A,d4
		beq.s	loc_12FE2
		neg.b	(a4)

loc_12FE2:
		andi.w	#$F,d1
		add.w	d0,d1
		lea	(CollArray2).l,a2
		move.b	(a2,d1.w),d0
		ext.w	d0
		eor.w	d6,d4
		btst	#$A,d4
		beq.s	loc_12FFE
		neg.w	d0

loc_12FFE:
		tst.w	d0
		beq.s	loc_12FA0
		bmi.s	loc_13014
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		move.w	#$F,d1
		sub.w	d0,d1
		rts
; ===========================================================================

loc_13014:
		move.w	d3,d1
		andi.w	#$F,d1
		add.w	d1,d0
		bpl.w	loc_12FA0
		not.w	d1
		rts
; End of function FindWall2