DebugList_PB:	dc.w Debug_GHZ_PB-DebugList_PB
		dc.w Debug_CPZ_PB-DebugList_PB
		dc.w Debug_CPZ_PB-DebugList_PB
		dc.w Debug_EHZ_PB-DebugList_PB
		dc.w Debug_HPZ_PB-DebugList_PB
		dc.w Debug_HPZ_PB-DebugList_PB
		dc.w Debug_HPZ_PB-DebugList_PB

Debug_GHZ_PB:	dc.w (Debug_GHZ_PB_End-Debug_GHZ_PB-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	$A54A,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)	;	Map_Ring
	dbug 	$ABF0,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)	;	Map_Obj26
	dbug 	$9C84,	id_Obj1F,	0,	0,	make_art_tile(ArtTile_Crabmeat,0,0)	;	Map_obj1F
	dbug 	$9FC2,	id_Obj22,	0,	0,	make_art_tile(ArtTile_Buzz_Bomber,0,0)	;	Map_obj22
	dbug 	$B11E,	id_Obj2B,	0,	0,	make_art_tile(ArtTile_Chopper,0,0)	;	Map_Obj2B
	dbug 	$C17E,	id_Obj36,	0,	0,	make_art_tile(ArtTile_S1_Spikes,0,0)	;	Map_Obj36
	dbug 	$84AE,	id_Obj18,	0,	0,	make_art_tile(ArtTile_Level,2,0)	;	Map_Obj18_GHZ
	dbug 	$C202,	id_Obj3B,	0,	0,	make_art_tile(ArtTile_GHZ_Purple_Rock,3,0)	;	Map_Obj3B
	dbug 	$EA80,	id_Obj40,	0,	0,	make_art_tile(ArtTile_Moto_Bug,0,0)	;	Map_obj40
	dbug 	$E0B4,	id_Obj41,	0,	0,	make_art_tile(ArtTile_S1_Spring_Horizontal,0,0)	;	Map_obj41_GHZ
	dbug 	$E4A8,	id_Obj42,	0,	0,	make_art_tile(ArtTile_Newtron,1,0)	;	Map_obj42
	dbug 	$E640,	id_Obj44,	0,	0,	make_art_tile(ArtTile_GHZ_Edge_Wall,2,0)	;	Map_obj44
	dbug 	$12D74,	id_Obj79,	1,	0,	make_art_tile(ArtTile_Ring,1,0)	;	Map_Obj79
	dbug 	$13602,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring,1,0)	;	Map_Obj03
Debug_GHZ_PB_End:

Debug_CPZ_PB:	dc.w (Debug_CPZ_PB_End-Debug_CPZ_PB-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	$A54A,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)	;	Map_Ring
	dbug 	$ABF0,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)	;	Map_Obj26
	dbug 	$E0B4,	id_Obj41,	0,	0,	make_art_tile(ArtTile_S1_Spring_Horizontal,0,0)	;	Map_obj41_GHZ
	dbug 	$13602,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring+$100,0,0)	;	Map_Obj03
	dbug 	$13736,	id_Obj0B,	0,	0,	make_art_tile(ArtTile_Level,3,1)	;	Map_Obj0B
	dbug 	$1385E,	id_Obj0C,	0,	0,	make_art_tile(ArtTile_CPZ_Float_Platform,3,1)	;	Map_Obj0C
	dbug 	$7EDA,	id_Obj15,	8,	0,	make_art_tile(ArtTile_CPZ_Float_Platform,1,0)	;	Map_Obj15_CPZ
Debug_CPZ_PB_End:

Debug_EHZ_PB:	dc.w (Debug_EHZ_PB_End-Debug_EHZ_PB-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	$A54A,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)	;	Map_Ring
	dbug 	$ABF0,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)	;	Map_Obj26
	dbug 	$12D74,	id_Obj79,	1,	0,	make_art_tile(ArtTile_Lamppost,0,0)	;	Map_Obj79
	dbug 	$13602,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring,1,0)	;	Map_Obj03
	dbug 	$147F6,	id_Obj49,	0,	0,	make_art_tile(ArtTile_Waterfall,1,0)	;	Map_Obj49
	dbug 	$147F6,	id_Obj49,	2,	3,	make_art_tile(ArtTile_Waterfall,1,0)	;	Map_Obj49
	dbug 	$8556,	id_Obj18,	1,	0,	make_art_tile(ArtTile_Level,2,0)	;	Map_Obj18_EHZ
	dbug 	$8556,	id_Obj18,	$A,	1,	make_art_tile(ArtTile_Level,2,0)	;	Map_Obj18_EHZ
	dbug 	$C17E,	id_Obj36,	0,	0,	make_art_tile(ArtTile_Spikes,1,0)	;	Map_Obj36
	dbug 	$144EC,	id_Obj14,	0,	0,	make_art_tile(ArtTile_HTZ_Seesaw,0,0)	;	Map_obj14
	dbug 	$E12C,	id_Obj41,	$80,	0,	make_art_tile(ArtTile_Spring_Vertical,0,0)	;	Map_obj41
	dbug 	$E12C,	id_Obj41,	$90,	3,	make_art_tile(ArtTile_Spring_Horizontal,0,0)	;	Map_obj41
	dbug 	$E12C,	id_Obj41,	$A0,	6,	make_art_tile(ArtTile_Spring_Vertical,0,0)	;	Map_obj41
	dbug 	$E12C,	id_Obj41,	$30,	7,	make_art_tile(ArtTile_Spring_Diagonal,0,0)	;	Map_obj41
	dbug 	$E12C,	id_Obj41,	$40,	$A,	make_art_tile(ArtTile_Spring_Diagonal,0,0)	;	Map_obj41
	dbug 	$15A34,	id_Obj4B,	0,	0,	make_art_tile(ArtTile_Buzzer,0,0)	;	Map_obj4B
	dbug 	$16838,	id_Obj54,	0,	0,	make_art_tile(ArtTile_Snail,0,0)	;	Map_obj54
	dbug 	$165A6,	id_Obj53,	0,	0,	make_art_tile(ArtTile_Masher,0,0)	;	Map_obj53
Debug_EHZ_PB_End:

; unreferenced definitions
	dbug 	$14F16,	id_Obj4F,	0,	0,	make_art_tile(ArtTile_Redz,0,0)	;	Map_obj4F
	dbug 	$14DB2,	id_Obj52,	0,	0,	make_art_tile(ArtTile_BFish,1,0)	;	Map_Obj52
	dbug 	$1542C,	id_Obj50,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)	;	Map_Obj50
	dbug 	$1542C,	id_Obj51,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)	;	Map_Obj50
	dbug 	$14A3A,	id_Obj4D,	0,	0,	make_art_tile(ArtTile_Stegway,1,0)	;	Map_Obj4D
	dbug 	$15A34,	id_Obj4B,	0,	0,	make_art_tile(ArtTile_Early_Buzzer,0,0)	;	Map_obj4B
	dbug 	$16330,	id_Obj4E,	0,	0,	make_art_tile(ArtTile_Gator,1,0)	;	Map_Obj4E
	dbug 	$16016,	id_Obj4C,	0,	0,	make_art_tile(ArtTile_Early_BBat,1,0)	;	Map_Obj4C
	dbug 	$15CCC,	id_Obj4A,	0,	0,	make_art_tile(ArtTile_Octus,1,0)	;	Map_Obj4A

Debug_HPZ_PB:	dc.w (Debug_HPZ_PB_End-Debug_HPZ_PB-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	$A54A,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)	;	Map_Ring
	dbug 	$ABF0,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)	;	Map_Obj26
	dbug 	$8E04,	id_Obj1C,	$21,	3,	make_art_tile(ArtTile_HPZ_Orb+$12B,3,1)	;	Map_Obj1C_01
	dbug 	$13A6C,	id_Obj13,	4,	4,	make_art_tile(ArtTile_HPZ_Waterfall+$100,3,1)	;	Map_Obj13
	dbug 	$8C64,	id_Obj1A,	0,	0,	make_art_tile(ArtTile_HPZ_Platform+$12B,2,0)	;	Map_Obj1A_HPZ
	dbug 	$13602,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring,1,0)	;	Map_Obj03
	dbug 	$14F16,	id_Obj4F,	0,	0,	make_art_tile(ArtTile_Redz,0,0)	;	Map_obj4F
	dbug 	$14DB2,	id_Obj52,	0,	0,	make_art_tile(ArtTile_BFish,1,0)	;	Map_Obj52
	dbug 	$1542C,	id_Obj50,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)	;	Map_Obj50
	dbug 	$1542C,	id_Obj51,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)	;	Map_Obj50
	dbug 	$14A3A,	id_Obj4D,	0,	0,	make_art_tile(ArtTile_Stegway,1,0)	;	Map_Obj4D
	dbug 	$15A34,	id_Obj4B,	0,	0,	make_art_tile(ArtTile_Early_Buzzer,0,0)	;	Map_obj4B
	dbug 	$16330,	id_Obj4E,	0,	0,	make_art_tile(ArtTile_Gator,1,0)	;	Map_Obj4E
	dbug 	$16016,	id_Obj4C,	0,	0,	make_art_tile(ArtTile_Early_BBat,1,0)	;	Map_Obj4C
	dbug 	$15CCC,	id_Obj4A,	0,	0,	make_art_tile(ArtTile_Octus,1,0)	;	Map_Obj4A
Debug_HPZ_PB_End:
