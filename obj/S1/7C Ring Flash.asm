;----------------------------------------------------
; Sonic	1 Object 7C - leftover giant flash when	you
;   collected the giant	ring
;----------------------------------------------------

Obj_S1Obj7C:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj_S1Obj7C_Index(pc,d0.w),d1
		jmp	Obj_S1Obj7C_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj_S1Obj7C_Index:dc.w loc_AB50-Obj_S1Obj7C_Index
		dc.w loc_AB7E-Obj_S1Obj7C_Index
		dc.w loc_ABE6-Obj_S1Obj7C_Index
; ---------------------------------------------------------------------------

loc_AB50:
		addq.b	#2,obRoutine(a0)
		move.l	#Map_S1Obj7C,obMap(a0)
		move.w	#make_art_tile(ArtTile_Giant_Ring_Flash,1,0),obGfx(a0)
		bsr.w	Adjust2PArtPointer
		ori.b	#4,obRender(a0)
		move.b	#0,obPriority(a0)
		move.b	#$20,obActWid(a0)
		move.b	#$FF,obFrame(a0)

loc_AB7E:
		bsr.s	sub_AB98
		out_of_range.w	DeleteObject
		bra.w	DisplaySprite

; =============== S U B	R O U T	I N E =======================================


sub_AB98:
		subq.b	#1,obTimeFrame(a0)
		bpl.s	locret_ABD6
		move.b	#1,obTimeFrame(a0)
		addq.b	#1,obFrame(a0)
		cmpi.b	#8,obFrame(a0)
		bcc.s	loc_ABD8
		cmpi.b	#3,obFrame(a0)
		bne.s	locret_ABD6
		movea.l	objoff_3C(a0),a1
		move.b	#6,obRoutine(a1)
		move.b	#$1C,(v_player+obAnim).w
		move.b	#1,(f_bigring).w
		clr.b	(v_invinc).w
		clr.b	(v_shield).w

locret_ABD6:
		rts
; ---------------------------------------------------------------------------

loc_ABD8:
		addq.b	#2,obRoutine(a0)
		move.w	#0,(v_player).w
		addq.l	#4,sp
		rts
; End of function sub_AB98

; ---------------------------------------------------------------------------

loc_ABE6:
		bra.w	DeleteObject