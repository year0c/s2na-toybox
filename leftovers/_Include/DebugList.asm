DebugList_PB:	dc.w Debug_GHZ_PB-DebugList_PB
		dc.w Debug_CPZ_PB-DebugList_PB
		dc.w Debug_CPZ_PB-DebugList_PB
		dc.w Debug_EHZ_PB-DebugList_PB
		dc.w Debug_HPZ_PB-DebugList_PB
		dc.w Debug_HPZ_PB-DebugList_PB
		dc.w Debug_HPZ_PB-DebugList_PB

Debug_GHZ_PB:	dc.w (Debug_GHZ_PB_End-Debug_GHZ_PB-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring_PB,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj26_PB,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug 	Map_obj1F_PB,	id_Obj1F,	0,	0,	make_art_tile(ArtTile_Crabmeat,0,0)
	dbug 	Map_obj22_PB,	id_Obj22,	0,	0,	make_art_tile(ArtTile_Buzz_Bomber,0,0)
	dbug 	Map_Obj2B_PB,	id_Obj2B,	0,	0,	make_art_tile(ArtTile_Chopper,0,0)
	dbug 	Map_Obj36_PB,	id_Obj36,	0,	0,	make_art_tile(ArtTile_S1_Spikes,0,0)
	dbug 	Map_Obj18_GHZ_PB,	id_Obj18,	0,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug 	Map_Obj3B_PB,	id_Obj3B,	0,	0,	make_art_tile(ArtTile_GHZ_Purple_Rock,3,0)
	dbug 	Map_obj40_PB,	id_Obj40,	0,	0,	make_art_tile(ArtTile_Moto_Bug,0,0)
	dbug 	Map_obj41_GHZ_PB,	id_Obj41,	0,	0,	make_art_tile(ArtTile_S1_Spring_Horizontal,0,0)
	dbug 	Map_obj42_PB,	id_Obj42,	0,	0,	make_art_tile(ArtTile_Newtron,1,0)
	dbug 	Map_obj44_PB,	id_Obj44,	0,	0,	make_art_tile(ArtTile_GHZ_Edge_Wall,2,0)
	dbug 	Map_Obj79_PB,	id_Obj79,	1,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj03_PB,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
Debug_GHZ_PB_End:

Debug_CPZ_PB:	dc.w (Debug_CPZ_PB_End-Debug_CPZ_PB-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring_PB,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj26_PB,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug 	Map_obj41_GHZ_PB,	id_Obj41,	0,	0,	make_art_tile(ArtTile_S1_Spring_Horizontal,0,0)
	dbug 	Map_Obj03_PB,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring+$100,0,0)
	dbug 	Map_Obj0B_PB,	id_Obj0B,	0,	0,	make_art_tile(ArtTile_Level,3,1)
	dbug 	Map_Obj0C_PB,	id_Obj0C,	0,	0,	make_art_tile(ArtTile_CPZ_Float_Platform,3,1)
	dbug 	Map_Obj15_CPZ_PB,	id_Obj15,	8,	0,	make_art_tile(ArtTile_CPZ_Float_Platform,1,0)
Debug_CPZ_PB_End:

Debug_EHZ_PB:	dc.w (Debug_EHZ_PB_End-Debug_EHZ_PB-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring_PB,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj26_PB,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug 	Map_Obj79_PB,	id_Obj79,	1,	0,	make_art_tile(ArtTile_Lamppost,0,0)
	dbug 	Map_Obj03_PB,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj49_PB,	id_Obj49,	0,	0,	make_art_tile(ArtTile_Waterfall,1,0)
	dbug 	Map_Obj49_PB,	id_Obj49,	2,	3,	make_art_tile(ArtTile_Waterfall,1,0)
	dbug 	Map_Obj18_EHZ_PB,	id_Obj18,	1,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug 	Map_Obj18_EHZ_PB,	id_Obj18,	$A,	1,	make_art_tile(ArtTile_Level,2,0)
	dbug 	Map_Obj36_PB,	id_Obj36,	0,	0,	make_art_tile(ArtTile_Spikes,1,0)
	dbug 	Map_Obj14_PB,	id_Obj14,	0,	0,	make_art_tile(ArtTile_HTZ_Seesaw,0,0)
	dbug 	Map_obj41_PB,	id_Obj41,	$80,	0,	make_art_tile(ArtTile_Spring_Vertical,0,0)
	dbug 	Map_obj41_PB,	id_Obj41,	$90,	3,	make_art_tile(ArtTile_Spring_Horizontal,0,0)
	dbug 	Map_obj41_PB,	id_Obj41,	$A0,	6,	make_art_tile(ArtTile_Spring_Vertical,0,0)
	dbug 	Map_obj41_PB,	id_Obj41,	$30,	7,	make_art_tile(ArtTile_Spring_Diagonal,0,0)
	dbug 	Map_obj41_PB,	id_Obj41,	$40,	$A,	make_art_tile(ArtTile_Spring_Diagonal,0,0)
	dbug 	Map_Obj4B_PB,	id_Obj4B,	0,	0,	make_art_tile(ArtTile_Buzzer,0,0)
	dbug 	Map_Obj54_PB,	id_Obj54,	0,	0,	make_art_tile(ArtTile_Snail,0,0)
	dbug 	Map_Obj53_PB,	id_Obj53,	0,	0,	make_art_tile(ArtTile_Masher,0,0)
Debug_EHZ_PB_End:

; unreferenced definitions
	dbug 	Map_Obj4F_PB,	id_Obj4F,	0,	0,	make_art_tile(ArtTile_Redz,0,0)
	dbug 	Map_Obj52_PB,	id_Obj52,	0,	0,	make_art_tile(ArtTile_BFish,1,0)
	dbug 	Map_Obj50_PB,	id_Obj50,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)
	dbug 	Map_Obj50_PB,	id_Obj51,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)
	dbug 	Map_Obj4D_PB,	id_Obj4D,	0,	0,	make_art_tile(ArtTile_Stegway,1,0)
	dbug 	Map_Obj4B_PB,	id_Obj4B,	0,	0,	make_art_tile(ArtTile_Early_Buzzer,0,0)
	dbug 	Map_Obj4E_PB,	id_Obj4E,	0,	0,	make_art_tile(ArtTile_Gator,1,0)
	dbug 	Map_Obj4C_PB,	id_Obj4C,	0,	0,	make_art_tile(ArtTile_Early_BBat,1,0)
	dbug 	Map_Obj4A_PB,	id_Obj4A,	0,	0,	make_art_tile(ArtTile_Octus,1,0)

Debug_HPZ_PB:	dc.w (Debug_HPZ_PB_End-Debug_HPZ_PB-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring_PB,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj26_PB,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug 	Map_Obj1C_01_PB,	id_Obj1C,	$21,	3,	make_art_tile(ArtTile_HPZ_Orb+$12B,3,1)
	dbug 	Map_Obj13_PB,	id_Obj13,	4,	4,	make_art_tile(ArtTile_HPZ_Waterfall+$100,3,1)
	dbug 	Map_Obj1A_HPZ_PB,	id_Obj1A,	0,	0,	make_art_tile(ArtTile_HPZ_Platform+$12B,2,0)
	dbug 	Map_Obj03_PB,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj4F_PB,	id_Obj4F,	0,	0,	make_art_tile(ArtTile_Redz,0,0)
	dbug 	Map_Obj52_PB,	id_Obj52,	0,	0,	make_art_tile(ArtTile_BFish,1,0)
	dbug 	Map_Obj50_PB,	id_Obj50,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)
	dbug 	Map_Obj50_PB,	id_Obj51,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)
	dbug 	Map_Obj4D_PB,	id_Obj4D,	0,	0,	make_art_tile(ArtTile_Stegway,1,0)
	dbug 	Map_Obj4B_PB,	id_Obj4B,	0,	0,	make_art_tile(ArtTile_Early_Buzzer,0,0)
	dbug 	Map_Obj4E_PB,	id_Obj4E,	0,	0,	make_art_tile(ArtTile_Gator,1,0)
	dbug 	Map_Obj4C_PB,	id_Obj4C,	0,	0,	make_art_tile(ArtTile_Early_BBat,1,0)
	dbug 	Map_Obj4A_PB,	id_Obj4A,	0,	0,	make_art_tile(ArtTile_Octus,1,0)
Debug_HPZ_PB_End:
