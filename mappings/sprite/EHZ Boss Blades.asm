.internal:	mappingsTable
	mappingsTableEntry.w	.word_18042
	mappingsTableEntry.w	.word_1804C
	mappingsTableEntry.w	.word_18076
	mappingsTableEntry.w	.word_180A0
	mappingsTableEntry.w	.word_180BA
	mappingsTableEntry.w	.word_180D4
	mappingsTableEntry.w	.word_180EE

.word_18042:	spriteHeader
	spritePiece	2, -$28, 2, 2, 0, 0, 0, 0, 0
.word_18042_End

.word_1804C:	spriteHeader
	spritePiece	2, -$28, 2, 2, 4, 0, 0, 0, 0
	spritePiece	$12, -$28, 4, 2, $C, 0, 0, 0, 0
	spritePiece	$32, -$28, 4, 2, $C, 0, 0, 0, 0
	spritePiece	-$1E, -$28, 4, 2, $C, 0, 0, 0, 0
	spritePiece	-$3E, -$28, 4, 2, $C, 0, 0, 0, 0
.word_1804C_End

.word_18076:	spriteHeader
	spritePiece	2, -$28, 2, 2, 4, 0, 0, 0, 0
	spritePiece	$12, -$28, 4, 2, $C, 0, 0, 0, 0
	spritePiece	$32, -$28, 2, 2, 8, 0, 0, 0, 0
	spritePiece	-$1E, -$28, 4, 2, $C, 0, 0, 0, 0
	spritePiece	-$2E, -$28, 2, 2, 8, 0, 0, 0, 0
.word_18076_End

.word_180A0:	spriteHeader
	spritePiece	2, -$28, 2, 2, 4, 0, 0, 0, 0
	spritePiece	$12, -$28, 4, 2, $C, 0, 0, 0, 0
	spritePiece	-$1E, -$28, 4, 2, $C, 0, 0, 0, 0
.word_180A0_End

.word_180BA:	spriteHeader
	spritePiece	2, -$28, 2, 2, 4, 0, 0, 0, 0
	spritePiece	$12, -$28, 2, 2, 8, 0, 0, 0, 0
	spritePiece	-$E, -$28, 2, 2, 8, 0, 0, 0, 0
.word_180BA_End

.word_180D4:	spriteHeader
	spritePiece	2, -$28, 2, 2, 0, 0, 0, 0, 0
	spritePiece	$12, -$28, 4, 2, $C, 0, 0, 0, 0
	spritePiece	$32, -$28, 4, 2, $C, 0, 0, 0, 0
.word_180D4_End

.word_180EE:	spriteHeader
	spritePiece	2, -$28, 2, 2, 4, 0, 0, 0, 0
	spritePiece	-$1E, -$28, 4, 2, $C, 0, 0, 0, 0
	spritePiece	-$3E, -$28, 4, 2, $C, 0, 0, 0, 0
.word_180EE_End

	even
