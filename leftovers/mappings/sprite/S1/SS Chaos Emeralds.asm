; ---------------------------------------------------------------------------
; Sprite mappings - special stage chaos emeralds
; This is some weird intermingled setup with three different map tables
; ---------------------------------------------------------------------------
Map_SS_Chaos1_PB:	mappingsTable
	mappingsTableEntry.w	M_Chaos_1_PB
	mappingsTableEntry.w	M_Chaos_White_PB
Map_SS_Chaos2_PB:	mappingsTable
	mappingsTableEntry.w	M_Chaos_2_PB
	mappingsTableEntry.w	M_Chaos_White_PB
Map_SS_Chaos3_PB:	mappingsTable
	mappingsTableEntry.w	M_Chaos_3_PB
	mappingsTableEntry.w	M_Chaos_White_PB

M_Chaos_1_PB:	spriteHeader
	spritePiece	-8, -8, 2, 2, 0, 0, 0, 0, 0
M_Chaos_1_PB_End

M_Chaos_2_PB:	spriteHeader
	spritePiece	-8, -8, 2, 2, 4, 0, 0, 0, 0
M_Chaos_2_PB_End

M_Chaos_3_PB:	spriteHeader
	spritePiece	-8, -8, 2, 2, 8, 0, 0, 0, 0
M_Chaos_3_PB_End

M_Chaos_White_PB:	spriteHeader	; cross-referenced in all three mappings
	spritePiece	-8, -8, 2, 2, $C, 0, 0, 0, 0
M_Chaos_White_PB_End

		even

