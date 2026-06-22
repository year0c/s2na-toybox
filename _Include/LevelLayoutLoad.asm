; ---------------------------------------------------------------------------
; Subroutine to load basic level data
; ---------------------------------------------------------------------------

LevelDataLoad:
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		lsl.w	#4,d0
		lea	(LevelArtPointers).l,a2
		lea	(a2,d0.w),a2
		move.l	a2,-(sp)
		addq.l	#4,a2
		movea.l	(a2)+,a0
		bra.s	.PrimaryBlocks
; ---------------------------------------------------------------------------

.DecompressBlocks:
		lea	(v_16x16).w,a1
		move.w	#make_art_tile(ArtTile_Level,0,0),d0
		bsr.w	EniDec
		bra.s	.SecondaryBlocks
; ---------------------------------------------------------------------------

.PrimaryBlocks:
		lea	(v_16x16).w,a1
		move.w	#bytesToWcnt(v_16x16_end-v_16x16),d2

.PrimaryBlocks_Loop:
		move.w	(a0)+,d0
		move.w	d0,(a1)+
		andi.w	#nontile_mask,d0
		andi.w	#tile_mask,d1
		lsr.w	#1,d1
		or.w	d1,d0
		dbf	d2,.PrimaryBlocks_Loop

.SecondaryBlocks:
		movea.l	(a2)+,a0
		bra.s	.Chunks
		move.l	a2,-(sp)
		moveq	#0,d1
		moveq	#0,d2
		move.w	(a0)+,d0
		lea	(a0,d0.w),a1
		lea	(v_128x128).l,a2
		lea	(v_128x128_end).w,a3
; ---------------------------------------------------------------------------

.Chunks:
		lea	(v_128x128).l,a1
		move.w	#bytesToWcnt(v_128x128_end-v_128x128),d0

.CopyChunksToRAM_Loop:
		move.w	(a0)+,(a1)+
		dbf	d0,.CopyChunksToRAM_Loop

.DoneChunks:
		bsr.w	LevelLayoutLoad
		move.w	(a2)+,d0
		move.w	(a2),d0
		andi.w	#$FF,d0
		cmpi.w	#id_LZ_act4,(Current_ZoneAndAct).w
		bne.s	.NotSBZ3
		moveq	#palid_SBZ3,d0

.NotSBZ3:
		cmpi.w	#id_SBZ_act2,(Current_ZoneAndAct).w
		beq.s	.IsSBZorFZ
		cmpi.w	#id_FZ,(Current_ZoneAndAct).w
		bne.s	.NormalPal

.IsSBZorFZ:
		moveq	#palid_SBZ2,d0

.NormalPal:
		bsr.w	PalLoad1
		movea.l	(sp)+,a2
		addq.w	#4,a2
		moveq	#0,d0
		move.b	(a2),d0
		beq.s	.SkipPLC
		bsr.w	LoadPLC

.SkipPLC:
		rts
; End of function LevelDataLoad

; ===========================================================================
; ---------------------------------------------------------------------------
; Level layout loading subroutine
; ---------------------------------------------------------------------------

LevelLayoutLoad:
		lea	(v_lvllayout).w,a3
		move.w	#bytesToLcnt(v_lvllayout_end-v_lvllayout),d1
		moveq	#0,d0
	.clear:	move.l	d0,(a3)+
		dbf	d1,.clear			; loop until buffer is cleared ($A400-A7FF)

		lea	(v_lvllayout).w,a3		; target RAM address for level foreground layout
		moveq	#0,d1				; offset in Level_Index (0 = FG layout)
		bsr.w	LevelLayoutLoad2		; load FG level layout into RAM

		lea	(v_lvllayoutbg).w,a3		; target RAM address for background layout
		moveq	#2,d1				; offset in Level_Index (2 = BG layout)
		; fall-through for second run...
; ---------------------------------------------------------------------------

; "LevelLayoutLoad2" is run twice for (once for the FG and BG layouts each)
LevelLayoutLoad2:
		move.w	(Current_ZoneAndAct).w,d0		; get current zone and act
		lsl.b	#6,d0
		lsr.w	#5,d0
		move.w	d0,d2
		add.w	d0,d0
		add.w	d2,d0				; d0 = Level_Index row for current zone and act
		add.w	d1,d0				; add pre-specified offset to get either FG or BG layout
		lea	(Level_Index).l,a1		; get layout index
		move.w	(a1,d0.w),d0			; advance to desired layout pointer in index
		lea	(a1,d0.w),a1			; load layout pointer from index

		moveq	#0,d1
		move.w	d1,d2
		move.b	(a1)+,d1			; load level width (in chunks)
		move.b	(a1)+,d2			; load level height (in chunks)
	.loopAllRows:
		move.w	d1,d0				; reset row length (width)
		movea.l	a3,a0				; set next target layout row in RAM
	.loopRow:
		move.b	(a1)+,(a0)+			; copy next chunk ID byte
		dbf	d0,.loopRow			; loop for one whole row
		lea	$80*2(a3),a3			; advance to next (skip over other plane)
		dbf	d2,.loopAllRows			; repeat for number of rows

		rts
; End of function LevelLayoutLoad