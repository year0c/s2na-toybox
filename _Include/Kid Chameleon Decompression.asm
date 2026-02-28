; ---------------------------------------------------------------------------
; Kid Chameleon decompression algorithm
; LZSS/dictionary-based, uses unrolling for fast decompression speeds

; ARGUMENTS:
; a0 = starting address
; a1 = starting art tile
; a2 = destination address
; a3 = end of destination address

; What's interesting about this is that a3 gets moved to d7 and a3 is never used again.
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||


KC_Dec:
		moveq	#0,d0
		move.w	#$7FF,d4
		moveq	#0,d5
		moveq	#0,d6
		move.w	a3,d7
		subq.w	#1,d2
		beq.w	loc_1DCC
		subq.w	#1,d2
		beq.w	loc_1D4E
		subq.w	#1,d2
		beq.w	loc_1CD0
		subq.w	#1,d2
		beq.w	loc_1C52
		subq.w	#1,d2
		beq.w	loc_1BD6
		subq.w	#1,d2
		beq.w	loc_1B58
		subq.w	#1,d2
		beq.w	loc_1ADE

loc_1A62:
		move.b	(a0)+,d1
		add.b	d1,d1
		bcs.s	loc_1ADC
		movea.l	a2,a6
		add.b	d1,d1
		bcs.s	loc_1A84
		move.b	(a1)+,d5
		suba.l	d5,a6
		add.b	d1,d1
		bhs.s	loc_1A78
		move.b	(a6)+,(a2)+

loc_1A78:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1ACC
		bra.w	loc_1BD6
; ---------------------------------------------------------------------------

loc_1A84:
		lsl.w	#3,d1
		move.w	d1,d6
		and.w	d4,d6
		move.b	(a1)+,d6
		suba.l	d6,a6
		add.b	d1,d1
		bcs.s	loc_1A98
		add.b	d1,d1
		bcs.s	loc_1AAE
		bra.s	loc_1AB0
; ---------------------------------------------------------------------------

loc_1A98:
		add.b	d1,d1
		bhs.s	loc_1AAC
		moveq	#0,d0
		move.b	(a1)+,d0
		beq.s	loc_1ABE
		subq.w	#6,d0
		bmi.s	loc_1AC4

loc_1AA6:
		move.b	(a6)+,(a2)+
		dbf	d0,loc_1AA6

loc_1AAC:
		move.b	(a6)+,(a2)+

loc_1AAE:
		move.b	(a6)+,(a2)+

loc_1AB0:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1AD4
		bra.w	loc_1DCC
; ---------------------------------------------------------------------------

loc_1ABE:
		move.w	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_1AC4:
		move.w	#-1,d0
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_1ACC:
		move.w	#1,d0
		moveq	#5,d2
		rts
; ---------------------------------------------------------------------------

loc_1AD4:
		move.w	#1,d0
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_1ADC:
		move.b	(a1)+,(a2)+

loc_1ADE:

		add.b	d1,d1
		bcs.s	loc_1B56
		movea.l	a2,a6
		add.b	d1,d1
		bcs.s	loc_1AFE
		move.b	(a1)+,d5
		suba.l	d5,a6
		add.b	d1,d1
		bhs.s	loc_1AF2
		move.b	(a6)+,(a2)+

loc_1AF2:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1B46
		bra.w	loc_1C52
; ---------------------------------------------------------------------------

loc_1AFE:
		lsl.w	#3,d1
		move.w	d1,d6
		and.w	d4,d6
		move.b	(a1)+,d6
		suba.l	d6,a6
		add.b	d1,d1
		bcs.s	loc_1B12
		add.b	d1,d1
		bcs.s	loc_1B28
		bra.s	loc_1B2A
; ---------------------------------------------------------------------------

loc_1B12:
		add.b	d1,d1
		bhs.s	loc_1B26
		moveq	#0,d0
		move.b	(a1)+,d0
		beq.s	loc_1B38
		subq.w	#6,d0
		bmi.s	loc_1B3E

loc_1B20:
		move.b	(a6)+,(a2)+
		dbf	d0,loc_1B20

loc_1B26:
		move.b	(a6)+,(a2)+

loc_1B28:
		move.b	(a6)+,(a2)+

loc_1B2A:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1B4E
		bra.w	loc_1A62
; ---------------------------------------------------------------------------

loc_1B38:
		move.w	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_1B3E:
		move.w	#-1,d0
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_1B46:
		move.w	#1,d0
		moveq	#4,d2
		rts
; ---------------------------------------------------------------------------

loc_1B4E:
		move.w	#1,d0
		moveq	#0,d2
		rts
; ---------------------------------------------------------------------------

loc_1B56:
		move.b	(a1)+,(a2)+

loc_1B58:

		add.b	d1,d1
		bcs.s	loc_1BD4
		movea.l	a2,a6
		add.b	d1,d1
		bcs.s	loc_1B78
		move.b	(a1)+,d5
		suba.l	d5,a6
		add.b	d1,d1
		bhs.s	loc_1B6C
		move.b	(a6)+,(a2)+

loc_1B6C:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1BC4
		bra.w	loc_1CD0
; ---------------------------------------------------------------------------

loc_1B78:
		lsl.w	#3,d1
		move.w	d1,d6
		and.w	d4,d6
		move.b	(a1)+,d6
		suba.l	d6,a6
		add.b	d1,d1
		bcs.s	loc_1B8E
		move.b	(a0)+,d1
		add.b	d1,d1
		bcs.s	loc_1BA6
		bra.s	loc_1BA8
; ---------------------------------------------------------------------------

loc_1B8E:
		move.b	(a0)+,d1
		add.b	d1,d1
		bhs.s	loc_1BA4
		moveq	#0,d0
		move.b	(a1)+,d0
		beq.s	loc_1BB6
		subq.w	#6,d0
		bmi.s	loc_1BBC

loc_1B9E:
		move.b	(a6)+,(a2)+
		dbf	d0,loc_1B9E

loc_1BA4:
		move.b	(a6)+,(a2)+

loc_1BA6:
		move.b	(a6)+,(a2)+

loc_1BA8:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1BCC
		bra.w	loc_1ADE
; ---------------------------------------------------------------------------

loc_1BB6:
		move.w	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_1BBC:
		move.w	#-1,d0
		moveq	#7,d2
		rts
; ---------------------------------------------------------------------------

loc_1BC4:
		move.w	#1,d0
		moveq	#3,d2
		rts
; ---------------------------------------------------------------------------

loc_1BCC:
		move.w	#1,d0
		moveq	#7,d2
		rts
; ---------------------------------------------------------------------------

loc_1BD4:
		move.b	(a1)+,(a2)+

loc_1BD6:

		add.b	d1,d1
		bcs.s	loc_1C50
		movea.l	a2,a6
		add.b	d1,d1
		bcs.s	loc_1BF6
		move.b	(a1)+,d5
		suba.l	d5,a6
		add.b	d1,d1
		bhs.s	loc_1BEA
		move.b	(a6)+,(a2)+

loc_1BEA:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1C40
		bra.w	loc_1D4E
; ---------------------------------------------------------------------------

loc_1BF6:
		lsl.w	#3,d1
		move.b	(a0)+,d1
		move.w	d1,d6
		and.w	d4,d6
		move.b	(a1)+,d6
		suba.l	d6,a6
		add.b	d1,d1
		bcs.s	loc_1C0C
		add.b	d1,d1
		bcs.s	loc_1C22
		bra.s	loc_1C24
; ---------------------------------------------------------------------------

loc_1C0C:
		add.b	d1,d1
		bhs.s	loc_1C20
		moveq	#0,d0
		move.b	(a1)+,d0
		beq.s	loc_1C32
		subq.w	#6,d0
		bmi.s	loc_1C38

loc_1C1A:
		move.b	(a6)+,(a2)+
		dbf	d0,loc_1C1A

loc_1C20:
		move.b	(a6)+,(a2)+

loc_1C22:
		move.b	(a6)+,(a2)+

loc_1C24:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1C48
		bra.w	loc_1B58
; ---------------------------------------------------------------------------

loc_1C32:
		move.w	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_1C38:
		move.w	#-1,d0
		moveq	#6,d2
		rts
; ---------------------------------------------------------------------------

loc_1C40:
		move.w	#1,d0
		moveq	#2,d2
		rts
; ---------------------------------------------------------------------------

loc_1C48:
		move.w	#1,d0
		moveq	#6,d2
		rts
; ---------------------------------------------------------------------------

loc_1C50:
		move.b	(a1)+,(a2)+

loc_1C52:
		add.b	d1,d1
		bcs.s	loc_1CCE
		movea.l	a2,a6
		add.b	d1,d1
		bcs.s	loc_1C72
		move.b	(a1)+,d5
		suba.l	d5,a6
		add.b	d1,d1
		bhs.s	loc_1C66
		move.b	(a6)+,(a2)+

loc_1C66:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1CBE
		bra.w	loc_1DCC
; ---------------------------------------------------------------------------

loc_1C72:
		lsl.w	#2,d1
		move.b	(a0)+,d1
		add.w	d1,d1
		move.w	d1,d6
		and.w	d4,d6
		move.b	(a1)+,d6
		suba.l	d6,a6
		add.b	d1,d1
		bcs.s	loc_1C8A
		add.b	d1,d1
		bcs.s	loc_1CA0
		bra.s	loc_1CA2
; ---------------------------------------------------------------------------

loc_1C8A:
		add.b	d1,d1
		bhs.s	loc_1C9E
		moveq	#0,d0
		move.b	(a1)+,d0
		beq.s	loc_1CB0
		subq.w	#6,d0
		bmi.s	loc_1CB6

loc_1C98:
		move.b	(a6)+,(a2)+
		dbf	d0,loc_1C98

loc_1C9E:
		move.b	(a6)+,(a2)+

loc_1CA0:
		move.b	(a6)+,(a2)+

loc_1CA2:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1CC6
		bra.w	loc_1BD6
; ---------------------------------------------------------------------------

loc_1CB0:
		move.w	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_1CB6:
		move.w	#-1,d0
		moveq	#5,d2
		rts
; ---------------------------------------------------------------------------

loc_1CBE:
		move.w	#1,d0
		moveq	#1,d2
		rts
; ---------------------------------------------------------------------------

loc_1CC6:
		move.w	#1,d0
		moveq	#5,d2
		rts
; ---------------------------------------------------------------------------

loc_1CCE:
		move.b	(a1)+,(a2)+

loc_1CD0:

		add.b	d1,d1
		bcs.s	loc_1D4C
		movea.l	a2,a6
		add.b	d1,d1
		bcs.s	loc_1CF0
		move.b	(a1)+,d5
		suba.l	d5,a6
		add.b	d1,d1
		bhs.s	loc_1CE4
		move.b	(a6)+,(a2)+

loc_1CE4:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1D3C
		bra.w	loc_1A62
; ---------------------------------------------------------------------------

loc_1CF0:
		add.w	d1,d1
		move.b	(a0)+,d1
		lsl.w	#2,d1
		move.w	d1,d6
		and.w	d4,d6
		move.b	(a1)+,d6
		suba.l	d6,a6
		add.b	d1,d1
		bcs.s	loc_1D08
		add.b	d1,d1
		bcs.s	loc_1D1E
		bra.s	loc_1D20
; ---------------------------------------------------------------------------

loc_1D08:
		add.b	d1,d1
		bhs.s	loc_1D1C
		moveq	#0,d0
		move.b	(a1)+,d0
		beq.s	loc_1D2E
		subq.w	#6,d0
		bmi.s	loc_1D34

loc_1D16:
		move.b	(a6)+,(a2)+
		dbf	d0,loc_1D16

loc_1D1C:
		move.b	(a6)+,(a2)+

loc_1D1E:
		move.b	(a6)+,(a2)+

loc_1D20:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1D44
		bra.w	loc_1C52
; ---------------------------------------------------------------------------

loc_1D2E:
		move.w	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_1D34:
		move.w	#-1,d0
		moveq	#4,d2
		rts
; ---------------------------------------------------------------------------

loc_1D3C:
		move.w	#1,d0
		moveq	#8,d2
		rts
; ---------------------------------------------------------------------------

loc_1D44:
		move.w	#1,d0
		moveq	#4,d2
		rts
; ---------------------------------------------------------------------------

loc_1D4C:
		move.b	(a1)+,(a2)+

loc_1D4E:

		add.b	d1,d1
		bcs.s	loc_1DCA
		movea.l	a2,a6
		add.b	d1,d1
		bcs.s	loc_1D70
		move.b	(a0)+,d1
		move.b	(a1)+,d5
		suba.l	d5,a6
		add.b	d1,d1
		bhs.s	loc_1D64
		move.b	(a6)+,(a2)+

loc_1D64:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1DBA
		bra.w	loc_1ADE
; ---------------------------------------------------------------------------

loc_1D70:
		move.b	(a0)+,d1
		lsl.w	#3,d1
		move.w	d1,d6
		and.w	d4,d6
		move.b	(a1)+,d6
		suba.l	d6,a6
		add.b	d1,d1
		bcs.s	loc_1D86
		add.b	d1,d1
		bcs.s	loc_1D9C
		bra.s	loc_1D9E
; ---------------------------------------------------------------------------

loc_1D86:
		add.b	d1,d1
		bhs.s	loc_1D9A
		moveq	#0,d0
		move.b	(a1)+,d0
		beq.s	loc_1DAC
		subq.w	#6,d0
		bmi.s	loc_1DB2

loc_1D94:
		move.b	(a6)+,(a2)+
		dbf	d0,loc_1D94

loc_1D9A:
		move.b	(a6)+,(a2)+

loc_1D9C:
		move.b	(a6)+,(a2)+

loc_1D9E:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1DC2
		bra.w	loc_1CD0
; ---------------------------------------------------------------------------

loc_1DAC:
		move.w	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_1DB2:
		move.w	#-1,d0
		moveq	#3,d2
		rts
; ---------------------------------------------------------------------------

loc_1DBA:
		move.w	#1,d0
		moveq	#7,d2
		rts
; ---------------------------------------------------------------------------

loc_1DC2:
		move.w	#1,d0
		moveq	#3,d2
		rts
; ---------------------------------------------------------------------------

loc_1DCA:
		move.b	(a1)+,(a2)+

loc_1DCC:
		add.b	d1,d1
		bcs.s	loc_1E46
		move.b	(a0)+,d1
		movea.l	a2,a6
		add.b	d1,d1
		bcs.s	loc_1DEE
		move.b	(a1)+,d5
		suba.l	d5,a6
		add.b	d1,d1
		bhs.s	loc_1DE2
		move.b	(a6)+,(a2)+

loc_1DE2:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1E36
		bra.w	loc_1B58
; ---------------------------------------------------------------------------

loc_1DEE:
		lsl.w	#3,d1
		move.w	d1,d6
		and.w	d4,d6
		move.b	(a1)+,d6
		suba.l	d6,a6
		add.b	d1,d1
		bcs.s	loc_1E02
		add.b	d1,d1
		bcs.s	loc_1E18
		bra.s	loc_1E1A
; ---------------------------------------------------------------------------

loc_1E02:
		add.b	d1,d1
		bhs.s	loc_1E16
		moveq	#0,d0
		move.b	(a1)+,d0
		beq.s	loc_1E28
		subq.w	#6,d0
		bmi.s	loc_1E2E

loc_1E10:
		move.b	(a6)+,(a2)+
		dbf	d0,loc_1E10

loc_1E16:
		move.b	(a6)+,(a2)+

loc_1E18:
		move.b	(a6)+,(a2)+

loc_1E1A:
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		move.b	(a6)+,(a2)+
		cmp.w	a2,d7
		bls.s	loc_1E3E
		bra.w	loc_1D4E
; ---------------------------------------------------------------------------

loc_1E28:
		move.w	#0,d0
		rts
; ---------------------------------------------------------------------------

loc_1E2E:
		move.w	#-1,d0
		moveq	#2,d2
		rts
; ---------------------------------------------------------------------------

loc_1E36:
		move.w	#1,d0
		moveq	#6,d2
		rts
; ---------------------------------------------------------------------------

loc_1E3E:
		move.w	#1,d0
		moveq	#2,d2
		rts
; ---------------------------------------------------------------------------

loc_1E46:
		move.b	(a1)+,(a2)+
		bra.w	loc_1A62
; End of function KC_Dec
