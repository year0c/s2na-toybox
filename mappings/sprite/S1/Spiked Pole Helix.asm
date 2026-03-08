; ---------------------------------------------------------------------------
; Sprite mappings - helix of spikes on a pole (GHZ)
; ---------------------------------------------------------------------------
Map_Hel_internal:
		dc.w byte_7E08-Map_Hel_internal
		dc.w byte_7E0E-Map_Hel_internal
		dc.w byte_7E14-Map_Hel_internal
		dc.w byte_7E1A-Map_Hel_internal
		dc.w byte_7E20-Map_Hel_internal
		dc.w byte_7E26-Map_Hel_internal
		dc.w word_880A-Map_Hel_internal
		dc.w byte_7E2C-Map_Hel_internal
byte_7E08:	dc.w 1
		dc.w $F001, 0, 0, $FFFC	; points straight up (harmful)
byte_7E0E:	dc.w 1
		dc.w $F505, 2, 1, $FFF8	; 45 degree
byte_7E14:	dc.w 1
		dc.w $F805, 6, 3, $FFF8	; 90 degree
byte_7E1A:	dc.w 1
		dc.w $FB05, $A, 5, $FFF8	; 45 degree
byte_7E20:	dc.w 1
		dc.w 1, $E, 7, $FFFC	; straight down
byte_7E26:	dc.w 1
		dc.w $400, $10, 8, $FFFD	; 45 degree
byte_7E2C:	dc.w 1
		dc.w $F400, $11, 8, $FFFD ; 45 degree
word_880A:	dc.w 0
