; ---------------------------------------------------------------------------
; Load a Dynamic Pattern Load Cues request into the DMA queue.
; ---------------------------------------------------------------------------
; Input:
;	d0.b = frame number
;	d4.w = starting target VRAM tile address
;	d6.l = pointer to uncompressed art
;	a2   = pointer to DPLC table
; ---------------------------------------------------------------------------

LoadDynPLC:
		andi.w	#$FF,d0			; mask out anything except the input frame
		add.w	d0,d0			; double ID (for word-based indexing)
		adda.w	(a2,d0.w),a2		; find current DPLC entry
		move.w	(a2)+,d5		; get number of tasks in this DPLC entry
		subq.w	#1,d5			; subtract 1 from number of tasks (will be the loop count)
		bmi.s	.end			; if it underflowed, this is an empty entry, nothing to do
		
	.loop:
		move.b	(a2)+,d3		; get first byte of DPLC task
		move.b	d3,-(sp)		; move it to stack (bytes shift sp by 2)
		moveq	#0,d1			; clear d1
		move.w	(sp)+,d1		; move it from stack to upper byte of d1
		move.b	(a2)+,d1		; get second byte of DPLC task
		andi.w	#$F0,d3			; only look at upper nybble of first byte
		addi.w	#$10,d3			; add 1 to that nybble
		andi.w	#$FFF,d1		; mask out that nybble in the other part
		lsl.l	#5,d1			; multiply by $20 (tile_size)
		add.l	d6,d1			; add art location
		move.w	d4,d2			; set target VRAM location
		add.w	d3,d4			; advance VRAM pointer
		add.w	d3,d4			; (twice, for word-based tiles)
		bsr.w	QueueDMATransfer	; load DMA request into queue (also known as "DMA_68KtoVRAM")
		dbf	d5,.loop		; repeat for number of entries
		
	.end:
		rts				; return
; End of function LoadDynPLC