; =============== S U B	R O U T	I N E =======================================


MoveSonicInDemo:
		tst.w	(f_demo).w
		bne.s	MoveDemo_On
		rts
; ---------------------------------------------------------------------------

MoveSonic_DemoRecord:					; unused subroutine for	recording demos
		lea	(RAM_debug_demo_record).l,a1

loc_4474:
		move.w	(Demo_button_index).w,d0
		adda.w	d0,a1
		move.b	(v_jpadhold1).w,d0
		cmp.b	(a1),d0
		bne.s	loc_4490
		addq.b	#1,1(a1)
		cmpi.b	#-1,1(a1)
		beq.s	loc_4490
		bra.s	loc_44A4
; ---------------------------------------------------------------------------

loc_4490:
		move.b	d0,2(a1)
		move.b	#0,3(a1)
		addq.w	#2,(Demo_button_index).w
		andi.w	#$3FF,(Demo_button_index).w

loc_44A4:
		cmpi.b	#id_EHZ,(Current_Zone).w		; are we on Emerald Hill?
		bne.s	locret_44E2			; if not, branch
		lea	(RAM_debug_demo_record_2P).l,a1
		move.w	(Demo_button_index_2P).w,d0
		adda.w	d0,a1
		move.b	(v_2Pjpadhold).w,d0
		cmp.b	(a1),d0
		bne.s	loc_44CE
		addq.b	#1,1(a1)
		cmpi.b	#-1,1(a1)
		beq.s	loc_44CE
		bra.s	locret_44E2
; ---------------------------------------------------------------------------

loc_44CE:
		move.b	d0,2(a1)
		move.b	#0,3(a1)
		addq.w	#2,(Demo_button_index_2P).w
		andi.w	#$3FF,(Demo_button_index_2P).w

locret_44E2:
		rts
; ---------------------------------------------------------------------------

MoveDemo_On:
		tst.b	(v_jpadhold1).w
		bpl.s	.dontquit
		tst.w	(f_demo).w
		bmi.s	.dontquit
		move.b	#GameModeID_TitleScreen,(v_gamemode).w

.dontquit:
		lea	(Demo_Index).l,a1
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		cmpi.b	#GameModeID_SpecialStage,(v_gamemode).w
		bne.s	.notspecial
		moveq	#6,d0

.notspecial:
		lsl.w	#2,d0
		movea.l	(a1,d0.w),a1
		move.w	(Demo_button_index).w,d0
		adda.w	d0,a1
		move.b	(a1),d0
		lea	(v_jpadhold1).w,a0
		move.b	d0,d1
	if FixBugs
		; Fix demo playback
		; https://info.sonicretro.org/SCHG_How-to:Fix_demo_playback
		move.b	v_jpadhold2-v_jpadhold1(a0),d2
	else
		moveq	#0,d2
	endif
		eor.b	d2,d0
		move.b	d1,(a0)+
		and.b	d1,d0
		move.b	d0,(a0)+
		subq.b	#1,(Demo_press_counter).w
		bhs.s	.demo2P
		move.b	3(a1),(Demo_press_counter).w
		addq.w	#2,(Demo_button_index).w

.demo2P:
		cmpi.b	#id_EHZ,(Current_Zone).w
		bne.s	.notEHZ
		lea	(Demo_EHZ_2P).l,a1
		move.w	(Demo_button_index_2P).w,d0
		adda.w	d0,a1
		move.b	(a1),d0
		lea	(v_2Pjpadhold).w,a0
		move.b	d0,d1
	if FixBugs
		; Fix demo playback
		; https://info.sonicretro.org/SCHG_How-to:Fix_demo_playback
		move.b	v_jpadhold2-v_jpadhold1(a0),d2
	else
		moveq	#0,d2
	endif
		eor.b	d2,d0
		move.b	d1,(a0)+
		and.b	d1,d0
		move.b	d0,(a0)+
		subq.b	#1,(Demo_press_counter_2P).w
		bhs.s	.end
		move.b	3(a1),(Demo_press_counter_2P).w
		addq.w	#2,(Demo_button_index_2P).w

.end:
		rts
; ---------------------------------------------------------------------------

.notEHZ:
		move.w	#0,(v_2Pjpadhold).w
		rts
; End of function MoveSonicInDemo

Demo_Index:
		dc.l Demo_S1GHZ	; leftover demo	from Sonic 1 GHZ
		dc.l Demo_S1GHZ	; leftover demo	from Sonic 1 GHZ
		dc.l Demo_CPZ
		dc.l Demo_EHZ
		dc.l Demo_HPZ
		dc.l Demo_HTZ
		dc.l Demo_S1SS	; leftover demo	from Sonic 1 Special Stage
		dc.l Demo_S1SS	; leftover demo	from Sonic 1 Special Stage
		dc.l RAM_debug_demo_record	; These point to the unused demo recording's offset
		dc.l RAM_debug_demo_record
		dc.l RAM_debug_demo_record
		dc.l RAM_debug_demo_record
		dc.l RAM_debug_demo_record
		dc.l RAM_debug_demo_record
		dc.l RAM_debug_demo_record
		dc.l RAM_debug_demo_record
		dc.l RAM_debug_demo_record

Demo_S1EndIndex:
	if 0
		dc.l Demo_EndGHZ1	; demos run during the credits, removed in Sonic 2 Nick Arcade
		dc.l Demo_EndMZ
		dc.l Demo_EndSYZ
		dc.l Demo_EndLZ
		dc.l Demo_EndSLZ
		dc.l Demo_EndSBZ1
		dc.l Demo_EndSBZ2
		dc.l Demo_EndGHZ2
	endif

; Stray demo data is present here. It involves Sonic slowly running
; right, jumping once, then running at full speed for a few seconds.
; Interestingly, this lines up with our knowledge of the fabled
; Tokyo Game Show prototype.
; See it in action: https://youtu.be/S8_IAfQbUu0
Demo_Unused:	binclude	"demodata/S1/Unused Demo.bin"
		even