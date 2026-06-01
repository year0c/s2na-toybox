; ---------------------------------------------------------------------------
; Sprite mappings - animals
; ---------------------------------------------------------------------------
Map_Animal3_internal:	mappingsTable
	mappingsTableEntry.w	byte_94A2
	mappingsTableEntry.w	byte_94A8
	mappingsTableEntry.w	byte_A044

byte_A044:	spriteHeader
	spritePiece	-8, -$C, 2, 3, 0, 0, 0, 0, 0
byte_A044_End

byte_94A2:	spriteHeader
	spritePiece	-$C, -4, 3, 2, 6, 0, 0, 0, 0
byte_94A2_End

byte_94A8:	spriteHeader
	spritePiece	-$C, -4, 3, 2, $C, 0, 0, 0, 0
byte_94A8_End

	even
