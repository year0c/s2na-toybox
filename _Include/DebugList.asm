DebugList:	dc.w Debug_GHZ-DebugList
		dc.w Debug_CPZ-DebugList
		dc.w Debug_CPZ-DebugList
		dc.w Debug_EHZ-DebugList
		dc.w Debug_HPZ-DebugList
		dc.w Debug_HTZ-DebugList
		dc.w Debug_HPZ-DebugList

dbug:	macro map,object,subtype,frame,vram
	dc.l map|(object<<24)
	dc.b subtype,frame
	dc.w vram
	endm

Debug_GHZ:	dc.w (Debug_GHZ_End-Debug_GHZ-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj26,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug 	Map_obj1F,	id_Obj1F,	0,	0,	make_art_tile(ArtTile_Crabmeat,0,0)
	dbug 	Map_obj22,	id_Obj22,	0,	0,	make_art_tile(ArtTile_Buzz_Bomber,0,0)
	dbug 	Map_Obj2B,	id_Obj2B,	0,	0,	make_art_tile(ArtTile_Chopper,0,0)
	dbug 	Map_Obj36,	id_Obj36,	0,	0,	make_art_tile(ArtTile_Spikes_GHZ,0,0)
	dbug 	Map_Obj18,	id_Obj18,	0,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug 	Map_Obj3B,	id_Obj3B,	0,	0,	make_art_tile(ArtTile_GHZ_Purple_Rock,3,0)
	dbug 	Map_obj40,	id_Obj40,	0,	0,	make_art_tile(ArtTile_Moto_Bug,0,0)
	dbug 	Map_obj41_GHZ,	id_Obj41,	0,	0,	make_art_tile(ArtTile_S1_Spring_Horizontal,0,0)
	dbug 	Map_obj42,	id_Obj42,	0,	0,	make_art_tile(ArtTile_Newtron,1,0)
	dbug 	Map_obj44,	id_Obj44,	0,	0,	make_art_tile(ArtTile_GHZ_Edge_Wall,2,0)
	; this is bugged, the VRAM should point to ArtTile_Lamppost
	dbug 	Map_Obj79,	id_Obj79,	1,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj03,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
Debug_GHZ_End:

Debug_CPZ:	dc.w (Debug_CPZ_End-Debug_CPZ-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj26,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug 	Map_obj41_GHZ,	id_Obj41,	0,	0,	make_art_tile(ArtTile_S1_Spring_Horizontal,0,0)
	; this is bugged, the VRAM is 100 bytes off from ArtTile_Ring, and isn't using the correct palette line
	dbug 	Map_Obj03,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring+$100,0,0)
	dbug 	Map_Obj0B,	id_Obj0B,	0,	0,	make_art_tile(ArtTile_Level,3,1)
	dbug 	Map_Obj0C,	id_Obj0C,	0,	0,	make_art_tile($418,3,1)
	dbug 	Map_Obj15_CPZ,	id_Obj15,	8,	0,	make_art_tile($418,1,0)
	dbug 	Map_Obj03,	id_Obj03,	9,	1,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj03,	id_Obj03,	$D,	5,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj19,	id_Obj19,	1,	0,	make_art_tile(ArtTile_CPZ_Platform,3,0)
	dbug 	Map_Obj36,	id_Obj36,	0,	0,	make_art_tile(ArtTile_Spikes,1,0)
	dbug 	Map_obj41,	id_Obj41,	$81,	0,	make_art_tile(ArtTile_Spring_Vertical,0,0)
	dbug 	Map_obj41,	id_Obj41,	$90,	3,	make_art_tile(ArtTile_Spring_Horizontal,0,0)
	dbug 	Map_obj41,	id_Obj41,	$A0,	6,	make_art_tile(ArtTile_Spring_Vertical,0,0)
	dbug 	Map_obj41,	id_Obj41,	$30,	7,	make_art_tile(ArtTile_Spring_Diagonal,0,0)
	dbug 	Map_obj41,	id_Obj41,	$40,	$A,	make_art_tile(ArtTile_Spring_Diagonal,0,0)
Debug_CPZ_End:

Debug_EHZ:	dc.w (Debug_EHZ_End-Debug_EHZ-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj26,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug 	Map_Obj79,	id_Obj79,	1,	0,	make_art_tile(ArtTile_Lamppost,0,0)
	dbug 	Map_Obj03,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj49,	id_Obj49,	0,	0,	make_art_tile(ArtTile_Waterfall,1,0)
	dbug 	Map_Obj49,	id_Obj49,	2,	3,	make_art_tile(ArtTile_Waterfall,1,0)
	dbug 	Map_Obj49,	id_Obj49,	4,	5,	make_art_tile(ArtTile_Waterfall,1,0)
	dbug 	Map_obj18_EHZ,	id_Obj18,	1,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug 	Map_obj18_EHZ,	id_Obj18,	$A,	1,	make_art_tile(ArtTile_Level,2,0)
	dbug 	Map_Obj36,	id_Obj36,	0,	0,	make_art_tile(ArtTile_Spikes,1,0)
	dbug 	Map_obj14,	id_Obj14,	0,	0,	make_art_tile(ArtTile_HTZ_Seesaw,0,0)
	dbug 	Map_obj41,	id_Obj41,	$81,	0,	make_art_tile(ArtTile_Spring_Vertical,0,0)
	dbug 	Map_obj41,	id_Obj41,	$90,	3,	make_art_tile(ArtTile_Spring_Horizontal,0,0)
	dbug 	Map_obj41,	id_Obj41,	$A0,	6,	make_art_tile(ArtTile_Spring_Vertical,0,0)
	dbug 	Map_obj41,	id_Obj41,	$30,	7,	make_art_tile(ArtTile_Spring_Diagonal,0,0)
	dbug 	Map_obj41,	id_Obj41,	$40,	$A,	make_art_tile(ArtTile_Spring_Diagonal,0,0)
	dbug 	Map_obj4B,	id_Obj4B,	0,	0,	make_art_tile(ArtTile_Buzzer,0,0)
	dbug 	Map_obj54,	id_Obj54,	0,	0,	make_art_tile(ArtTile_Snail,0,0)
	dbug 	Map_obj53,	id_Obj53,	0,	0,	make_art_tile(ArtTile_Masher,0,0)
Debug_EHZ_End:

	; unreferenced definitions
	dbug 	Map_obj4F,	id_Obj4F,	0,	0,	make_art_tile(ArtTile_Redz,0,0)
	dbug 	Map_Obj52,	id_Obj52,	0,	0,	make_art_tile(ArtTile_BFish,1,0)
	dbug 	Map_Obj50,	id_Obj50,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)
	dbug 	Map_Obj50,	id_Obj51,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)
	dbug 	Map_Obj4D,	id_Obj4D,	0,	0,	make_art_tile(ArtTile_Stegway,1,0)
	dbug 	Map_obj4B,	id_Obj4B,	0,	0,	make_art_tile(ArtTile_Early_Buzzer,0,0)
	dbug 	Map_Obj4E,	id_Obj4E,	0,	0,	make_art_tile(ArtTile_Gator,1,0)
	dbug 	Map_Obj4C,	id_Obj4C,	0,	0,	make_art_tile(ArtTile_Early_BBat,1,0)
	dbug 	Map_Obj4A,	id_Obj4A,	0,	0,	make_art_tile(ArtTile_Octus,1,0)

Debug_HTZ:	dc.w (Debug_HTZ_End-Debug_HTZ-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj26,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	dbug 	Map_Obj79,	id_Obj79,	1,	0,	make_art_tile(ArtTile_Lamppost,0,0)
	dbug 	Map_Obj03,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_obj18_EHZ,	id_Obj18,	1,	0,	make_art_tile(ArtTile_Level,2,0)
	dbug 	Map_obj18_EHZ,	id_Obj18,	$A,	1,	make_art_tile(ArtTile_Level,2,0)
	dbug 	Map_Obj36,	id_Obj36,	0,	0,	make_art_tile(ArtTile_Spikes,1,0)
	dbug 	Map_obj14,	id_Obj14,	0,	0,	make_art_tile(ArtTile_HTZ_Seesaw,0,0)
	dbug 	Map_obj41,	id_Obj41,	$81,	0,	make_art_tile(ArtTile_Spring_Vertical,0,0)
	dbug 	Map_obj41,	id_Obj41,	$90,	3,	make_art_tile(ArtTile_Spring_Horizontal,0,0)
	dbug 	Map_obj41,	id_Obj41,	$A0,	6,	make_art_tile(ArtTile_Spring_Vertical,0,0)
	dbug 	Map_obj41,	id_Obj41,	$30,	7,	make_art_tile(ArtTile_Spring_Diagonal,0,0)
	dbug 	Map_obj41,	id_Obj41,	$40,	$A,	make_art_tile(ArtTile_Spring_Diagonal,0,0)
	dbug 	Map_Obj16,	id_Obj16,	0,	0,	make_art_tile(ArtTile_HtzZipline,2,0)
	dbug 	Map_Obj16,	id_Obj1C,	4,	1,	make_art_tile(ArtTile_HtzZipline,2,0)
	dbug 	Map_Obj16,	id_Obj1C,	5,	2,	make_art_tile(ArtTile_HtzZipline,2,0)
	dbug 	Map_obj4B,	id_Obj4B,	0,	0,	make_art_tile(ArtTile_Buzzer,0,0)
	dbug 	Map_obj54,	id_Obj54,	0,	0,	make_art_tile(ArtTile_Snail,0,0)
	dbug 	Map_obj53,	id_Obj53,	0,	0,	make_art_tile(ArtTile_Masher,0,0)
Debug_HTZ_End:

Debug_HPZ:	dc.w (Debug_HPZ_End-Debug_HPZ-2)/8
;		mappings	object		subtype	frame	VRAM setting
	dbug 	Map_Ring,	id_Obj25,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_Obj26,	id_Obj26,	0,	0,	make_art_tile(ArtTile_Monitor,0,0)
	; this is bugged, it's not using the right VRAM location ($35A)
	dbug 	Map_Obj1C_01,	id_Obj1C,	$21,	3,	make_art_tile($485,3,1)
	; this is bugged, it's not using the right VRAM location (ArtTile_HPZ_Waterfall)
	dbug 	Map_Obj13,	id_Obj13,	4,	4,	make_art_tile($415,3,1)
	; this is bugged, it's not using the right VRAM location ($34A)
	dbug 	Map_Obj1A_HPZ,	id_Obj1A,	0,	0,	make_art_tile($475,2,0)
	dbug 	Map_Obj03,	id_Obj03,	0,	0,	make_art_tile(ArtTile_Ring,1,0)
	dbug 	Map_obj4F,	id_Obj4F,	0,	0,	make_art_tile(ArtTile_Redz,0,0)
	dbug 	Map_Obj52,	id_Obj52,	0,	0,	make_art_tile(ArtTile_BFish,1,0)
	dbug 	Map_Obj50,	id_Obj50,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)
	dbug 	Map_Obj50,	id_Obj51,	0,	0,	make_art_tile(ArtTile_Aquis,1,0)
	dbug 	Map_Obj4D,	id_Obj4D,	0,	0,	make_art_tile(ArtTile_Stegway,1,0)
	dbug 	Map_obj4B,	id_Obj4B,	0,	0,	make_art_tile(ArtTile_Early_Buzzer,0,0)
	dbug 	Map_Obj4E,	id_Obj4E,	0,	0,	make_art_tile(ArtTile_Gator,1,0)
	dbug 	Map_Obj4C,	id_Obj4C,	0,	0,	make_art_tile(ArtTile_Early_BBat,1,0)
	dbug 	Map_Obj4A,	id_Obj4A,	0,	0,	make_art_tile(ArtTile_Octus,1,0)
Debug_HPZ_End:
