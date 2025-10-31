;----------------------------------------------------
; Object 2E - monitor contents (code for power-up behavior and rising image)
;----------------------------------------------------

Obj2E:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj2E_Index(pc,d0.w),d1
		jmp	Obj2E_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj2E_Index:	dc.w loc_B04E-Obj2E_Index
		dc.w loc_B092-Obj2E_Index
		dc.w loc_B1AA-Obj2E_Index
; ---------------------------------------------------------------------------

loc_B04E:
		addq.b	#2,obRoutine(a0)
		move.w	#make_art_tile(ArtTile_Monitor,0,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		move.b	#$24,obRender(a0)
		move.b	#3,obPriority(a0)
		move.b	#8,obActWid(a0)
		move.w	#-$300,obVelY(a0)
		moveq	#0,d0
		move.b	obAnim(a0),d0
		addq.b	#1,d0
		move.b	d0,obFrame(a0)
		movea.l	#Map_Obj26,a1
		add.b	d0,d0
		adda.w	(a1,d0.w),a1
		addq.w	#2,a1
		move.l	a1,obMap(a0)

loc_B092:
		bsr.s	sub_B098
		bra.w	DisplaySprite

; =============== S U B	R O U T	I N E =======================================


sub_B098:
		tst.w	obVelY(a0)
		bpl.w	loc_B0AC
		bsr.w	ObjectMove
		addi.w	#$18,obVelY(a0)
		rts
; ---------------------------------------------------------------------------

loc_B0AC:
		addq.b	#2,obRoutine(a0)
		move.w	#30-1,obTimeFrame(a0)
		moveq	#0,d0
		move.b	obAnim(a0),d0
		add.w	d0,d0
		move.w	Monitor_Subroutines(pc,d0.w),d0
		jmp	Monitor_Subroutines(pc,d0.w)
; End of function sub_B098

; ---------------------------------------------------------------------------
Monitor_Subroutines:dc.w Monitor_Null-Monitor_Subroutines
		dc.w Monitor_SonicLife-Monitor_Subroutines
		dc.w Monitor_TailsLife-Monitor_Subroutines
		dc.w Monitor_Null-Monitor_Subroutines
		dc.w Monitor_Rings-Monitor_Subroutines
		dc.w Monitor_Shoes-Monitor_Subroutines
		dc.w Monitor_Shield-Monitor_Subroutines
		dc.w Monitor_Invincibility-Monitor_Subroutines
		dc.w Monitor_Null-Monitor_Subroutines
		dc.w Monitor_Null-Monitor_Subroutines
; ---------------------------------------------------------------------------

Monitor_Null:
		rts
; ---------------------------------------------------------------------------

Monitor_SonicLife:
		addq.b	#1,(v_lives).w
		addq.b	#1,(f_lifecount).w
		move.w	#bgm_ExtraLife,d0
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------

Monitor_TailsLife:					; A complete copy of Monitor_SonicLife
		addq.b	#1,(v_lives).w
		addq.b	#1,(f_lifecount).w
		move.w	#bgm_ExtraLife,d0
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------

Monitor_Rings:
		addi.w	#10,(v_rings).w
		ori.b	#1,(f_ringcount).w
		cmpi.w	#100,(v_rings).w
		bcs.s	loc_B130
		bset	#1,(v_lifecount).w
		beq.w	Monitor_SonicLife
		cmpi.w	#200,(v_rings).w
		bcs.s	loc_B130
		bset	#2,(v_lifecount).w
		beq.w	Monitor_SonicLife

loc_B130:
		move.w	#sfx_Ring,d0
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------

Monitor_Shoes:
		move.b	#1,(v_shoes).w
		move.w	#60*20,(v_player+shoetime).w
		move.w	#$C00,(Sonic_top_speed).w
		move.w	#$18,(Sonic_acceleration).w
		move.w	#$80,(Sonic_deceleration).w
		move.w	#bgm_Speedup,d0
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------

Monitor_Shield:
		move.b	#1,(v_shield).w
		move.b	#id_Obj38,(v_shieldobj).w
		move.w	#sfx_Shield,d0
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------

Monitor_Invincibility:
		move.b	#1,(v_invinc).w
		move.w	#60*20,(v_player+invtime).w
		move.b	#id_Obj38,(v_starsobj1).w
		move.b	#1,(v_starsobj1+obAnim).w
		tst.b	(f_lockscreen).w
		bne.s	locret_B1A8
		cmpi.w	#12,(v_air).w
		bls.s	locret_B1A8
		move.w	#bgm_Invincible,d0
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------

locret_B1A8:
		rts
; ---------------------------------------------------------------------------

loc_B1AA:
		subq.w	#1,obTimeFrame(a0)
		bmi.w	DeleteObject
		bra.w	DisplaySprite