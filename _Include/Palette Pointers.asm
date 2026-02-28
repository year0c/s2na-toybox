; ---------------------------------------------------------------------------
; Palette pointers
; (PALETTE DESCRIPTOR ARRAY)
; This struct array defines the palette to use for each level.
; ---------------------------------------------------------------------------

palptr	macro	ptr,ram,size
	dc.l ptr					; Pointer to palette
	dc.w ram					; Location in ram to load palette into
	dc.w size-1					; Size of palette in (bytes / 4)
	endm

PalPointers:	
ptr_Pal_SegaBG:		palptr	Pal_SegaBG,v_palette,$20
ptr_Pal_Title:		palptr	Pal_Title,v_palette,$20
ptr_Pal_LevelSel:	palptr	Pal_LevelSel,v_palette,$20
ptr_Pal_SonicTails:	palptr	Pal_SonicTails,v_palette,8
Pal_Levels:
ptr_Pal_GHZ:		palptr	Pal_GHZ,v_palette+$20,$18
ptr_Pal_LZ:		palptr	Pal_CPZ,v_palette+$20,$18
ptr_Pal_CPZ:		palptr	Pal_CPZ,v_palette+$20,$18
ptr_Pal_EHZ:		palptr	Pal_EHZ,v_palette+$20,$18
ptr_Pal_HPZ:		palptr	Pal_HPZ,v_palette+$20,$18
ptr_Pal_HTZ1:		palptr	Pal_HTZ,v_palette+$20,$18
ptr_Pal_Special:	palptr	Pal_S1SpecialStage,v_palette,$20
ptr_Pal_HPZWater:	palptr	Pal_HPZWater,v_palette,$20
			; the following are leftover Sonic 1 entries
ptr_Pal_SBZ3:		palptr	Pal_LZ4,v_palette+$20,$18
ptr_Pal_SBZ3Water:	palptr	Pal_LZ4Water,v_palette,$20
ptr_Pal_HTZ2:		palptr	Pal_HTZ,v_palette+$20,$18
ptr_Pal_LZSonWater:	palptr	Pal_LZSonicWater,v_palette,8
ptr_Pal_SBZ3SonWat:	palptr	Pal_LZ4SonicWater,v_palette,8
ptr_Pal_SSResult:	palptr	Pal_S1SpeResults,v_palette,$20
ptr_Pal_Continue:	palptr	Pal_S1Continue,v_palette,$10
ptr_Pal_Ending:		palptr	Pal_S1Ending,v_palette,$20
		
palid_SegaBG:		equ (ptr_Pal_SegaBG-PalPointers)/8	; 0
palid_Title:		equ (ptr_Pal_Title-PalPointers)/8	; 1
palid_LevelSel:		equ (ptr_Pal_LevelSel-PalPointers)/8	; 2
palid_SonicTails:	equ (ptr_Pal_SonicTails-PalPointers)/8	; 3
palid_GHZ:		equ (ptr_Pal_GHZ-PalPointers)/8		; 4
palid_LZ:		equ (ptr_Pal_LZ-PalPointers)/8		; 5
palid_CPZ:		equ (ptr_Pal_CPZ-PalPointers)/8		; 6
palid_EHZ:		equ (ptr_Pal_EHZ-PalPointers)/8		; 7
palid_HPZ:		equ (ptr_Pal_HPZ-PalPointers)/8		; 8
palid_HTZ1:		equ (ptr_Pal_HTZ1-PalPointers)/8	; 9
palid_Special:		equ (ptr_Pal_Special-PalPointers)/8	; $A
palid_HPZWater:		equ (ptr_Pal_HPZWater-PalPointers)/8	; $B
palid_SBZ3:		equ (ptr_Pal_SBZ3-PalPointers)/8	; $C
palid_SBZ3Water:	equ (ptr_Pal_SBZ3Water-PalPointers)/8	; $D
palid_HTZ2:		equ (ptr_Pal_HTZ2-PalPointers)/8	; $E
palid_LZSonWater:	equ (ptr_Pal_LZSonWater-PalPointers)/8	; $F
palid_SBZ3SonWat:	equ (ptr_Pal_SBZ3SonWat-PalPointers)/8	; $10
palid_SSResult:		equ (ptr_Pal_SSResult-PalPointers)/8	; $11
palid_Continue:		equ (ptr_Pal_Continue-PalPointers)/8	; $12
palid_Ending:		equ (ptr_Pal_Ending-PalPointers)/8	; $13