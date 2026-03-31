; ---------------------------------------------------------------------------
; PATTERN LOAD REQUEST LISTS
;
; Pattern load request lists are simple structures used to load
; Nemesis-compressed art for sprites.
;
; The decompressor predictably moves down the list, so request 0 is processed first, etc.
; This only matters if your addresses are bad and you overwrite art loaded in a previous request.
;

; NOTICE: The load queue buffer can only hold $10 (16) load requests. None of the routines
; that load PLRs into the queue do any bounds checking, so it's possible to create a buffer
; overflow and completely screw up the variables stored directly after the queue buffer.
; (in my experience this is a guaranteed crash or hang)
;
; Many levels queue more than 16 items overall, but they don't exceed the limit because
; their PLRs are split into multiple parts (like PLC_GHZ and PLC_GHZ2) and they fully
; process the first part before requesting the rest.
; ---------------------------------------------------------------------------

;---------------------------------------------------------------------------------------
; Table of pattern load request lists. Remember to use word-length data when adding lists
; otherwise you'll break the array.
;---------------------------------------------------------------------------------------
ArtLoadCues_PB:

		dc.w PLC_Main_PB-ArtLoadCues_PB
		dc.w PLC_Main2_PB-ArtLoadCues_PB
		dc.w PLC_Explode_PB-ArtLoadCues_PB
		dc.w PLC_GameOver_PB-ArtLoadCues_PB
PLC_Levels_PB:
		dc.w PLC_GHZ_PB-ArtLoadCues_PB
		dc.w PLC_GHZ2_PB-ArtLoadCues_PB
		dc.w PLC_CPZ_PB-ArtLoadCues_PB
		dc.w PLC_CPZ2_PB-ArtLoadCues_PB
		dc.w PLC_CPZ_PB-ArtLoadCues_PB
		dc.w PLC_CPZ2_PB-ArtLoadCues_PB
		dc.w PLC_EHZ_PB-ArtLoadCues_PB
		dc.w PLC_EHZ2_PB-ArtLoadCues_PB
		dc.w PLC_HPZ_PB-ArtLoadCues_PB
		dc.w PLC_HPZ2_PB-ArtLoadCues_PB
		dc.w PLC_CPZ_PB-ArtLoadCues_PB
		dc.w PLC_CPZ2_PB-ArtLoadCues_PB

		dc.w PLC_S1TitleCard_PB-ArtLoadCues_PB
		dc.w PLC_Boss_PB-ArtLoadCues_PB
		dc.w PLC_Signpost_PB-ArtLoadCues_PB
		dc.w PLC_S1SpecialStage_PB-ArtLoadCues_PB
		dc.w PLC_S1SpecialStage_PB-ArtLoadCues_PB
PLC_Animals_PB:
		dc.w PLC_GHZAnimals_PB-ArtLoadCues_PB
		dc.w PLC_LZAnimals_PB-ArtLoadCues_PB
		dc.w PLC_CPZAnimals_PB-ArtLoadCues_PB
		dc.w PLC_EHZAnimals_PB-ArtLoadCues_PB
		dc.w PLC_HPZAnimals_PB-ArtLoadCues_PB
		dc.w PLC_HTZAnimals_PB-ArtLoadCues_PB

		dc.w $1C318-ArtLoadCues_PB
		dc.w $1C31A-ArtLoadCues_PB
		dc.w $1C31C-ArtLoadCues_PB
		dc.w $1C31E-ArtLoadCues_PB
		dc.w $1C320-ArtLoadCues_PB

; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Standard 1 - loaded for every level
; --------------------------------------------------------------------------------------
PLC_Main_PB:	dc.w ((PLC_Main_PB_End-PLC_Main_PB)/6)-1
		plcm	$A6A58, ArtTile_Lamppost	;	Nem_Lamppost
		plcm	$A61F2, ArtTile_HUD	;	Nem_HUD
		plcm	$A62FA, ArtTile_Lives_Counter	;	Nem_Lives
		plcm	$A6410, ArtTile_Ring	;	Nem_Ring
		plcm	$A697E, ArtTile_Points	;	Nem_Points
PLC_Main_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Standard 2 - loaded for every level
; --------------------------------------------------------------------------------------
PLC_Main2_PB:	dc.w ((PLC_Main2_PB_End-PLC_Main2_PB)/6)-1
		plcm	$A6504, ArtTile_Monitor	;	Nem_Monitors
		plcm	$9DF8E, ArtTile_Shield	;	Nem_Shield
		plcm	$9E114, ArtTile_Invincibility	;	Nem_Stars
PLC_Main2_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Explosion - loaded for every level AFTER the title card
; --------------------------------------------------------------------------------------
PLC_Explode_PB:	dc.w ((PLC_Explode_PB_End-PLC_Explode_PB)/6)-1
		plcm	$AF10A, ArtTile_Explosion	;	Nem_Explosion
PLC_Explode_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Game/Time over
; --------------------------------------------------------------------------------------
PLC_GameOver_PB:	dc.w ((PLC_GameOver_PB_End-PLC_GameOver_PB)/6)-1
		plcm	$AF770, ArtTile_Game_Over	;	Nem_GameOver
PLC_GameOver_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Green Hill Zone primary
; --------------------------------------------------------------------------------------
PLC_GHZ_PB:	dc.w ((PLC_GHZ_PB_End-PLC_GHZ_PB)/6)-1
		plcm	$D5DB2, ArtTile_Level	;	Nem_GHZ
		plcm	$AC90E, ArtTile_Chopper	;	Nem_Chopper
		plcm	$A692E, ArtTile_Spikes_GHZ	;	Nem_VSpikes
		plcm	$AF902, ArtTile_S1_Spring_Horizontal	;	Nem_HSpring
		plcm	$AFA04, ArtTile_S1_Spring_Vertical	;	Nem_VSpring
		plcm	$A394E, ArtTile_GHZ_Bridge	;	Nem_GHZ_Bridge
		plcm	$A3834, ArtTile_GHZ_Swing	;	Nem_SwingPlatform
		plcm	$AD324, ArtTile_Moto_Bug	;	Nem_Motobug
		plcm	$A3F60, ArtTile_GHZ_Purple_Rock	;	Nem_GHZ_Rock
PLC_GHZ_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Green Hill Zone secondary
; --------------------------------------------------------------------------------------
PLC_GHZ2_PB:	dc.w ((PLC_GHZ2_PB_End-PLC_GHZ2_PB)/6)-1
		plcm	$AC90E, ArtTile_Chopper	;	Nem_Chopper
PLC_GHZ2_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Chemical Plant Zone primary
; --------------------------------------------------------------------------------------
PLC_CPZ_PB:	dc.w ((PLC_CPZ_PB_End-PLC_CPZ_PB)/6)-1
		plcm	$CA3AE, ArtTile_Level	;	Nem_CPZ
		plcm	$CCD56, ArtTile_CPZ_Buildings	;	Nem_CPZ_Buildings
		plcm	$A57E4, ArtTile_CPZ_Platform	;	Nem_CPZ_FloatingPlatform
		plcm	$A5904, $418	;	dai0dcg
		plcm	$A5BF0, $440	;	nami0dcg
PLC_CPZ_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Emerald Hill Zone primary
; --------------------------------------------------------------------------------------
PLC_EHZ_PB:	dc.w ((PLC_EHZ_PB_End-PLC_EHZ_PB)/6)-1
		plcm	$B2174, ArtTile_Level	;	Nem_EHZ
		plcm	$A418C, ArtTile_Fireball	;	Nem_EHZ_Fireball
		plcm	$A43D2, ArtTile_Waterfall	;	Nem_EHZ_Waterfall
		plcm	$A4626, ArtTile_EHZ_Bridge	;	Nem_EHZ_Bridge
		plcm	$A4A6A, ArtTile_HTZ_Seesaw	;	Nem_HTZ_Seesaw
		plcm	$A692E, ArtTile_Spikes	;	Nem_VSpikes
		plcm	$A601E, ArtTile_Spring_Diagonal	;	Nem_DSpring
		plcm	$A5E38, ArtTile_Spring_Vertical	;	Nem_VSpring2
		plcm	$A5F54, ArtTile_Spring_Horizontal	;	Nem_HSpring2
PLC_EHZ_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Emerald Hill Zone secondary
; --------------------------------------------------------------------------------------
PLC_EHZ2_PB:	dc.w ((PLC_EHZ2_PB_End-PLC_EHZ2_PB)/6)-1
		plcm	$A6EA0, ArtTile_Buzzer	;	Nem_Buzzer
		plcm	$A8EF8, ArtTile_Snail	;	Nem_Snail
		plcm	$A9476, ArtTile_Masher	;	Nem_Masher
PLC_EHZ2_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hidden Palace Zone primary
; --------------------------------------------------------------------------------------
PLC_HPZ_PB:	dc.w ((PLC_HPZ_PB_End-PLC_HPZ_PB)/6)-1
		plcm	$BE58C, ArtTile_Level	;	Nem_HPZ
		plcm	$A4C02, ArtTile_HPZ_Bridge	;	Nem_HPZ_Bridge
		plcm	$A4D7A, ArtTile_HPZ_Waterfall	;	Nem_HPZ_Waterfall
		plcm	$A534E, ArtTile_HPZ_Platform	;	Nem_HPZ_Platform
		plcm	$A540E, ArtTile_HPZ_Orb	;	Nem_HPZ_PulsingBall
		plcm	$A564A, ArtTile_HPZ_Various	;	Nem_HPZ_Various
		plcm	$A50DC, ArtTile_HPZ_Emerald	;	Nem_HPZ_Emerald
		plcm	$A5BF0, ArtTile_Water_Surface	;	Nem_WaterSurface
PLC_HPZ_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hidden Palace Zone secondary
; --------------------------------------------------------------------------------------
PLC_HPZ2_PB:	dc.w ((PLC_HPZ2_PB_End-PLC_HPZ2_PB)/6)-1
		plcm	$A7AF8, ArtTile_Redz	;	Nem_Redz
		plcm	$A7086, ArtTile_BBat	;	Nem_BBat
PLC_HPZ2_PB_End:
		; unused PLR entries
		plcm	$A6AFE, ArtTile_Gator	;	Nem_Gator
		plcm	$A6EA0, ArtTile_Early_Buzzer	;	Nem_Buzzer
		plcm	$A7086, ArtTile_Early_BBat	;	Nem_BBat
		plcm	$A76FC, ArtTile_Stegway	;	Nem_Stegway
		plcm	$A7AF8, ArtTile_Redz	;	Nem_Redz
		plcm	$A7ECE, ArtTile_BFish	;	Nem_BFish
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Chemical Plant Zone secondary
; --------------------------------------------------------------------------------------
PLC_CPZ2_PB:	dc.w ((PLC_CPZ2_PB_End-PLC_CPZ2_PB)/6)-1
		plcm	$A692E, ArtTile_Spikes_GHZ	;	Nem_VSpikes
		plcm	$AF902, ArtTile_S1_Spring_Horizontal	;	Nem_HSpring
		plcm	$AFA04, ArtTile_S1_Spring_Vertical	;	Nem_VSpring
PLC_CPZ2_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Sonic 1 title card
; --------------------------------------------------------------------------------------
PLC_S1TitleCard_PB:dc.w ((PLC_S1TitleCard_PB_End-PLC_S1TitleCard_PB)/6)-1
		plcm	$AEAFC, ArtTile_Title_Card	;	Nem_TitleCard
PLC_S1TitleCard_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; End of zone bosses
; --------------------------------------------------------------------------------------
PLC_Boss_PB:	dc.w ((PLC_Boss_PB_End-PLC_Boss_PB)/6)-1
		plcm	$A9682, ArtTile_ArtNem_Eggpod_1	;	Nem_BossShip
		plcm	$AAB08, ArtTile_ArtNem_EHZBoss	;	Nem_EHZ_Boss
		plcm	$AB2F4, ArtTile_ArtNem_EggChoppers	;	Nem_EHZ_Boss_Blades
PLC_Boss_PB_End:
; unused PLC entries
		plcm	$A9682, $400	;	Nem_BossShip
		plcm	$A9DBE, $460	;	Nem_CPZ_ProtoBoss
		plcm	$AA9A4, $4D0	;	Nem_BossShipBoost
		plcm	$AAA22, $4D8	;	Nem_Smoke
		plcm	$AAB08, $4E8	;	Nem_EHZ_Boss
		plcm	$AB2F4, $568	;	Nem_EHZ_Boss_Blades
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; End of level signpost
; --------------------------------------------------------------------------------------
PLC_Signpost_PB:	dc.w ((PLC_Signpost_PB_End-PLC_Signpost_PB)/6)-1
		plcm	$AFAE0, ArtTile_Signpost	;	Nem_Signpost
		plcm	$B00D0, ArtTile_Hidden_Points	;	Nem_BonusPoints
		plcm	$AFF5C, ArtTile_Giant_Ring_Flash	;	Nem_BigFlash
PLC_Signpost_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Sonic 1 Special Stage, although since it's blank, using it will crash the game
; --------------------------------------------------------------------------------------
; PLC_Invalid:
PLC_S1SpecialStage_PB:
		dc.w ((PLC_S1SpecialStage_PB_End-PLC_S1SpecialStage_PB)/6)+$10
PLC_S1SpecialStage_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Green Hill Zone animals
; --------------------------------------------------------------------------------------
PLC_GHZAnimals_PB:	dc.w ((PLC_GHZAnimals_PB_End-PLC_GHZAnimals_PB)/6)-1
		plcm	$B08BC, ArtTile_Animal_1	;	Nem_Bunny
		plcm	$B0F3E, ArtTile_Animal_2	;	Nem_Flicky
PLC_GHZAnimals_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Labyrinth Zone animals
; --------------------------------------------------------------------------------------
PLC_LZAnimals_PB:	dc.w ((PLC_LZAnimals_PB_End-PLC_LZAnimals_PB)/6)-1
		plcm	$B0B70, ArtTile_Animal_1	;	Nem_Penguin
		plcm	$B0CEC, ArtTile_Animal_2	;	Nem_Seal
PLC_LZAnimals_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Chemical Plant Zone animals
; --------------------------------------------------------------------------------------
PLC_CPZAnimals_PB:	dc.w ((PLC_CPZAnimals_PB_End-PLC_CPZAnimals_PB)/6)-1
		plcm	$B1078, ArtTile_Animal_1	;	Nem_Squirrel
		plcm	$B0CEC, ArtTile_Animal_2	;	Nem_Seal
PLC_CPZAnimals_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Emerald Hill Zone animals
; --------------------------------------------------------------------------------------
PLC_EHZAnimals_PB:	dc.w ((PLC_EHZAnimals_PB_End-PLC_EHZAnimals_PB)/6)-1
		plcm	$B0E08, ArtTile_Animal_1	;	Nem_Pig
		plcm	$B0F3E, ArtTile_Animal_2	;	Nem_Flicky
PLC_EHZAnimals_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hidden Palace Zone animals
; --------------------------------------------------------------------------------------
PLC_HPZAnimals_PB:	dc.w ((PLC_HPZAnimals_PB_End-PLC_HPZAnimals_PB)/6)-1
		plcm	$B0E08, ArtTile_Animal_1	;	Nem_Pig
		plcm	$B0A14, ArtTile_Animal_2	;	Nem_Chicken
PLC_HPZAnimals_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hill Top Zone animals
; --------------------------------------------------------------------------------------
PLC_HTZAnimals_PB:	dc.w ((PLC_HTZAnimals_PB_End-PLC_HTZAnimals_PB)/6)-1
		plcm	$B08BC, ArtTile_Animal_1	;	Nem_Bunny
		plcm	$B0A14, ArtTile_Animal_2	;	Nem_Chicken
PLC_HTZAnimals_PB_End: