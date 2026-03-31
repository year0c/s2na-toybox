; ---------------------------------------------------------------------------
; "MAIN LEVEL LOAD BLOCK" (after Nemesis)
;
; This struct array tells the engine where to find all the art associated with
; a particular zone. Each zone gets four longwords, in which it stores four
; pointers (in the lower 24 bits) and three jump table indeces (in the upper eight
; bits). The assembled data looks something like this:
;
; aaBBBBBB
; ccDDDDDD
; EEEEEE
; ffgghhii
;
; aa = index for primary pattern load request list
; BBBBBB = unused, pointer to level art
; cc = index for secondary pattern load request list
; DDDDDD = pointer to 16x16 block mappings
; EEEEEE = pointer to 128x128 block mappings
; ff = unused, always 0
; gg = unused, music track
; hh = unused, palette
; ii = palette
;
; Nemesis refers to this as the "main level load block". However, that name implies
; that this is code (obviously, it isn't), or at least that it points to the level's
; collision, object and ring placement arrays (it only points to palettes and 16x16
; mappings although the 128x128 mappings do affect the actual level layout and collision)
; ---------------------------------------------------------------------------

; MainLoadBlocks:
LevelArtPointers_PB:
		;	Nem_GHZ,Map16_GHZ,Map128_GHZ
		levartptrs plcid_GHZ, plcid_GHZ2, $D5DB2, $D4FB2, $DA9CE, bgm_GHZ, palid_GHZ ; GHZ  ; GREEN HILL ZONE
		;	Nem_CPZ,Map16_CPZ,Map128_CPZ
		levartptrs plcid_LZ, plcid_LZ2, $CA3AE, $C940E, $CCFB2, bgm_LZ, palid_LZ ; LZ   ; LABYRINTH ZONE
		;	Nem_CPZ,Map16_CPZ,Map128_CPZ
		levartptrs plcid_CPZ, plcid_CPZ2, $CA3AE, $C940E, $CCFB2, bgm_MZ, palid_CPZ ; CPZ  ; CHEMICAL PLANT ZONE
		;	Nem_EHZ,Map16_EHZ,Map128_EHZ
		levartptrs plcid_EHZ, plcid_EHZ2, $B2174, $B11D4, $B4FAC, bgm_SLZ, palid_EHZ ; EHZ  ; EMERALD HILL ZONE
		;	Nem_HPZ,Map16_HPZ,Map128_HPZ
		levartptrs plcid_HPZ, plcid_HPZ2, $BE58C, $BCFAC, $C140E, bgm_SYZ, palid_HPZ ; HPZ  ; HIDDEN PALACE ZONE
		;	Nem_CPZ,Map16_CPZ,Map128_CPZ
		levartptrs plcid_HTZ, plcid_HTZ2, $CA3AE, $C940E, $CCFB2, bgm_SBZ, palid_HTZ1 ; HTZ  ; HILL TOP ZONE
		;	Nem_GHZ,Map16_GHZ,Map128_GHZ
		levartptrs 0, 0, $D5DB2, $D4FB2, $DA9CE, bgm_SBZ, palid_Ending ; LEV6 ; LEVEL 6 (UNUSED, SONIC 1 ENDING)