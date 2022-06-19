global function ClGamemodeEditor_Init


void function ClGamemodeEditor_Init()
{
    ClGameState_RegisterGameStateAsset( $"ui/gamestate_info_speedball.rpak" )
    Minimap_SetZoomScale( 2.0 )
	Minimap_SetSizeScale( 1.2 )
}
