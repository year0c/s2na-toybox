;----------------------------------------------------
; Object 79 - lamppost
;----------------------------------------------------

Obj79:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj79_Index(pc,d0.w),d1
		jsr	Obj79_Index(pc,d1.w)
		jmp	(MarkObjGone).l
; ---------------------------------------------------------------------------
Obj79_Index:	dc.w Obj79_Init-Obj79_Index
		dc.w Obj79_Main-Obj79_Index
		dc.w Obj79_AfterHit-Obj79_Index
; ---------------------------------------------------------------------------

Obj79_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj79,obMap(a0)
		move.w	#make_art_tile(ArtTile_Lamppost,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#4,obRender(a0)
		move.b	#8,obActWid(a0)
		move.b	#5,obPriority(a0)
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		bclr	#7,2(a2,d0.w)
		btst	#0,2(a2,d0.w)
		bne.s	loc_13536
		move.b	(v_lastlamp).w,d1
		andi.b	#$7F,d1
		move.b	obSubtype(a0),d2
		andi.b	#$7F,d2
		cmp.b	d2,d1
		blo.s	Obj79_Main

loc_13536:
		bset	#0,2(a2,d0.w)
		move.b	#4,obRoutine(a0)
		rts
; ---------------------------------------------------------------------------

Obj79_Main:
		tst.w	(Debug_placement_mode).w
		bne.w	locret_135CA
		tst.b	(f_playerctrl).w
		bmi.w	locret_135CA
		move.b	(v_lastlamp).w,d1
		andi.b	#$7F,d1
		move.b	obSubtype(a0),d2
		andi.b	#$7F,d2
		cmp.b	d2,d1
		blo.s	Obj79_HitLamp
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		bset	#0,2(a2,d0.w)
		move.b	#4,obRoutine(a0)
		bra.w	locret_135CA
; ---------------------------------------------------------------------------

Obj79_HitLamp:
		move.w	(v_player+obX).w,d0
		sub.w	obX(a0),d0
		addi.w	#8,d0
		cmpi.w	#$10,d0
		bhs.w	locret_135CA
		move.w	(v_player+obY).w,d0
		sub.w	obY(a0),d0
		addi.w	#$40,d0
		cmpi.w	#$68,d0
		bhs.s	locret_135CA
		move.w	#sfx_Lamppost,d0
		jsr	(PlaySound_Special).l
		addq.b	#2,obRoutine(a0)
		bsr.w	Lamppost_StoreInfo
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		bset	#0,2(a2,d0.w)

locret_135CA:
		rts
; ---------------------------------------------------------------------------

Obj79_AfterHit:
		move.b	(Vint_runcount+3).w,d0
		andi.b	#2,d0
		lsr.b	#1,d0
		addq.b	#1,d0
		move.b	d0,obFrame(a0)
		rts

; =============== S U B	R O U T	I N E =======================================


Lamppost_StoreInfo:
		move.b	obSubtype(a0),(v_lastlamp).w
		move.b	(v_lastlamp).w,(v_lastlamp+1).w
		move.w	obX(a0),(v_lamp_xpos).w
		move.w	obY(a0),(v_lamp_ypos).w
		move.w	(v_rings).w,(v_lamp_rings).w
		move.b	(v_lifecount).w,(v_lamp_lives).w
		move.l	(v_time).w,(v_lamp_time).w
		move.b	(Dynamic_Resize_Routine).w,(v_lamp_dle).w
		move.w	(Camera_Max_Y_pos).w,(v_lamp_limitbtm).w
		move.w	(Camera_RAM).w,(v_lamp_scrx).w
		move.w	(Camera_Y_pos).w,(v_lamp_scry).w
		move.w	(Camera_BG_X_pos).w,(v_lamp_bgscrx).w
		move.w	(Camera_BG_Y_pos).w,(v_lamp_bgscry).w
		move.w	(Camera_BG2_X_pos).w,(v_lamp_bg2scrx).w
		move.w	(Camera_BG2_Y_pos).w,(v_lamp_bg2scry).w
		move.w	(Camera_BG3_X_pos).w,(v_lamp_bg3scrx).w
		move.w	(Camera_BG3_Y_pos).w,(v_lamp_bg3scry).w
		move.w	(v_waterpos2).w,(v_lamp_wtrpos).w
		move.b	(v_wtr_routine).w,(v_lamp_wtrrout).w
		move.b	(f_wtr_state).w,(v_lamp_wtrstat).w
		rts
; End of function Lamppost_StoreInfo


; =============== S U B	R O U T	I N E =======================================


Lamppost_LoadInfo:
		move.b	(v_lastlamp+1).w,(v_lastlamp).w
		move.w	(v_lamp_xpos).w,(v_player+obX).w
		move.w	(v_lamp_ypos).w,(v_player+obY).w
		move.w	(v_lamp_rings).w,(v_rings).w
		move.b	(v_lamp_lives).w,(v_lifecount).w
		clr.w	(v_rings).w
		clr.b	(v_lifecount).w
		move.l	(v_lamp_time).w,(v_time).w
		move.b	#60-1,(v_timecent).w
		subq.b	#1,(v_timesec).w
		move.b	(v_lamp_dle).w,(Dynamic_Resize_Routine).w
		move.b	(v_lamp_wtrrout).w,(v_wtr_routine).w
		move.w	(v_lamp_limitbtm).w,(Camera_Max_Y_pos).w
		move.w	(v_lamp_limitbtm).w,(Camera_Max_Y_pos_target).w
		move.w	(v_lamp_scrx).w,(Camera_RAM).w
		move.w	(v_lamp_scry).w,(Camera_Y_pos).w
		move.w	(v_lamp_bgscrx).w,(Camera_BG_X_pos).w
		move.w	(v_lamp_bgscry).w,(Camera_BG_Y_pos).w
		move.w	(v_lamp_bg2scrx).w,(Camera_BG2_X_pos).w
		move.w	(v_lamp_bg2scry).w,(Camera_BG2_Y_pos).w
		move.w	(v_lamp_bg3scrx).w,(Camera_BG3_X_pos).w
		move.w	(v_lamp_bg3scry).w,(Camera_BG3_Y_pos).w
		cmpi.b	#id_LZ,(Current_Zone).w
		bne.s	loc_136F0
		move.w	(v_lamp_wtrpos).w,(v_waterpos2).w
		move.b	(v_lamp_wtrrout).w,(v_wtr_routine).w
		move.b	(v_lamp_wtrstat).w,(f_wtr_state).w

loc_136F0:
		tst.b	(v_lastlamp).w
		bpl.s	locret_13702
		move.w	(v_lamp_xpos).w,d0
		subi.w	#$A0,d0
		move.w	d0,(Camera_Min_X_pos).w

locret_13702:
		rts
; End of function Lamppost_LoadInfo