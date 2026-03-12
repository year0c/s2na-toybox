; ---------------------------------------------------------------------------
; Palette pointers
; (PALETTE DESCRIPTOR ARRAY)
; This struct array defines the palette to use for each level.
; ---------------------------------------------------------------------------

makePalEntry:	macro paletteLabel,paletteRAMaddress,paletteSize,{INTLABEL},{GLOBALSYMBOLS}
__LABEL__: = (*-Pal_Index)/8
	dc.l paletteLabel
	dc.w paletteRAMaddress,bytesToWcnt(paletteSize)
	endm

Pal_Index:
; Id			Palette label,	RAM location,		Amount of colours in palette
palid_SegaBG:		makePalEntry	Pal_SegaBG,		v_palette_line_1,	16*4
palid_Title:		makePalEntry	Pal_Title,		v_palette_line_1,	16*4
palid_LevelSel:		makePalEntry	Pal_LevelSel,		v_palette_line_1,	16*4
palid_SonicTails:	makePalEntry	Pal_SonicTails,		v_palette_line_1,	16

Pal_Levels:

palid_GHZ:		makePalEntry	Pal_GHZ,		v_palette_line_2,	16*3
palid_LZ:		makePalEntry	Pal_CPZ,		v_palette_line_2,	16*3
palid_CPZ:		makePalEntry	Pal_CPZ,		v_palette_line_2,	16*3
palid_EHZ:		makePalEntry	Pal_EHZ,		v_palette_line_2,	16*3
palid_HPZ:		makePalEntry	Pal_HPZ,		v_palette_line_2,	16*3
palid_HTZ1:		makePalEntry	Pal_HTZ,		v_palette_line_2,	16*3
palid_Special:		makePalEntry	Pal_S1SpecialStage,	v_palette_line_1,16*4
palid_HPZWater:		makePalEntry	Pal_HPZWater,		v_palette_line_1,	16*4

; the following are leftover Sonic 1 entries
palid_SBZ3:		makePalEntry	Pal_LZ4,		v_palette_line_2,	16*3
palid_SBZ3Water:	makePalEntry	Pal_LZ4Water,		v_palette_line_1,	16*4
palid_HTZ2:		makePalEntry	Pal_HTZ,		v_palette_line_2,	16*3
palid_LZSonWater:	makePalEntry	Pal_LZSonicWater,	v_palette_line_1,	16
palid_SBZ3SonWat:	makePalEntry	Pal_LZ4SonicWater,	v_palette_line_1,	16
palid_SSResult:		makePalEntry	Pal_S1SpeResults,	v_palette_line_1,	16*4
palid_Continue:		makePalEntry	Pal_S1Continue,		v_palette_line_1,	16*2
palid_Ending:		makePalEntry	Pal_S1Ending,		v_palette_line_1,	16*4