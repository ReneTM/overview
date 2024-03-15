//****************************************************************************************
//																						//
//									overview_events_.nut								//
//																						//
//****************************************************************************************




function OnGameEvent_player_say(params){

	local text = strip(params["text"].tolower())
	local ent = GetPlayerFromUserID(params["userid"])

	if(ent == null || text.len() < 2){
		return
	}

	if(text.slice(0,1) == "!"){
		
		text = text.slice(1, text.len())
	
		switch(text){
			case "start" : MakeScreenshots(); break
			case "ratiobox" : placeRatioBox(); break
			case "freezegrid" : FreezeGrid(); break
			case "measurestart" : Measure(1); break
			case "measureend" : Measure(2); break
			case "mkdirs" : CreateMapFolders(); break
			case "settileheight" : SetTileHeight(); break
			case "settilewidth" : SetTileWidth(); break
			case "savesettings" : SaveCurrentSettings(); break
			case "savepositions" : SavePositionsToFile(); break
			case "loadpositions" : LoadPositions(); break
			case "clear" : ClearPositions(); break
			case "ladder" : LookAtLadder(); break
			case "waterfix" : fixingWater = true; break
			default : ClientPrint(null, 5, "Misspelled or unknown command!")
		}
	}
}




function OnGameEvent_round_start_post_nav(params){

}




__CollectEventCallbacks(this, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener)