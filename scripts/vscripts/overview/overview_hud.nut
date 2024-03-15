//****************************************************************************************
//																						//
//									overview_hud.nut									//
//																						//
//****************************************************************************************




// Flag and position tables
// ----------------------------------------------------------------------------------------------------------------------------

::HUDFlags <- {
	PRESTR = 1
	POSTSTR = 2
	BEEP = 4
	BLINK = 8
	AS_TIME = 16
	COUNTDOWN_WARN = 32
	NOBG = 64
	ALLOWNEGTIMER = 128
	ALIGN_LEFT = 256
	ALIGN_CENTER = 512
	ALIGN_RIGHT = 768
	TEAM_SURVIVORS = 1024
	TEAM_INFECTED = 2048
	TEAM_MASK = 3072
	NOTVISIBLE = 16384
}

::HUDPositions <- {
	LEFT_TOP = 0
	LEFT_BOT = 1
	MID_TOP = 2
	MID_BOT = 3
	RIGHT_TOP = 4
	RIGHT_BOT = 5
	TICKER = 6
	FAR_LEFT = 7
	FAR_RIGHT = 8
	MID_BOX = 9
	SCORE_TITLE = 10
	SCORE_1 = 11
	SCORE_2 = 12
	SCORE_3 = 13
	SCORE_4 = 14
}




// Main hud definition
// ----------------------------------------------------------------------------------------------------------------------------


local cols = "0"
local rows = "0"
local imgRes = ""

local lastData = "Waiting for data..."

local datastmp = Time()

function GetText(){
	if(Time() > datastmp + 1.0){
		imgRes = (width * GetGridInfo().rows) + " x " + (height * GetGridInfo().columns)
		lastData = "Scale: " + minscale + "  Columns: " + GetGridInfo().columns + "  Rows: " + GetGridInfo().rows + "  Screenshot Positions: " + Positions.len() + "  Image Resolution: " + imgRes + "  Valid: " + ValidateResolution()
		datastmp = Time()
	}
	return lastData
}

local strBinds =
"Arr.Keys | -> Nodge \n" + 
"KP +/-   | -> Adjust Height \n" +
"F10      | -> Save Position \n" +
"R        | -> Undo Previous \n"

local chatCommands = "Chat commands: !ratiobox, !start, !measurestart, !measureend, !mkdirs"

OV_HUD <-
{
	Fields = 
	{
		timer = { slot = HUDPositions.MID_BOX, flags = HUDFlags.ALIGN_CENTER /*| HUDFlags.NOBG*/, name = "timer", datafunc = @()GetText() }
		binds = { slot = HUDPositions.RIGHT_TOP, flags = HUDFlags.ALIGN_LEFT | HUDFlags.NOBG, name = "binds", staticstring = strBinds }
		chatcommands = { slot = HUDPositions.MID_BOT, flags = HUDFlags.ALIGN_CENTER /*| HUDFlags.NOBG*/, name = "chatcommands", staticstring = chatCommands }
	}
}




// Enable / disable the hud
// ----------------------------------------------------------------------------------------------------------------------------

function EnableHud(){
	OV_HUD.Fields.timer.flags <- OV_HUD.Fields.timer.flags & ~HUDFlags.NOTVISIBLE
	OV_HUD.Fields.binds.flags <- OV_HUD.Fields.binds.flags & ~HUDFlags.NOTVISIBLE
	OV_HUD.Fields.chatcommands.flags <- OV_HUD.Fields.chatcommands.flags & ~HUDFlags.NOTVISIBLE
	g_ModeScript.HUDPlace(HUDPositions.MID_BOX, 0.0, 0.0, 1.0, 0.05)
	g_ModeScript.HUDPlace(HUDPositions.MID_BOT, 0.0, 0.053, 1.0, 0.05)
	g_ModeScript.HUDPlace(HUDPositions.RIGHT_TOP, 0.8, 0.04, 0.3, 0.3)
}




function EnableTickerHud(){
	g_ModeScript.Ticker_AddToHud(OV_HUD, "!info in chat to print mutation details to your console", true)
	g_ModeScript.HUDPlace(HUDPositions.TICKER, 0.0, 0.0, 0.99, 0.25)
	g_ModeScript.Ticker_SetTimeout(16)
	g_ModeScript.Ticker_SetBlinkTime(16)
	OV_HUD.Fields.ticker.flags <- HUDFlags.ALIGN_CENTER | HUDFlags.NOBG | HUDFlags.BLINK
}




function DisableHud(){
	OV_HUD.Fields.timer.flags <- OV_HUD.Fields.timer.flags | HUDFlags.NOTVISIBLE
	OV_HUD.Fields.binds.flags <- OV_HUD.Fields.binds.flags | HUDFlags.NOTVISIBLE
	OV_HUD.Fields.chatcommands.flags <- OV_HUD.Fields.chatcommands.flags | HUDFlags.NOTVISIBLE
}




// Checks if the timer hud is currently visible
// ----------------------------------------------------------------------------------------------------------------------------

function IsTimerHudActive(){
	return !(OV_HUD.Fields.timer.flags & HUDFlags.NOTVISIBLE)
}




EnableHud()

EnableTickerHud()

HUDSetLayout(OV_HUD)




