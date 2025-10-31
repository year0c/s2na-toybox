;----------------------------------------------------
; Object 04 - water surface
;----------------------------------------------------

Obj04:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj04_Index(pc,d0.w),d1
		jmp	Obj04_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj04_Index:	dc.w Obj04_Init-Obj04_Index
		dc.w Obj04_Main-Obj04_Index
; ---------------------------------------------------------------------------

Obj04_Init:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Obj04,obMap(a0)
		move.w	#make_art_tile(ArtTile_Water_Surface,0,1),obGfx(a0)
		bsr.w	j_Adjust2PArtPointer_0
		move.b	#4,obRender(a0)
		move.b	#$80,obActWid(a0)
		move.w	obX(a0),objoff_30(a0)

Obj04_Main:
		move.w	(v_waterpos1).w,d1
		move.w	d1,obY(a0)
		tst.b	objoff_32(a0)
		bne.s	loc_15530
		btst	#bitStart,(v_jpadpress1).w
		beq.s	loc_15540
		addq.b	#3,obFrame(a0)
		move.b	#1,objoff_32(a0)
		bra.s	loc_15540
; ---------------------------------------------------------------------------

loc_15530:
		tst.w	(f_pause).w
		bne.s	loc_15540
		move.b	#0,objoff_32(a0)
		subq.b	#3,obFrame(a0)

loc_15540:
		lea	(Obj04_FrameData).l,a1
		moveq	#0,d1
		move.b	obAniFrame(a0),d1
		move.b	(a1,d1.w),obFrame(a0)
		addq.b	#1,obAniFrame(a0)
		andi.b	#$3F,obAniFrame(a0)
		bra.w	loc_15868