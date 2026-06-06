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
		plcm	Nem_Lamppost_PB, ArtTile_Lamppost
		plcm	Nem_HUD_PB, ArtTile_HUD
		plcm	Nem_Lives_PB, ArtTile_Lives_Counter
		plcm	Nem_Ring_PB, ArtTile_Ring
		plcm	Nem_Points_PB, ArtTile_Points
PLC_Main_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Standard 2 - loaded for every level
; --------------------------------------------------------------------------------------
PLC_Main2_PB:	dc.w ((PLC_Main2_PB_End-PLC_Main2_PB)/6)-1
		plcm	Nem_Monitors_PB, ArtTile_Monitor
		plcm	Nem_Shield_PB, ArtTile_Shield
		plcm	Nem_Stars_PB, ArtTile_Invincibility
PLC_Main2_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Explosion - loaded for every level AFTER the title card
; --------------------------------------------------------------------------------------
PLC_Explode_PB:	dc.w ((PLC_Explode_PB_End-PLC_Explode_PB)/6)-1
		plcm	Nem_Explosion_PB, ArtTile_Explosion
PLC_Explode_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Game/Time over
; --------------------------------------------------------------------------------------
PLC_GameOver_PB:	dc.w ((PLC_GameOver_PB_End-PLC_GameOver_PB)/6)-1
		plcm	Nem_GameOver_PB, ArtTile_Game_Over
PLC_GameOver_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Green Hill Zone primary
; --------------------------------------------------------------------------------------
PLC_GHZ_PB:	dc.w ((PLC_GHZ_PB_End-PLC_GHZ_PB)/6)-1
		plcm	Nem_GHZ_PB, ArtTile_Level
		plcm	Nem_Chopper_PB, ArtTile_Chopper
		plcm	Nem_VSpikes_PB, ArtTile_S1_Spikes
		plcm	Nem_HSpring_PB, ArtTile_S1_Spring_Horizontal
		plcm	Nem_VSpring_PB, ArtTile_S1_Spring_Vertical
		plcm	Nem_GHZ_Bridge_PB, ArtTile_GHZ_Bridge
		plcm	Nem_SwingPlatform_PB, ArtTile_GHZ_Swing
		plcm	Nem_Motobug_PB, ArtTile_Moto_Bug
		plcm	Nem_GHZ_Rock_PB, ArtTile_GHZ_Purple_Rock
PLC_GHZ_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Green Hill Zone secondary
; --------------------------------------------------------------------------------------
PLC_GHZ2_PB:	dc.w ((PLC_GHZ2_PB_End-PLC_GHZ2_PB)/6)-1
		plcm	Nem_Chopper_PB, ArtTile_Chopper
PLC_GHZ2_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Chemical Plant Zone primary
; --------------------------------------------------------------------------------------
PLC_CPZ_PB:	dc.w ((PLC_CPZ_PB_End-PLC_CPZ_PB)/6)-1
		plcm	Nem_CPZ_PB, ArtTile_Level
		plcm	Nem_CPZ_Buildings_PB, ArtTile_CPZ_Buildings
		plcm	Nem_CPZ_FloatingPlatform_PB, ArtTile_CPZ_Platform
		plcm	dai0dcg, ArtTile_CPZ_Float_Platform
		plcm	Nem_WaterSurface_PB, ArtTile_CPZ_Water_Surface
PLC_CPZ_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Emerald Hill Zone primary
; --------------------------------------------------------------------------------------
PLC_EHZ_PB:	dc.w ((PLC_EHZ_PB_End-PLC_EHZ_PB)/6)-1
		plcm	Nem_EHZ_PB, ArtTile_Level
		plcm	Nem_EHZ_Fireball_PB, ArtTile_Fireball
		plcm	Nem_EHZ_Waterfall_PB, ArtTile_Waterfall
		plcm	Nem_EHZ_Bridge_PB, ArtTile_EHZ_Bridge
		plcm	Nem_HTZ_Seesaw_PB, ArtTile_HTZ_Seesaw
		plcm	Nem_VSpikes_PB, ArtTile_Spikes
		plcm	Nem_DSpring_PB, ArtTile_Spring_Diagonal
		plcm	Nem_VSpring2_PB, ArtTile_Spring_Vertical
		plcm	Nem_HSpring2_PB, ArtTile_Spring_Horizontal
PLC_EHZ_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Emerald Hill Zone secondary
; --------------------------------------------------------------------------------------
PLC_EHZ2_PB:	dc.w ((PLC_EHZ2_PB_End-PLC_EHZ2_PB)/6)-1
		plcm	Nem_Buzzer_PB, ArtTile_Buzzer
		plcm	Nem_Snail_PB, ArtTile_Snail
		plcm	Nem_Masher_PB, ArtTile_Masher
PLC_EHZ2_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hidden Palace Zone primary
; --------------------------------------------------------------------------------------
PLC_HPZ_PB:	dc.w ((PLC_HPZ_PB_End-PLC_HPZ_PB)/6)-1
		plcm	Nem_HPZ_PB, ArtTile_Level
		plcm	Nem_HPZ_Bridge_PB, ArtTile_HPZ_Bridge
		plcm	Nem_HPZ_Waterfall_PB, ArtTile_HPZ_Waterfall
		plcm	Nem_HPZ_Platform_PB, ArtTile_HPZ_Platform
		plcm	Nem_HPZ_PulsingBall_PB, ArtTile_HPZ_Orb
		plcm	Nem_HPZ_Various_PB, ArtTile_HPZ_Various
		plcm	Nem_HPZ_Emerald_PB, ArtTile_HPZ_Emerald
		plcm	Nem_WaterSurface_PB, ArtTile_Water_Surface
PLC_HPZ_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hidden Palace Zone secondary
; --------------------------------------------------------------------------------------
PLC_HPZ2_PB:	dc.w ((PLC_HPZ2_PB_End-PLC_HPZ2_PB)/6)-1
		plcm	Nem_Redz_PB, ArtTile_Redz
		plcm	Nem_BBat_PB, ArtTile_BBat
PLC_HPZ2_PB_End:
		; unused PLR entries
		plcm	Nem_Gator_PB, ArtTile_Gator
		plcm	Nem_Buzzer_PB, ArtTile_Early_Buzzer
		plcm	Nem_BBat_PB, ArtTile_Early_BBat
		plcm	Nem_Stegway_PB, ArtTile_Stegway
		plcm	Nem_Redz_PB, ArtTile_Redz
		plcm	Nem_BFish_PB, ArtTile_BFish
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Chemical Plant Zone secondary
; --------------------------------------------------------------------------------------
PLC_CPZ2_PB:	dc.w ((PLC_CPZ2_PB_End-PLC_CPZ2_PB)/6)-1
		plcm	Nem_VSpikes_PB, ArtTile_S1_Spikes
		plcm	Nem_HSpring_PB, ArtTile_S1_Spring_Horizontal
		plcm	Nem_VSpring_PB, ArtTile_S1_Spring_Vertical
PLC_CPZ2_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Sonic 1 title card
; --------------------------------------------------------------------------------------
PLC_S1TitleCard_PB:dc.w ((PLC_S1TitleCard_PB_End-PLC_S1TitleCard_PB)/6)-1
		plcm	Nem_TitleCard_PB, ArtTile_Title_Card
PLC_S1TitleCard_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; End of zone bosses
; --------------------------------------------------------------------------------------
PLC_Boss_PB:	dc.w ((PLC_Boss_PB_End-PLC_Boss_PB)/6)-1
		plcm	Nem_BossShip_PB, ArtTile_ArtNem_Eggpod_1
		plcm	Nem_EHZ_Boss_PB, ArtTile_ArtNem_EHZBoss
		plcm	Nem_EHZ_Boss_Blades_PB, ArtTile_ArtNem_EggChoppers
PLC_Boss_PB_End:
; unused PLC entries
		plcm	Nem_BossShip_PB, $400
		plcm	Nem_CPZ_ProtoBoss_PB, $460
		plcm	Nem_BossShipBoost_PB, $4D0
		plcm	Nem_Smoke_PB, $4D8
		plcm	Nem_EHZ_Boss_PB, $4E8
		plcm	Nem_EHZ_Boss_Blades_PB, $568
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; End of level signpost
; --------------------------------------------------------------------------------------
PLC_Signpost_PB:	dc.w ((PLC_Signpost_PB_End-PLC_Signpost_PB)/6)-1
		plcm	Nem_Signpost_PB, ArtTile_Signpost
		plcm	Nem_BonusPoints_PB, ArtTile_Hidden_Points
		plcm	Nem_BigFlash_PB, ArtTile_Giant_Ring_Flash
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
		plcm	Nem_Bunny_PB, ArtTile_Animal_1
		plcm	Nem_Flicky_PB, ArtTile_Animal_2
PLC_GHZAnimals_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Labyrinth Zone animals
; --------------------------------------------------------------------------------------
PLC_LZAnimals_PB:	dc.w ((PLC_LZAnimals_PB_End-PLC_LZAnimals_PB)/6)-1
		plcm	Nem_Penguin_PB, ArtTile_Animal_1
		plcm	Nem_Seal_PB, ArtTile_Animal_2
PLC_LZAnimals_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Chemical Plant Zone animals
; --------------------------------------------------------------------------------------
PLC_CPZAnimals_PB:	dc.w ((PLC_CPZAnimals_PB_End-PLC_CPZAnimals_PB)/6)-1
		plcm	Nem_Squirrel_PB, ArtTile_Animal_1
		plcm	Nem_Seal_PB, ArtTile_Animal_2
PLC_CPZAnimals_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Emerald Hill Zone animals
; --------------------------------------------------------------------------------------
PLC_EHZAnimals_PB:	dc.w ((PLC_EHZAnimals_PB_End-PLC_EHZAnimals_PB)/6)-1
		plcm	Nem_Pig_PB, ArtTile_Animal_1
		plcm	Nem_Flicky_PB, ArtTile_Animal_2
PLC_EHZAnimals_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hidden Palace Zone animals
; --------------------------------------------------------------------------------------
PLC_HPZAnimals_PB:	dc.w ((PLC_HPZAnimals_PB_End-PLC_HPZAnimals_PB)/6)-1
		plcm	Nem_Pig_PB, ArtTile_Animal_1
		plcm	Nem_Chicken_PB, ArtTile_Animal_2
PLC_HPZAnimals_PB_End:
; --------------------------------------------------------------------------------------
; PATTERN LOAD REQUEST LIST
; Hill Top Zone animals
; --------------------------------------------------------------------------------------
PLC_HTZAnimals_PB:	dc.w ((PLC_HTZAnimals_PB_End-PLC_HTZAnimals_PB)/6)-1
		plcm	Nem_Bunny_PB, ArtTile_Animal_1
		plcm	Nem_Chicken_PB, ArtTile_Animal_2
PLC_HTZAnimals_PB_End: