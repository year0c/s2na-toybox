; ---------------------------------------------------------------------------
; Leftover source code name variables for locations in ROM

bgmset:		equ $12F6
off_2AF0:	equ $2AF0
sinset:		equ $2B16
off_C706:	equ $C706
actwkchk:	equ $XXXX
speedset2:	equ $C732
actionsub:	equ $C758
off_C7AE:	equ $C7AE
off_C81A:	equ $C81A
frameout:	equ $C88E
patchg:		equ $C89C
off_CFC2:	equ $CFC2
off_CFDE:	equ $CFDE
off_D2F0:	equ $D2F0
off_DAC8:	equ $DAC8
off_FDCC:	equ $FDCC
off_18A82:	equ $18A82
off_19A3C:	equ $19A3C
dirsprset:	equ	?

; object variables
actno:	equ obID
actflg:	equ obRender
cddat:	equ obStatus
userflag:	equ obSubtype
sproffset:	equ obGfx
patbase:	equ obMap
xposi:	equ obX
yposi:	equ obY
patno:	equ obFrame
mstno:	equ obAnim

; ram variables
playerwk:	equ v_player
gmmode:	equ v_gamemode
swdata1+0:	equ v_jpadhold1
swdata1+1:	equ v_jpadpress1
dualmode:	equ Two_player_mode