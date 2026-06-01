.internal:	mappingsTable
	mappingsTableEntry.w	.word_1856C
	mappingsTableEntry.w	.word_1858E
	mappingsTableEntry.w	.word_185B0

.word_1856C:	spriteHeader
	spritePiece	-$20, -8, 2, 2, 0, 0, 0, 0, 0
	spritePiece	-$20, 8, 2, 2, 4, 0, 0, 0, 0
	spritePiece	-$10, -8, 4, 4, 8, 0, 0, 0, 0
	spritePiece	$10, -8, 2, 4, $18, 0, 0, 0, 0
.word_1856C_End

.word_1858E:	spriteHeader
	spritePiece	-$20, -$18, 2, 2, $28, 0, 0, 0, 0
	spritePiece	-$10, -$18, 4, 2, $30, 0, 0, 0, 0
	spritePiece	$10, -$18, 2, 2, $24, 0, 0, 0, 0
	spritePiece	2, -$28, 2, 2, $20, 0, 0, 0, 0
.word_1858E_End

.word_185B0:	spriteHeader
	spritePiece	-$20, -$18, 2, 2, $28, 0, 0, 0, 0
	spritePiece	-$10, -$18, 4, 2, $38, 0, 0, 0, 0
	spritePiece	$10, -$18, 2, 2, $24, 0, 0, 0, 0
	spritePiece	2, -$28, 2, 2, $20, 0, 0, 0, 0
.word_185B0_End

	even
