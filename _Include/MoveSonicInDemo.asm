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
		bpl.s	loc_44F6
		tst.w	(f_demo).w
		bmi.s	loc_44F6
		move.b	#GameModeID_TitleScreen,(v_gamemode).w

loc_44F6:
		lea	(Demo_Index).l,a1
		moveq	#0,d0
		move.b	(Current_Zone).w,d0
		cmpi.b	#GameModeID_SpecialStage,(v_gamemode).w
		bne.s	loc_450C
		moveq	#6,d0

loc_450C:
		lsl.w	#2,d0
		movea.l	(a1,d0.w),a1
		move.w	(Demo_button_index).w,d0
		adda.w	d0,a1
		move.b	(a1),d0
		lea	(v_jpadhold1).w,a0
		move.b	d0,d1
		moveq	#0,d2
		eor.b	d2,d0
		move.b	d1,(a0)+
		and.b	d1,d0
		move.b	d0,(a0)+
		subq.b	#1,(Demo_press_counter).w
		bhs.s	loc_453A
		move.b	3(a1),(Demo_press_counter).w
		addq.w	#2,(Demo_button_index).w

loc_453A:
		cmpi.b	#id_EHZ,(Current_Zone).w
		bne.s	loc_4572
		lea	(Demo_EHZ_2P).l,a1
		move.w	(Demo_button_index_2P).w,d0
		adda.w	d0,a1
		move.b	(a1),d0
		lea	(v_2Pjpadhold).w,a0
		move.b	d0,d1
		moveq	#0,d2
		eor.b	d2,d0
		move.b	d1,(a0)+
		and.b	d1,d0
		move.b	d0,(a0)+
		subq.b	#1,(Demo_press_counter_2P).w
		bhs.s	locret_4570
		move.b	3(a1),(Demo_press_counter_2P).w
		addq.w	#2,(Demo_button_index_2P).w

locret_4570:
		rts
; ---------------------------------------------------------------------------

loc_4572:
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
		dc.l $8B0837	; garbage, leftover from Sonic 1's ending sequence demos
		dc.l $42085C
		dc.l $6A085F
		dc.l $2F082C
		dc.l $210803
		dc.l $28300808
		dc.l $2E0815
		dc.l $F0846
		dc.l $1A08FF
		dc.l $8CA0000
		dc.l 0
		dc.l 0