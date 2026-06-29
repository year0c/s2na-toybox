; ---------------------------------------------------------------------------
; Sonic frame IDs
; ---------------------------------------------------------------------------

fr_Null:	equ 0
fr_Stand:	equ 1
fr_Wait1:	equ 2
fr_Wait2:	equ 3
fr_Wait3:	equ 4
fr_LookUp:	equ 5
fr_Walk11:	equ $0D
fr_Walk12:	equ $0E
fr_Walk13:	equ $0F
fr_Walk14:	equ $10
fr_Walk15:	equ $11
fr_Walk16:	equ $12
fr_Walk17:	equ $13
fr_Walk18:	equ $14
fr_Walk21:	equ $15
fr_Walk22:	equ $16
fr_Walk23:	equ $17
fr_Walk24:	equ $18
fr_Walk25:	equ $19
fr_Walk26:	equ $2A
fr_Walk27:	equ $2B
fr_Walk28:	equ $2C
fr_Run11:	equ $2D
fr_Run12:	equ $2E
fr_Run13:	equ $2F
fr_Run14:	equ $30
fr_Run21:	equ $31
fr_Run22:	equ $32
fr_Run23:	equ $33
fr_Run24:	equ $34
fr_Run31:	equ $35
fr_Run32:	equ $36
fr_Run33:	equ $37
fr_Run34:	equ $38
fr_Run41:	equ $39
fr_Run42:	equ $3A
fr_Run43:	equ $3B
fr_Run44:	equ $3C
fr_Roll1:	equ $3D
fr_Roll2:	equ $3E
fr_Roll3:	equ $3F
fr_Roll4:	equ $40
fr_Roll5:	equ $41
fr_Warp1:	equ $33
fr_Warp2:	equ $34
fr_Warp3:	equ $35
fr_Warp4:	equ $36
fr_Stop1:	equ $37
fr_Stop2:	equ $38
fr_Duck:	equ $39
fr_Balance1:	equ $3A
fr_Balance2:	equ $3B
fr_Float1:	equ $3C
fr_Float2:	equ $3D
fr_Float3:	equ $3E
fr_Float4:	equ $3F
fr_Spring:	equ $40
fr_Hang1:	equ $41
fr_Hang2:	equ $42
fr_Leap1:	equ $43
fr_Leap2:	equ $44
fr_Push1:	equ $48
fr_Push2:	equ $49
fr_Push3:	equ $4A
fr_Push4:	equ $4B
fr_Surf:	equ $49
fr_BubStand:	equ $4A
fr_Burnt:	equ $4B
fr_Drown:	equ $4C
fr_Death:	equ $4D
fr_Shrink1:	equ $4E
fr_Shrink2:	equ $4F
fr_Shrink3:	equ $50
fr_Shrink4:	equ $51
fr_Shrink5:	equ $52
fr_Float5:	equ $53
fr_Float6:	equ $54
fr_Injury:	equ $55
fr_GetAir:	equ $56
fr_Slide:	equ $57 ; formerly named fr_WaterSlide (was too long...)
fr_SpinDash1:	equ $42
fr_SpinDash2:	equ fr_SpinDash1+1
fr_SpinDash3:	equ fr_SpinDash2+1
fr_SpinDash4:	equ fr_SpinDash3+1
fr_SpinDash5:	equ fr_SpinDash4+1
fr_SpinDash6:	equ fr_SpinDash5+1

; ---------------------------------------------------------------------------
; Animation script - Sonic
; ---------------------------------------------------------------------------

; Macro to map an ID to a label while defining the offset table entries
sonani:		macro anim,{INTLABEL}
__LABEL__:	label	(*-Ani_Sonic)/2
		dc.w	anim-Ani_Sonic
		endm
; ---------------------------------------------------------------------------

Ani_Sonic:

id_Walk:	sonani	SonAni_Walk	; $00
id_Run:		sonani	SonAni_Run	; $01
id_Roll:	sonani	SonAni_Roll	; $02
id_Roll2:	sonani	SonAni_Roll2	; $03
id_Push:	sonani	SonAni_Push	; $04
id_Wait:	sonani	SonAni_Wait	; $05
id_Balance:	sonani	SonAni_Balance	; $06
id_LookUp:	sonani	SonAni_LookUp	; $07
id_Duck:	sonani	SonAni_Duck	; $08
id_Warp1:	sonani	SonAni_Warp1	; $09
id_Warp2:	sonani	SonAni_Warp2	; $0A
id_Warp3:	sonani	SonAni_Warp3	; $0B
id_Warp4:	sonani	SonAni_Warp4	; $0C
id_Stop:	sonani	SonAni_Stop	; $0D
id_Float1:	sonani	SonAni_Float1	; $0E
id_Float2:	sonani	SonAni_Float2	; $0F
id_Spring:	sonani	SonAni_Spring	; $10
id_Hang:	sonani	SonAni_Hang	; $11
id_Leap1:	sonani	SonAni_Leap1	; $12
id_Leap2:	sonani	SonAni_Leap2	; $13
id_Surf:	sonani	SonAni_Surf	; $14
id_GetAir:	sonani	SonAni_GetAir	; $15
id_Burnt:	sonani	SonAni_Burnt	; $16
id_Drown:	sonani	SonAni_Drown	; $17
id_Death:	sonani	SonAni_Death	; $18
id_Shrink:	sonani	SonAni_Shrink	; $19
id_Hurt:	sonani	SonAni_Hurt	; $1A
id_Slide:	sonani	SonAni_Slide	; $1B
id_SpindAsh:	sonani	SonAni_SpinDash ; $1C
id_Null:	sonani	SonAni_Null	; $1D
id_Float3:	sonani	SonAni_Float3	; $1E
id_Float4:	sonani	SonAni_Float4	; $1F

; ---------------------------------------------------------------------------
; --- Special animations (walk/run/roll/push) ---
; Sonic handles animations with a start value of $80 or greater separately.
; All special animations need to have EXACTLY 6 frames (plus one afEnd),
; animations that are too short have extra afEnd to pad to the same length.
; This is because the special animation handler switches between these
; animations without resetting the animation positon.

SonAni_Walk:	dc.b $FF
		dc.b fr_Walk11, fr_Walk12, fr_Walk13, fr_Walk14, fr_Walk15, fr_Walk16, fr_Walk17, fr_Walk18
		dc.b afEnd
		even

SonAni_Run:	dc.b $FF
		dc.b fr_Run11, fr_Run12, fr_Run13, fr_Run14
		dc.b afEnd
		even

SonAni_Roll:	dc.b $FE
		dc.b fr_Roll1, fr_Roll5, fr_Roll2, fr_Roll5, fr_Roll3, fr_Roll5, fr_Roll4, fr_Roll5
		dc.b afEnd
		even

SonAni_Roll2:	dc.b $FE
		dc.b fr_Roll1, fr_Roll5, fr_Roll2, fr_Roll5, fr_Roll3, fr_Roll5, fr_Roll4, fr_Roll5
		dc.b afEnd
		even

SonAni_Push:	dc.b $FD
		dc.b fr_Push1, fr_Push2, fr_Push3, fr_Push4
		dc.b afEnd
		even

; ---------------------------------------------------------------------------
; --- Normal animations ---
; First byte denotes number of frames between each animation.
; Overview of animation flags (examples):
; 	dc.b afEnd  		; return to beginning of animation
; 	dc.b afBack, 5		; go back specified number of frames
; 	dc.b afChange, id_Surf	; switch to a different animation

SonAni_Wait:	dc.b 23
		dc.b fr_Stand, fr_Stand, fr_Stand, fr_Stand, fr_Stand, fr_Stand
		dc.b fr_Stand, fr_Stand, fr_Stand, fr_Stand, fr_Stand, fr_Stand
		dc.b fr_Wait2, fr_Wait1, fr_Wait1, fr_Wait1
		dc.b fr_Wait2, fr_Wait3	; looped
		dc.b afBack, 2
		even

SonAni_Balance:	dc.b 31
		dc.b fr_Balance1, fr_Balance2
		dc.b afEnd
		even

SonAni_LookUp:	dc.b 63
		dc.b fr_LookUp
		dc.b afEnd
		even

SonAni_Duck:	dc.b 63
		dc.b fr_Duck
		dc.b afEnd
		even

SonAni_Warp1:	dc.b 63
		dc.b fr_Warp1
		dc.b afEnd
		even

SonAni_Warp2:	dc.b 63
		dc.b fr_Warp2
		dc.b afEnd
		even

SonAni_Warp3:	dc.b 63
		dc.b fr_Warp3
		dc.b afEnd
		even

SonAni_Warp4:	dc.b 63
		dc.b fr_Warp4
		dc.b afEnd
		even

SonAni_Stop:	dc.b 7
		dc.b fr_Stop1, fr_Stop2
		dc.b afEnd
		even

SonAni_Float1:	dc.b 7
		dc.b fr_Float1, fr_Float4
		dc.b afEnd
		even

SonAni_Float2:	dc.b 7
		dc.b fr_Float1, fr_Float2, fr_Float5, fr_Float3, fr_Float6
		dc.b afEnd
		even

SonAni_Spring:	dc.b 47
		dc.b fr_Spring
		dc.b afChange, id_Walk
		even

SonAni_Hang:	dc.b 4
		dc.b fr_Hang1, fr_Hang2
		dc.b afEnd
		even

SonAni_Leap1:	dc.b 15
		dc.b fr_Leap1, fr_Leap1
		dc.b fr_Leap1 ; looped
		dc.b afBack, 1
		even

SonAni_Leap2:	dc.b 15
		dc.b fr_Leap1
		dc.b fr_Leap2 ; looped
		dc.b afBack, 1
		even

SonAni_Surf:	dc.b 63
		dc.b fr_Surf
		dc.b afEnd
		even

SonAni_GetAir:	dc.b 11
		dc.b fr_GetAir, fr_GetAir, fr_Walk15, fr_Walk16
		dc.b afChange, id_Walk
		even

SonAni_Burnt:	dc.b 32
		dc.b fr_Burnt
		dc.b afEnd
		even

SonAni_Drown:	dc.b 47
		dc.b fr_Drown
		dc.b afEnd
		even

SonAni_Death:	dc.b 3
		dc.b fr_Death
		dc.b afEnd
		even

SonAni_Shrink:	dc.b 3
		dc.b fr_Shrink1, fr_Shrink2, fr_Shrink3, fr_Shrink4, fr_Shrink5
		dc.b fr_Null ; looped
		dc.b afBack, 1
		even

SonAni_Hurt:	dc.b 3
		dc.b fr_Injury
		dc.b afEnd
		even

SonAni_Slide:	dc.b 7
		dc.b fr_Injury, fr_Slide
		dc.b afEnd
		even

SonAni_SpinDash:
		dc.b 0
		dc.b fr_SpinDash1, fr_SpinDash2, fr_SpinDash1, fr_SpinDash3, fr_SpinDash1
		dc.b fr_SpinDash4, fr_SpinDash1, fr_SpinDash5, fr_SpinDash1, fr_SpinDash6
		dc.b afEnd
		even

SonAni_Null:	dc.b 119
		dc.b fr_Null
		dc.b afChange, id_Walk
		even

SonAni_Float3:	dc.b 3
		dc.b fr_Float1, fr_Float2, fr_Float5, fr_Float3, fr_Float6
		dc.b afEnd
		even

SonAni_Float4:	dc.b 3
		dc.b fr_Float1
		dc.b afChange, id_Walk
		even
