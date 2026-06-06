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
		levartptrs plcid_GHZ, plcid_GHZ2, Nem_GHZ_PB, Map16_GHZ_PB, Map128_GHZ_PB, bgm_GHZ, palid_GHZ ; GHZ  ; GREEN HILL ZONE
		levartptrs plcid_LZ, plcid_LZ2, Nem_CPZ_PB, Map16_CPZ_PB, Map128_CPZ_PB, bgm_LZ, palid_LZ ; LZ   ; LABYRINTH ZONE
		levartptrs plcid_CPZ, plcid_CPZ2, Nem_CPZ_PB, Map16_CPZ_PB, Map128_CPZ_PB, bgm_MZ, palid_CPZ ; CPZ  ; CHEMICAL PLANT ZONE
		levartptrs plcid_EHZ, plcid_EHZ2, Nem_EHZ_PB, Map16_EHZ_PB, Map128_EHZ_PB, bgm_SLZ, palid_EHZ ; EHZ  ; EMERALD HILL ZONE
		levartptrs plcid_HPZ, plcid_HPZ2, Nem_HPZ_PB, Map16_HPZ_PB, Map128_HPZ_PB, bgm_SYZ, palid_HPZ ; HPZ  ; HIDDEN PALACE ZONE
		levartptrs plcid_HTZ, plcid_HTZ2, Nem_CPZ_PB, Map16_CPZ_PB, Map128_CPZ_PB, bgm_SBZ, palid_HTZ1 ; HTZ  ; HILL TOP ZONE
		levartptrs 0, 0, Nem_GHZ_PB, Map16_GHZ_PB, Map128_GHZ_PB, bgm_SBZ, palid_Ending ; LEV6 ; LEVEL 6 (UNUSED, SONIC 1 ENDING)