;----------------------------------------------------
; Object 0E - Sonic and Tails from the title screen
;----------------------------------------------------

Obj0E:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Obj0E_Index(pc,d0.w),d1
		jmp	Obj0E_Index(pc,d1.w)
; ---------------------------------------------------------------------------
Obj0E_Index:	dc.w loc_B38E-Obj0E_Index
		dc.w loc_B3D0-Obj0E_Index
		dc.w loc_B3E4-Obj0E_Index
		dc.w loc_B3FA-Obj0E_Index
; ---------------------------------------------------------------------------

loc_B38E:
		addq.b	#2,obRoutine(a0)
		move.w	#$148,obX(a0)	; this part of code loads Sonic on the Title Screen.
		move.w	#$C4,obScreenY(a0)
		move.l	#Map_Obj0E,obMap(a0)
		move.w	#make_art_tile(ArtTile_Title_Sonic_And_Tails,2,0),obGfx(a0)
		move.b	#1,obPriority(a0)
		move.b	#30-1,obDelayAni(a0)
		tst.b	obFrame(a0)	; are we on frame 0?
		beq.s	loc_B3D0	; if so, skip.
		move.w	#$FC,obX(a0)	; this part of code loads Tails on the Title Screen.
		move.w	#$CC,obScreenY(a0)
		move.w	#make_art_tile(ArtTile_Title_Sonic_And_Tails,1,0),obGfx(a0)

loc_B3D0:
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------
; Dead code from Sonic 1, remove or comment out the branch above to use the original code.
		subq.b	#1,obDelayAni(a0)
		bpl.s	locret_B3E2
		addq.b	#2,obRoutine(a0)
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

locret_B3E2:
		rts
; ---------------------------------------------------------------------------

; This is also dead code because the routine is never actually reached, therefore
; this routine goes unused.

; Oddly, this is actually less optimized than what Sonic 1 uses as the subi is a subq
; in Sonic 1, this could potentially be caused by the parameters for the compiler at the time.
loc_B3E4:
		subi.w	#8,obScreenY(a0)
		cmpi.w	#$96,obScreenY(a0)
		bne.s	loc_B3F6
		addq.b	#2,obRoutine(a0)

loc_B3F6:
		bra.w	DisplaySprite
; ---------------------------------------------------------------------------

; In Sonic 1, this would've been where the Title Character animations take place.
; It appears they just removed the code for animating the object.
loc_B3FA:
		bra.w	DisplaySprite