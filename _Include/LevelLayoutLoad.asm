; ---------------------------------------------------------------------------
; Subroutine to load basic level data
; ---------------------------------------------------------------------------

LevelDataLoad:
	; --- Load Level Header ---
		moveq	#0,d0
		move.b	(Current_Zone).w,d0		; get zone ID to load
		lsl.w	#4,d0				; multiply by $10 (size per level header entry)
		lea	(LevelArtPointers).l,a2
		lea	(a2,d0.w),a2			; advance to level header for current zone
		move.l	a2,-(sp)			; remember header address for later
		addq.l	#4,a2				; skip 1st PLC and level gfx entry (handled in GM_Level)

	; --- 16x16 Block Mappings ---
		movea.l	(a2)+,a0			; get 16x16 data pointer from level header
		bra.s	.PrimaryBlocks
		lea	(v_16x16).w,a1			; set target RAM buffer for 16x16 mappings
		move.w	#make_art_tile(ArtTile_Level,0,0),d0	; set base art tile (0)
		bsr.w	EniDec				; decompress Enigma-compresseed block data to buffer
		bra.s	.SecondaryBlocks

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

	; --- 128x128 Chunk Mappings ---
	.SecondaryBlocks:
		movea.l	(a2)+,a0			; get 128x128 chunk data pointer from level header
		bra.s	.Chunks
		move.l	a2,-(sp)
		moveq	#0,d1
		moveq	#0,d2
		move.w	(a0)+,d0
		lea	(a0,d0.w),a1
		lea	(v_128x128).l,a2		; set target RAM buffer for 128x128 mappings
		lea	(v_128x128_end).w,a3

	.Chunks:
		lea	(v_128x128).l,a1
		move.w	#bytesToWcnt(v_128x128_end-v_128x128),d0

	.CopyChunksToRAM_Loop:
		move.w	(a0)+,(a1)+
		dbf	d0,.CopyChunksToRAM_Loop

	; --- Level Layout (FG/BG) ---
		bsr.w	LevelLayoutLoad			; load FG and BG layout

	; --- Palette ---
		move.l	(a2),d0				; load palette ID
		andi.w	#$FF,d0				; only use lower byte (palette ID is duplicated in headers)

		cmpi.w	#id_LZ_act4,(Current_ZoneAndAct).w	; is level SBZ3 (LZ4)?
		bne.s	.notSBZ3			; if not, branch
		moveq	#palid_SBZ3,d0			; use SB3 palette instead
	.notSBZ3:
		cmpi.w	#id_SBZ_act2,(Current_ZoneAndAct).w	; is level SBZ2?
		beq.s	.isSBZorFZ			; if yes, branch
		cmpi.w	#id_FZ,(Current_ZoneAndAct).w	; is level FZ?
		bne.s	.normalpal			; if not, branch
	.isSBZorFZ:
		moveq	#palid_SBZ2,d0			; use SBZ2/FZ palette instead
	.normalpal:
		bsr.w	PalLoad1			; load specified palette into fade-in buffer

	; --- 2nd PLC ---
		movea.l	(sp)+,a2			; restore base level header pointer
		addq.w	#4,a2				; advance to 2nd PLC entry
		moveq	#0,d0
		move.b	(a2),d0				; load 2nd PLC entry from level headers
		beq.s	.skipPLC			; if 2nd PLC is 0 (i.e. the ending sequence), branch
		bsr.w	LoadPLC				; load secondary pattern load cues
	.skipPLC:
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
		move.w	(Current_ZoneAndAct).w,d0	; get current zone and act
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