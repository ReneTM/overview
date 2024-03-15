/*
	This script will provide an easy to use menu for mutations
*/

getroottable()["WHITE"]		<- "\x01"
getroottable()["BLUE"]		<- "\x03"
getroottable()["ORANGE"]	<- "\x04"
getroottable()["GREEN"]		<- "\x05"

function SetPlayerFlashlightState(ent, val){
	if(val){
		NetProps.SetPropInt(ent, "m_fEffects", NetProps.GetPropInt(ent, "m_fEffects") | 4)
	}else{
		NetProps.SetPropInt(ent, "m_fEffects", NetProps.GetPropInt(ent, "m_fEffects") & ~4)
	}
}


Keys <- {
	ATTACK = 1
	JUMP = 2
	DUCK = 4
	FORWARD = 8
	BACKWARD = 16
	USE = 32
	CANCEL = 64
	LEFT = 128
	RIGHT = 256
	MOVELEFT = 512
	MOVERIGHT = 1024
	ATTACK2 = 2048
	RUN = 4096
	RELOAD = 8192
	ALT1 = 16384
	ALT2 = 32768
	SHOWSCORES = 65536
	SPEED = 131072
	WALK = 262144
	ZOOM = 524288
	WEAPON1 = 1048576
	WEAPON2 = 2097152
	BULLRUSH = 4194304
	GRENADE1 = 8388608
	GRENADE2 = 16777216
	LOOKSPIN = 33554432
}




// Returns the host
// ----------------------------------------------------------------------------------------------------------------------------

function GetLocalPlayer(){
	return Entities.FindByClassname(null, "player")
}




// Validates and returns entity script scope
// ----------------------------------------------------------------------------------------------------------------------------

function GetValidatedScriptScope(ent){
	ent.ValidateScriptScope()
	return ent.GetScriptScope()
}




function ValidateKeyInScope(ent, key, val){
	ent.ValidateScriptScope()
	local scope = ent.GetScriptScope()
	if(!(key in scope)){
		scope[key] <- val
	}
}




// This initializes the timer responsible for the calls to the Think function
// ----------------------------------------------------------------------------------------------------------------------------

function CreateThinkTimer(){
	local ThinkTimerName = UniqueString("think_")
	local timer = Entities.FindByName(null, ThinkTimerName)
	if(timer){
		timer.Kill()
	}
	local timer = SpawnEntityFromTable("logic_timer", { targetname = ThinkTimerName, RefireTime = 0.01 } )
	timer.ValidateScriptScope()
	timer.GetScriptScope()["scope"] <- this
	timer.GetScriptScope()["func"] <- function(){
		scope.Think()
	}
	timer.ConnectOutput("OnTimer", "func")
	EntFire("!self", "Enable", null, 0, timer)
}




// Key functions
// ----------------------------------------------------------------------------------------------------------------------------

function ValidateDisabledButtonKey(ent){
	local scope = GetValidatedScriptScope(ent)
	if(!("buttonsDisabled" in scope)){
		scope["buttonsDisabled"] <- 0
	}
}

function AddDisabledButton(ent, button){
	local scope = GetValidatedScriptScope(ent)
	ValidateDisabledButtonKey(ent)
	scope["buttonsDisabled"] <- scope["buttonsDisabled"] | button
}

function RemoveDisabledButton(ent, button){
	local scope = GetValidatedScriptScope(ent)
	ValidateDisabledButtonKey(ent)
	scope["buttonsDisabled"] <- scope["buttonsDisabled"] & ~button
}

function SetDisabledButtons(ent, mask){
	local scope = GetValidatedScriptScope(ent)
	ValidateDisabledButtonKey(ent)
	scope["buttonsDisabled"] <- mask
}

function GetDisabledButtons(ent){
	local scope = GetValidatedScriptScope(ent)
	ValidateDisabledButtonKey(ent)
	return scope["buttonsDisabled"]
}

function HasDisabledButton(ent, button){
	local scope = GetValidatedScriptScope(ent)
	ValidateDisabledButtonKey(ent)
	return scope["buttonsDisabled"] & button
}

function KeyListener(){
	local ent = GetLocalPlayer()

	if(ent != null){
		ReadKey(ent, Keys.ATTACK, "Attack")
		ReadKey(ent, Keys.JUMP, "Jump")
		ReadKey(ent, Keys.DUCK, "Crouch")
		ReadKey(ent, Keys.FORWARD, "Forward")
		ReadKey(ent, Keys.BACKWARD, "Backward")
		ReadKey(ent, Keys.USE, "Use")
		ReadKey(ent, Keys.CANCEL, "Cancel")
		ReadKey(ent, Keys.LEFT, "Left")
		ReadKey(ent, Keys.RIGHT, "Right")
		ReadKey(ent, Keys.MOVELEFT, "MoveLeft")
		ReadKey(ent, Keys.MOVERIGHT, "MoveRight")
		ReadKey(ent, Keys.ATTACK2, "Attack2")
		ReadKey(ent, Keys.RUN, "Run")
		ReadKey(ent, Keys.RELOAD, "Reload")
		ReadKey(ent, Keys.ALT1, "Alt1")
		ReadKey(ent, Keys.ALT2, "Alt2")
		ReadKey(ent, Keys.SHOWSCORES, "Showscores")
		ReadKey(ent, Keys.SPEED, "Speed")
		ReadKey(ent, Keys.WALK, "Walk")
		ReadKey(ent, Keys.ZOOM, "Zoom")
		ReadKey(ent, Keys.WEAPON1, "Weapon1")
		ReadKey(ent, Keys.WEAPON2, "Weapon2")
		ReadKey(ent, Keys.BULLRUSH, "Bullrush")
		ReadKey(ent, Keys.GRENADE1, "Grenade1")
		ReadKey(ent, Keys.GRENADE2, "Grenade2")
		ReadKey(ent, Keys.LOOKSPIN, "Lookspin")
	}
}




function ReadKey(ent, val, keyName){
	
	// Accept on Tick!
	if(ent.GetButtonMask() & val){
		PlayerIsPressing(ent, keyName)
	}
	
	// Accept Key and lock it untill it got released once
	if((ent.GetButtonMask() & val) && !(HasDisabledButton(ent, val))){
		AddDisabledButton(ent, val)
		PlayerPressedKey(ent, keyName)
	}

	// Unlock Key when unpressed
	if(HasDisabledButton(ent, val)){
		if(!(ent.GetButtonMask() & val)){
			RemoveDisabledButton(ent, val)
			PlayerUnpressedKey(ent, keyName)
		}
	}
}




function MenuOpenController(ent){
	local scope = GetValidatedScriptScope(ent)
	ValidateKeyInScope(ent, "menu_visible", false)
	ValidateKeyInScope(ent, "menu_load_time", 0)
	if((ent.GetButtonMask() & Keys.USE) && (ent.GetButtonMask() & Keys.RELOAD)){
		if(scope.menu_load_time >= 120){
			scope.menu_visible = !scope.menu_visible
			scope.menu_load_time = 0
			ClientPrint(null, 5, "Menu " + (scope.menu_visible ? "Opened" : "Closed" ) )
		}else{
			scope.menu_load_time++
		}
	}else{
		scope.menu_load_time = 0
	}
}




function InOverview(){
	if(Convars.GetFloat("sv_orthoscale") > 0.0){
		return true
	}
	return false
}




function GetColorInt(col){
	if(typeof(col) == "Vector"){
		local color = col.x
		color += 256 * col.y
		color += 65536 * col.z
		return color
	}else if(typeof(col) == "string"){
		local colorArray = split(col, " ")
		local r = colorArray[0].tointeger()
		local g = colorArray[1].tointeger()
		local b = colorArray[2].tointeger()
		local color = r
		color += 256 * g
		color += 65536 * b
		return color
	}
}




::valveMaps <- [
	// DEAD CENTER
	"c1m1_hotel"
	"c1m2_streets"
	"c1m3_mall"
	"c1m4_atrium"
	// DARK CARNIVAL
	"c2m1_highway"
	"c2m2_fairgrounds"
	"c2m3_coaster"
	"c2m4_barns"
	"c2m5_concert"
	// SWAMP FEVER
	"c3m1_plankcountry"
	"c3m2_swamp"
	"c3m3_shantytown"
	"c3m4_plantation"
	// HARD RAIN
	"c4m1_milltown_a"
	"c4m2_sugarmill_a"
	"c4m3_sugarmill_b"
	"c4m4_milltown_b"
	"c4m5_milltown_escape"
	// THE PARISH
	"c5m1_waterfront"
	"c5m1_waterfront_sndscape"
	"c5m2_park"
	"c5m3_cemetery"
	"c5m4_quarter"
	"c5m5_bridge"
	// THE PASSING
	"c6m1_riverbank"
	"c6m2_bedlam"
	"c6m3_port"
	// THE SACRIFICE
	"c7m1_docks"
	"c7m2_barge"
	"c7m3_port"
	// NO MERCY
	"c8m1_apartment"
	"c8m2_subway"
	"c8m3_sewers"
	"c8m4_interior"
	"c8m5_rooftop"
	// CRASH COURSE
	"c9m1_alleys"
	"c9m2_lots"
	// DEATH TOLL
	"c10m1_caves"
	"c10m2_drainage"
	"c10m3_ranchhouse"
	"c10m4_mainstreet"
	"c10m5_houseboat"
	// DEAD AIR
	"c11m1_greenhouse"
	"c11m2_offices"
	"c11m3_garage"
	"c11m4_terminal"
	"c11m5_runway"
	// BLOOD HARVEST
	"c12m1_hilltop"
	"c12m2_traintunnel"
	"c12m3_bridge"
	"c12m4_barn"
	"c12m5_cornfield"
	// COLD STREAM
	"c13m1_alpinecreek"
	"c13m2_southpinestream"
	"c13m3_memorialbridge"
	"c13m4_cutthroatcreek"
	// THE LAST STAND
	"c14m1_junkyard"
	"c14m2_lighthouse"
]




// Taking screenshots will require a folder for the specific map. This function creates those.
// ----------------------------------------------------------------------------------------------------------------------------

function CreateMapFolders(){
	foreach(mapname in valveMaps){
		StringToFile(mapname + "/log.txt","")
	}
	ClientPrint(null, 5, GREEN + "Move map folders from ems/ to")
	ClientPrint(null, 5, GREEN + "Steam/steamapps/common/Left 4 Dead 2/left4dead2/screenshots")

}




// Simple distance measuring
// ----------------------------------------------------------------------------------------------------------------------------

local pos1 = Vector(0,0,0)
local pos2 = Vector(0,0,0)
local measured = 0.0

function Measure(val){
	if(val == 1){
		pos1 = player.GetOrigin()
	}
	if(val == 2){
		pos2 = player.GetOrigin()
		measured = (pos1-pos2).Length()
		ClientPrint(null, 5, "" + measured)
	}
}




// Throw all screenshit positions in the trash bin
// ----------------------------------------------------------------------------------------------------------------------------

function ClearPositions(){
	Positions.clear()
	DebugDrawClear()
	ClientPrint(null, 5, "Position data cleared!")
}




// Save screenshot positions to file
// ----------------------------------------------------------------------------------------------------------------------------

function SavePositionsToFile(){
	
	if(Positions.len() < 1){
		ClientPrint(null, 5, "Nothing 2 save!")
		return
	}
	
	if(!ratioBoxPos){
		ClientPrint(null, 5, "Save a ratio box first!")
	}
	
	local str = "::Positions <- [\n"
	
	for(local i = 0; i < Positions.len(); i++){
		local pos = Positions[i]
		str += GetVectorAsString(pos) + ","
		if(i < Positions.len() - 1){
			str +="\n"
		}
	}
	str = str.slice(0, str.len()-1)
	str +="\n"
	str += "]\n\n"
	
	// Ratiobox
	
	str += "::ratioBoxPos <- " + GetVectorAsString(ratioBoxPos)
	StringToFile("overview/overviewdata/" + mapname + ".nut", str)
	ClientPrint(null, 5, "File got saved")
}




// Load screenshot positions from file
// ----------------------------------------------------------------------------------------------------------------------------

function LoadPositions(){
	try{
		IncludeScript("../../ems/overview/overviewdata/" + mapname + ".nut")
		ReloadSavedPositions()
		player.SetOrigin(Vector(0,0,35000.0000))
	}catch(Exception){
		ClientPrint(null, 5, "Failed to load data!")
	}
}




// Night time maps are usually too dark for overview images when we dont want to use mat_fullbright, so we adjust the tonemap
// settings for dark maps
// ----------------------------------------------------------------------------------------------------------------------------

function GetToneForMap(){
	local brightnessValues =
	{
	// DEAD CENTER
	c1m1_hotel = 3.0
	c1m2_streets = 3.0
	c1m3_mall = 3.0
	c1m4_atrium = 3.0
	// DARK CARNIVAL
	c2m1_highway = 7.0
	c2m2_fairgrounds = 7.0
	c2m3_coaster = 7.0
	c2m4_barns = 7.0
	c2m5_concert = 7.0
	// SWAMP FEVER
	c3m1_plankcountry = 7.0
	c3m2_swamp = 7.0
	c3m3_shantytown = 7.0
	c3m4_plantation = 7.0
	// HARD RAIN
	c4m1_milltown_a = 7.0
	c4m2_sugarmill_a = 7.0
	c4m3_sugarmill_b = 7.0
	c4m4_milltown_b = 7.0
	c4m5_milltown_escape = 7.0
	// THE PARISH
	c5m1_waterfront = 3.0
	c5m1_waterfront_sndscape = 3.0
	c5m2_park = 3.0
	c5m3_cemetery = 3.0
	c5m4_quarter = 3.0
	c5m5_bridge = 3.0
	// THE PASSING
	c6m1_riverbank = 7.0
	c6m2_bedlam = 7.0
	c6m3_port = 7.0
	// THE SACRIFICE
	c7m1_docks = 7.0
	c7m2_barge = 7.0
	c7m3_port = 7.0
	// NO MERCY
	c8m1_apartment = 7.0
	c8m2_subway = 7.0
	c8m3_sewers = 7.0
	c8m4_interior = 7.0
	c8m5_rooftop = 7.0
	// CRASH COURSE
	c9m1_alleys = 7.0
	c9m2_lots = 7.0
	// DEATH TOLL
	c10m1_caves = 7.0
	c10m2_drainage = 7.0
	c10m3_ranchhouse = 7.0
	c10m4_mainstreet = 7.0
	c10m5_houseboat = 7.0
	// DEAD AIR
	c11m1_greenhouse = 7.0
	c11m2_offices = 7.0
	c11m3_garage = 7.0
	c11m4_terminal = 7.0
	c11m5_runway = 7.0
	// BLOOD HARVEST
	c12m1_hilltop = 7.0
	c12m2_traintunnel = 7.0
	c12m3_bridge = 7.0
	c12m4_barn = 7.0
	c12m5_cornfield = 7.0
	// COLD STREAM
	c13m1_alpinecreek = 3.0
	c13m2_southpinestream = 3.0
	c13m3_memorialbridge = 3.0
	c13m4_cutthroatcreek = 3.0
	// THE LAST STAND
	c14m1_junkyard = 7.0
	c14m2_lighthouse = 7.0
	}
	if(mapname in brightnessValues){
		return brightnessValues[mapname]	
	}
	return 7.0
}




// Equivalent to JS padStart
// ----------------------------------------------------------------------------------------------------------------------------

::FillWithZeros <- function(num, max){
	if(num > max){
		error("Passed number >" + num + "< exceeds passed max val of >" + max + "<")
		return
	}
	
	local Zeros2Add = max.tostring().len() - num.tostring().len()
	
	local str = ""
	
	for(local i = 0; i < Zeros2Add; i++){
		str += "0"
	}
	return str + num
}




// Returns Vector as string form to be saved as "script"
// ----------------------------------------------------------------------------------------------------------------------------

::GetVectorAsString <- function(pos){
	return ("Vector(" + pos.x + "," + pos.y + "," + pos.z + ")")
}




// Returns All saved positions as string
// ----------------------------------------------------------------------------------------------------------------------------

::GetPositionsAsString <- function(){
	local str = ""
	for(local i = 0; i < Positions.len(); i++){
		local pos = Positions[i]
		str += GetVectorAsString(pos) + "\n"
	}
	str += "Ratio box: " + GetVectorAsString(ratioBoxPos)
	return str
}




// Returns an array of all entities
// ----------------------------------------------------------------------------------------------------------------------------

::GetAllEntities <- function(){
	local ent = Entities.First()
	local entities = []
	while(ent = Entities.Next(ent)){
		if(ent && ent.IsValid()){
			entities.append(ent)
		}
	}
	return entities
}




// Validates the result image scale
// ----------------------------------------------------------------------------------------------------------------------------

::ValidateResolution <- function(){

	local rows = GetGridInfo().rows
	local cols = GetGridInfo().columns

	local resultImageWidth = cols * width
	local resultImageHeight = rows * height

	local totalPixels = resultImageWidth * resultImageWidth
	
	if(totalPixels <= 2147483647 && totalPixels > 0){
		if(resultImageWidth <= 65535 && resultImageWidth > 0){
			if(resultImageHeight <= 65535 && resultImageHeight > 0){
				return true
			}
		}
	}
	
	printl("Result: " + resultImageWidth + " x " + resultImageHeight + " = " + totalPixels + " TotalPixels")
	
	return false
}

/*

// FreezeGrid
// ----------------------------------------------------------------------------------------------------------------------------

::FreezeGrid <- function(){
	if(GridCenter == null){
		GridCenter = player.GetOrigin()
	}else{
		GridCenter = null
	}
}

*/

