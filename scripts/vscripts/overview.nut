
/*
	L4D(2) - Level overview navigator by ReneTM...
	----------------------------------------------
	This mutation script makes it easy to take tile screenshots for map overviews in L4D2
*/

::ScriptStartTime <- Time()




// We save the users settings so we can have some easy keybinds without a hussle to get back to the liked settings
// ----------------------------------------------------------------------------------------------------------------------------

//SendToServerConsole("exec overview_user_backup.cfg")
//SendToServerConsole("host_writeconfig overview_user_backup.cfg")




// Subscripts
// ----------------------------------------------------------------------------------------------------------------------------

::mapname <- Director.GetMapName().tolower()

IncludeScript("overview/overview_utils", getroottable() )
//IncludeScript("overview/overview_tanktoys", getroottable() )
IncludeScript("overview/overview_entity_manipulator", getroottable() )
IncludeScript("overview/overview_background", getroottable() )
IncludeScript("overview/overview_hud", getroottable() )
IncludeScript("overview/overview_events", getroottable() )
IncludeScript("overview/overview_director", getroottable() )
IncludeScript("overview/overview_time", getroottable() )
IncludeScript("overview/overview_font", getroottable() )

DebugDrawClear()


::screenHeight <- 1080.0
::screenWidth <- 1920.0

::minscale <- 1.0 // 0.5 works also great
::maxscale <- 30.0

::height <- screenHeight * minscale
::width <- screenWidth * minscale

::screenshotMode <- 0

::Positions <- []

::GridCenter <- null

::debugDrawEnabled <- true

::color_GridBox	<- Vector(20,20,20)
::color_CrosshairBox <- Vector(0,0,255)
::color_SavedPos <- Vector(255,0,100)
::color_RatioBox <- Vector(231,220,213)




// We need the local player instance accesable everywhere
// --------------------------------------------------------------------------------------------------------------------

::player <- GetLocalPlayer()

function OnGameplayStart(){
	
	player = GetLocalPlayer()
	
	ManipulateMapEntities()
	
	for(local ent = null; ent = Entities.FindByClassname(ent, "player");){
		if(ent.IsValid()){
			if(IsPlayerABot(ent)){
				ent.Kill()
			}
		}
	}
	
	// Enable noclip, disable flashlight
	// -------------------------------------------
	NetProps.SetPropInt(player, "movetype", 8)
	SetPlayerFlashlightState(player, false)
	if(player.GetOrigin().z <= 22000){
		local curr = player.GetOrigin()
		player.SetOrigin(Vector(curr.x, curr.y, 22000.0000))
	}

	// Kill player loadout
	// -------------------------------------------
	local invTable = {}
	GetInvTable(player, invTable)
	foreach(slot, ent in invTable){
		ent.Kill()
	}

	// Send Commands
	// -------------------------------------------
	foreach(cmd in commands){
		SendToServerConsole(cmd)
	}
	
	// Set Cvars
	// -------------------------------------------
	foreach(cvar, arr in Cvars){
		Convars.SetValue(cvar, arr[CVAR_SET_CUSTOM])
	}
}




// Set of cvars which achieve more visibility
// --------------------------------------------------------------------------------------------------------------------

getroottable()["CVAR_SET_CUSTOM"] <- 0
getroottable()["CVAR_SET_DEFAULT"] <- 1

::Cvars <-
{
	cl_max_shadow_renderable_dist			= [99999, 3000]
	cl_detaildist							= [99999, 400]
	cl_detailfade							= [99999, 250]
	cl_pitchdown							= [90, 89]
	cl_pitchup								= [90, 89]
	cl_windspeed							= [0, 0]

	sv_forcepreload							= [1, 0]
	sv_glowenable							= [1, 1]
	sv_noclipspeed							= [2.0, 5.0]

	mat_postprocess_enable					= [0, 1]
	mat_monitorgamma_tv_enabled				= [0, 0]
	mat_monitorgamma						= [1.6, 1.8]
	
	mat_force_tonemap_min_avglum			= [3.0, -1]
	mat_force_tonemap_percent_bright_pixels	= [1.0, -1]
	mat_force_tonemap_percent_target		= [45.0, -1]
	mat_force_tonemap_scale					= [GetToneForMap(), 0.0]
	mat_dynamic_tonemapping					= [0, 1]
	mat_skybox_water_reflection				= [1, 1]
	mat_picmip								= [-10, -1]

	fog_enable_water_fog					= [1, 1]
	fog_override							= [1, 0]
	fog_enable								= [1, 1]
	fog_start								= [99999, -1]
	fog_end									= [99999, -1]

	r_drawmodelstatsoverlaydistance 		= [99999, 500]
	r_farz									= [99999, -1]
	r_dscale_fardist						= [99999, 2000]
	r_dscale_neardist						= [99999, 100]
	r_propsmaxdist							= [99999, 1200]
	r_occludeemaxarea						= [99999, 0]
	r_overlayfademax						= [99999, 2000]
	r_overlayfademin						= [99999, 1750]
	r_overlayfadeenable						= [1, 0]
	r_unlimitedrefract						= [0, 0]
	r_occlusion								= [0, 1]
	r_drawviewmodel							= [0, 1]
	r_portalsopenall						= [1, 0]
	r_drawallrenderables					= [1, 0]
	r_novis									= [1, 0]
	r_ForceWaterLeaf						= [0, 1]
	r_waterforceexpensive					= [1, 0]
	r_WaterDrawRefraction					= [1, 1]
	r_WaterDrawReflection					= [0, 1]
	r_worldlightmin							= [0.000300, 0.000200]
	r_minlightmap							= [0, 0]
	r_shadowmaxrendered						= [128, 64]
	r_lod									= [0, -1]	// No effect ?
	r_shadowlod								= [0, -1]	// No effect ?
	r_staticprop_lod						= [0, -1]	// No effect ?
	sb_all_bot_game							= [1, 0]
	jpeg_quality							= [100, 90]
	map_noareas								= [1, 0] // No effect ? 
}


::commands <-
[
	"director_stop"
	"nb_delete_all"
	"camortho"
	"r_cheapwaterend 99999"
	"r_cheapwaterstart 99999"
]




// Direction controlls
// --------------------------------------------------------------------------------------------------------------------

::Dir <-
{
	Up = "Up"
	Down = "Down"
	Right = "Right"
	Left = "Left"
}

::Nodge <- function(val){

	local adj = (player.GetButtonMask() & Keys.SPEED)
	
	local m1 = (player.GetButtonMask() & Keys.ATTACK)
	local m2 = (player.GetButtonMask() & Keys.ATTACK2)
	local duck = (player.GetButtonMask() & Keys.DUCK)
		
	switch(val){
		case "Up": player.SetOrigin(player.GetOrigin() + Vector(0, height, 0));		break
		case "Down": player.SetOrigin(player.GetOrigin() + Vector(0, -height,0));	break
		case "Right": player.SetOrigin(player.GetOrigin() + Vector(width,0,0));		break
		case "Left": player.SetOrigin(player.GetOrigin() + Vector(-width,0,0));		break
	}
}




// Save current "crosshair-position"
// --------------------------------------------------------------------------------------------------------------------

::SavePosition <- function(){
	Positions.append(player.GetOrigin())
	HighLightBox(player.GetOrigin())
}



::CopyPositions <- function(){
	
	local count = GetGridInfo().columns

	local poscopy = []

	for(local i = Positions.len() - 1; i > (Positions.len() - (count + 1)); i--){
		local oldpos = Positions[i]
		local newpos = Vector(oldpos.x,oldpos.y,oldpos.z)
		poscopy.append(newpos)
	}

	poscopy.reverse()

	foreach(pos in poscopy){
		local custpos = pos + Vector(0,-height,0)
		HighLightBox(custpos)
		Positions.append(custpos)
	}
}

::HighLightBox <- function(pos){
	DebugDrawBoxAngles(pos, Vector(width/2,height/2,32), Vector(-width/2,-height/2,-32), QAngle(0,0,0), color_SavedPos, 1, 999)
}

::ReloadSavedPositions <- function(){
	DebugDrawClear()
	foreach(pos in Positions){
		HighLightBox(pos)
	}
}

::RemovePrevious <- function(count){

	if(Positions.len() >= count){
		for(local i = 0; i < count; i++){
			Positions.pop()
		}
	}else{
		ClientPrint(null, 5, "There are only " + Positions.len() + " items left in the array")
		return
	}
	ClientPrint(null, 5, "Removed " + count + " positions!")

	ReloadSavedPositions()
}




// Counts rows and columns
// --------------------------------------------------------------------------------------------------------------------

::GetGridInfo <- function(){

	local col = 0, row = 0
	local x = null, y = null

	if(Positions.len() == 0){
		return { columns = 0, rows = 0 }
	}

	// X & Y of 1st saved Vector
	x = Positions[0].x
	y = Positions[0].y

	// How many Vectors match X,Y
	foreach(pos in Positions){
		if(pos.x == x){
			row++
		}
		if(pos.y == y){
			col++
		}
	}

	return { columns = col, rows = row }
}




// Draws the screenshit ID onto the DebugDrawBox of the marked screenshot position
// --------------------------------------------------------------------------------------------------------------------

::DrawPositionNumbers <- function(){
	for(local i = 0; i < Positions.len(); i++){
		DebugDrawText(Positions[i], "" + (i + 1), false, 0.1)
	}
}




// Begins the screenshot sequence
// --------------------------------------------------------------------------------------------------------------------

::MakeScreenshots <- function(){
	
	local rows = GetGridInfo().rows
	local row = 1
	local columns = GetGridInfo().columns
	
	if(ratioBoxPos == null){
		ClientPrint(null, 5, GREEN + "Please create a ratio box in any free space (in the selected area)")
		return
	}
	
	DebugDrawClear()
	//CreateImageLog()
	
	EntFire( "worldspawn", "RunScriptCode", "ScreenshotMode()", 0.0 )
	EntFire( "worldspawn", "RunScriptCode", "DrawRatioboxText()", 0.3 )
	EntFire( "worldspawn", "RunScriptCode", "EditMode()", Positions.len() )

	for(local i = 0; i < Positions.len(); i++){

		EntFire("worldspawn", "RunScriptCode", "SetPosition(" + i + ")", i)
		EntFire("worldspawn", "RunScriptCode", "fixingWater=true", i + 0.03)
		EntFire("worldspawn", "RunScriptCode", "MakeScreenhot(" + i + "," + row + ")", ( i + 0.9 ) )
		
		if(row == rows){
			row = 1
		}else{
			row++
		}
	}
}




::EditMode <- function(){
	screenshotMode = 0
	SetOrthoScale(maxscale)
	Convars.SetValue("hidehud", 0)
	Convars.SetValue("host_timescale", 1)
	Convars.SetValue("r_drawvgui", 1)
	Convars.SetValue("r_portalsopenall", 0)
	EnableHud()
}




::ScreenshotMode <- function(){
	screenshotMode = 1
	debugDrawEnabled = true
	SetOrthoScale(minscale)
	Convars.SetValue("hidehud", 4)
	Convars.SetValue("host_timescale", 2)
	Convars.SetValue("r_drawvgui", 0)
	Convars.SetValue("r_portalsopenall", 1)
	DisableHud()
}




::SetPosition <- function(i){
	player.SetOrigin(Positions[i])
}




// Save current positions to collection
// ----------------------------------------------------------------------------------------------------------------------------

::MakeScreenhot <- function(i, row){
	local path = mapname + "/"
	SendToServerConsole("jpeg " + path + mapname + "_" + FillWithZeros(i, 9999) + " 100")
}




// Zoom in / zoom out
// ----------------------------------------------------------------------------------------------------------------------------

::ToggleView <- function(){
	if(Convars.GetFloat("sv_orthoscale") == minscale){
		Convars.SetValue("sv_orthoscale", maxscale)
	}
	else{
		Convars.SetValue("sv_orthoscale", minscale)
	}
}




// Toggle the visibility of DebugDraw elements
// ----------------------------------------------------------------------------------------------------------------------------

::ToggleDebugDrawBox <- function(){
	debugDrawEnabled = !debugDrawEnabled
}




// Visualization of the Box for outer map boundries and the "crosshair"
// When "GridCenter" is not set, the origin of the boundries box will be set to the player origin
// ----------------------------------------------------------------------------------------------------------------------------

function DrawGridBox(){

	local pos = player.GetOrigin()

	if(GridCenter != null){
		pos = GridCenter
	}
	
	for(local i = height * 2; i < (height * 32); i+= height){
		DebugDrawBoxAngles(Vector(pos.x,pos.y+i,pos.z), Vector(width/2,height/2,32), Vector(-width/2,-height/2,-32), QAngle(0,0,0), color_GridBox, 1, 0.1)
		DebugDrawBoxAngles(Vector(pos.x,pos.y+(-i),pos.z), Vector(width/2,height/2,32), Vector(-width/2,-height/2,-32), QAngle(0,0,0), color_GridBox, 1, 0.1)
	}

	for(local o = width * 2; o < (width * 32); o += width){
		DebugDrawBoxAngles(Vector(pos.x + o, pos.y,pos.z), Vector(width/2,height/2,32), Vector(-width/2,-height/2,-32), QAngle(0,0,0), color_GridBox, 1, 0.1)
		DebugDrawBoxAngles(Vector(pos.x + (-o), pos.y, pos.z), Vector(width/2,height/2,32), Vector(-width/2,-height/2,-32), QAngle(0,0,0), color_GridBox, 1, 0.1)
	}
}




function DrawCrosshairBox(){
	DebugDrawBoxAngles(player.GetOrigin(), Vector(width/2,height/2,32), Vector(-width/2,-height/2,-32), QAngle(0,0,0), color_CrosshairBox, 8, 0.1)
}




// Draws a reference box
// ----------------------------------------------------------------------------------------------------------------------------

::ratioBoxPos <- null

::placeRatioBox <- function(){
	ratioBoxPos = player.GetOrigin()
}




// Creates a set of ratio boxes to choose from
// ----------------------------------------------------------------------------------------------------------------------------

::RatioBoxes <- {}

RatioBoxes["4"] <- { Min = Vector(2,2,4), Max = Vector(-2,-2,-4) }
RatioBoxes["256"] <- { Min = Vector(128,128,2), Max = Vector(-128,-128,-2) }
RatioBoxes["512"] <- { Min = Vector(256,256,2), Max = Vector(-256,-256,-2) }

::SelectedRatio <- RatioBoxes["512"]

function DrawRatioBox(){
	if(ratioBoxPos){
		DebugDrawBoxAngles(ratioBoxPos, SelectedRatio.Min, SelectedRatio.Max, QAngle(0,0,0), color_RatioBox, 255, 0.1)
	}
}




::DrawRatioboxText <- function(){
	local RatioBoxText =
	"Map: " + mapname + "\n" +
	GetRatioBoxTimeString().Date + "\n" +
	GetGridInfo().columns + " Columns x " + GetGridInfo().rows + " Rows = " + Positions.len() + " Tiles" + "\n" + 
	"Size of this box: " + (SelectedRatio.Min.x * 2) + " x " + (SelectedRatio.Min.x * 2) + "\n" + 
	"Generated by ReneTM"
	WriteText(ratioBoxPos + Vector(0,0,8), RatioBoxText)
}




// Function called by logic_timer
// ----------------------------------------------------------------------------------------------------------------------------

function Think(){

	player = GetLocalPlayer()
	
	if(!player){
		return
	}
	
	CustomConvarListener()
	
	KeyListener()
	
	WaterFix()

	if(Time() > ScriptStartTime + 32.0){
		if(!fixingWater){
			player.SnapEyeAngles(QAngle(90,90,0))
			local p = player.GetOrigin()
			// player.SetOrigin(Vector(p.x, p.y, 32000.00000))
		}else{
			// player.SnapEyeAngles(QAngle(-90,90,0))
		}
	}

	// No visualization when screenshot sequence started
	if(!screenshotMode && debugDrawEnabled && InOverview()){
		DrawGridBox()
		DrawCrosshairBox()
		DrawPositionNumbers()
	}

	DrawRatioBox()
	
	// Draw a purple dot @ map origin
	DebugDrawBoxAngles(Vector(0,0,0), Vector(0.5,0.5,0.5), Vector(-0.5,-0.5,-0.5), QAngle(0,0,0), Vector(255,0,255), 255, 0.1)
}




// Binds
// ----------------------------------------------------------------------------------------------------------------------------

::HeightAdjust <- function(val){
	player.SetOrigin(player.GetOrigin() + Vector(0,0,val))
}




// Events for button presses
// ----------------------------------------------------------------------------------------------------------------------------

function PlayerPressedKey(ent, key){
	switch(key){
		case "Zoom" 		: ToggleView();			break
		case "Reload"		: RemovePrevious(1);	break
	}
}

function PlayerUnpressedKey(ent, key){
	
}

function PlayerIsPressing(ent, key){
	switch(key){
		case "MoveRight"	: ent.SetOrigin(ent.GetOrigin() + Vector(1.0000,0.0000,0.0000));	break
		case "MoveLeft"		: ent.SetOrigin(ent.GetOrigin() + Vector(-1.0000,0.0000,0.0000));	break
		case "Forward"		: ent.SetOrigin(ent.GetOrigin() + Vector(0.0000,8.0000,0.0000));	break
		case "Backward"		: ent.SetOrigin(ent.GetOrigin() + Vector(0.0000,-8.0000,0.0000));	break
	}
}




// Will iterate from -16384 to 32768 to load the visleaf of the area below
// ----------------------------------------------------------------------------------------------------------------------------

::waterFixHeight <- -16384

::fixingWater <- false

::WaterFix <- function(){
	if(fixingWater){
		local p = player.GetOrigin()
		player.SetOrigin(Vector(p.x, p.y, waterFixHeight))
		waterFixHeight += 1024
		if(waterFixHeight >= 32768){
			waterFixHeight = -16384
			fixingWater = false
		}
	}
}




// Sets the scale of the orthografic camera
// ----------------------------------------------------------------------------------------------------------------------------

::SetOrthoScale <- function(val){
	local scale = val.tofloat()
	Convars.SetValue("c_orthoheight", 1080.0 * scale)
	Convars.SetValue("c_orthowidth", 1920.0 * scale)
}




// Binds
// ----------------------------------------------------------------------------------------------------------------------------

SendToServerConsole("bind UPARROW \"script Nodge(Dir.Up)\"")
SendToServerConsole("bind DOWNARROW \"script Nodge(Dir.Down)\"")
SendToServerConsole("bind RIGHTARROW \"script Nodge(Dir.Right)\"")
SendToServerConsole("bind LEFTARROW \"script Nodge(Dir.Left)\"")
SendToServerConsole("bind F10 \"script SavePosition()\"")
SendToServerConsole("bind B \"script ToggleDebugDrawBox()\"")
SendToServerConsole("bind KP_PLUS \"script HeightAdjust(256)\"")
SendToServerConsole("bind KP_MINUS \"script HeightAdjust(-256)\"")
SendToServerConsole("bind C \"script CopyPositions()\"")

printl("Arrow Keys   ->   Nodgeing")
printl("F8           ->   Ratio Box")
printl("R            ->   Remove Prev.")
printl("F10          ->   Save Pos.")
printl("F11          ->   Make Screenshots")
printl("B            ->   Toggle Toggle DebugDrawBoxes")
printl("Keypad +/-   ->   Adjust height")
printl("C            ->   Copy Row")



// Start
// ----------------------------------------------------------------------------------------------------------------------------

CreateThinkTimer()

printl("")
printl("")
printl("Overview mutation script has been loaded!")
