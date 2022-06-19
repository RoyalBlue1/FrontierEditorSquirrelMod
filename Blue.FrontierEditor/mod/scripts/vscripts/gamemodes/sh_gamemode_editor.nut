global function Sh_GamemodeEditor_Init

global const string GAMEMODE_EDITOR = "editor"

void function Sh_GamemodeEditor_Init()
{
	// create custom gamemode
	AddCallback_OnCustomGamemodesInit( CreateGamemodeEditor )
	AddCallback_OnRegisteringCustomNetworkVars( EditorRegisterNetworkVars )
	PrecacheWeapon( "mp_weapon_toolgun" )
	PrecacheWeapon( "mp_ability_toolability" )
}

void function CreateGamemodeEditor()
{
	GameMode_Create( GAMEMODE_EDITOR )
	GameMode_SetName( GAMEMODE_EDITOR, "#GAMEMODE_EDITOR" )
	GameMode_SetDesc( GAMEMODE_EDITOR, "#PL_editor_desc" )
	GameMode_SetIcon( GAMEMODE_EDITOR, $"ui/menu/playlist/tdm" )
	GameMode_SetGameModeAnnouncement( GAMEMODE_EDITOR, "grnc_modeDesc" )
	GameMode_SetDefaultTimeLimits( GAMEMODE_EDITOR, 10, 0.0 )
	GameMode_AddScoreboardColumnData( GAMEMODE_EDITOR, "#SCOREBOARD_SCORE", PGS_ASSAULT_SCORE, 2 )
	GameMode_AddScoreboardColumnData( GAMEMODE_EDITOR, "#SCOREBOARD_PILOT_KILLS", PGS_PILOT_KILLS, 2 )
	GameMode_SetColor( GAMEMODE_EDITOR, [147, 204, 57, 255] )

	AddPrivateMatchMode( GAMEMODE_EDITOR ) // add to private lobby modes


	// set this to 25 score limit default
	GameMode_SetDefaultScoreLimits( GAMEMODE_EDITOR, 25, 0 )

	#if SERVER
		GameMode_AddServerInit( GAMEMODE_EDITOR, GamemodeEditor_Init )
		GameMode_SetPilotSpawnpointsRatingFunc( GAMEMODE_EDITOR, RateSpawnpoints_Generic )
		GameMode_SetTitanSpawnpointsRatingFunc( GAMEMODE_EDITOR, RateSpawnpoints_Generic )
	#elseif CLIENT
		GameMode_AddClientInit( GAMEMODE_EDITOR, ClGamemodeEditor_Init )
	#endif
	#if !UI
		GameMode_SetScoreCompareFunc( GAMEMODE_EDITOR, CompareAssaultScore )
	#endif
}

void function EditorRegisterNetworkVars()
{
	if ( GAMETYPE != GAMEMODE_EDITOR )
		return


}
