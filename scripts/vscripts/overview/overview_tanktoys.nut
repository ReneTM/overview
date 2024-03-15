//****************************************************************************************
//																						//
//									overview_tanktoys_.nut								//
//																						//
//****************************************************************************************



// Returns array of all tanktoys
// ----------------------------------------------------------------------------------------------------------------------------

function GetTanktoys(){
	local toys = []
	foreach(ent in GetAllEntities()){
		if(NetProps.GetPropInt(ent, "m_hasTankGlow") == 1){
			toys.append(ent)
		}
	}
	return toys
}




// Let current tanktoys glow
// ----------------------------------------------------------------------------------------------------------------------------
function SetTankToysGlowingStatic(val){
	
	local glowType = 0
	
	if(val){
		glowType = 3
	}
	
	foreach(ent in GetTanktoys()){
		NetProps.SetPropInt(ent, "m_Glow.m_iGlowType", glowType)
		NetProps.SetPropInt(ent, "m_Glow.m_glowColorOverride", GetColorInt( Vector(0,255,0) ))
	}
}


::model <- null

/*
while(model = Entities.FindByClassname(model, "prop_physics")){
	if(NetProps.GetPropInt(model, "m_fEffects") & 16){
		if(model.GetHealth() == 0){
			NetProps.SetPropInt(model, "m_Glow.m_iGlowType", 3)
			NetProps.SetPropInt(model, "m_massScale", 4.0)
		}
	}
}
*/




// Returns vector color as int
// ----------------------------------------------------------------------------------------------------------------------------

::GetColorInt <- function(col){
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


while(model = Entities.FindByClassname(model, "weapon_*")){
	NetProps.SetPropInt(model, "m_Glow.m_iGlowType", 3)
	NetProps.SetPropInt(model, "m_Glow.m_glowColorOverride", GetColorInt( Vector(0,255,0) ))
}




function MakeSprite(pos, material){
		local ent = SpawnEntityFromTable("env_sprite",{
		origin = pos + Vector(0,0,-28000)
		disablereceiveshadows = 1
		disableX360 = 0
		fademaxdist = -1
		fademindist = -1
		spawnflags = 0
		fadescale = 0
		scale = 0.1
		framerate = 0
		rendermode = 5
		GlowProxySize = 0.0
		renderfx = 0
		HDRColorScale = 0.7
		rendercolor = Vector(255,255,255)
		maxcpulevel = 0
		
		renderamt = 255
		maxgpulevel = 0
		model = "materials/sprites/" + material + ".spr"
		mincpulevel = 0
		mingpulevel = 0
	})
	NetProps.SetPropFloat(ent, "m_flFadeScale", 0.0)
}

::LadderDirs <-
{
	NORTH = 0	// Up
	EAST = 1	// Right
	SOUTH = 2	// Down
	WEST = 3	// Left
}




function GetLadderOffset(ent){
	switch(ent.GetDir()){
		case LadderDirs.NORTH : return Vector(0,-256,0);	break
		case LadderDirs.EAST :  return  Vector(256,0,0);	break
		case LadderDirs.SOUTH : return  Vector(0,256,0);	break
		case LadderDirs.WEST :  return  Vector(-256,0,0);	break
	}
}

::ladders <- {}

NavMesh.GetAllLadders(ladders)

foreach(ent in ladders){
	local bottompos = ent.GetBottomOrigin()
	local toppos = ent.GetTopOrigin()
	local color = ent.IsUsableByTeam(2) ? MakeSprite(bottompos, "ladder") : MakeSprite(bottompos, "infected_ladder")
}

::ladderCameraPositions <- []




// Controll players aim
// ----------------------------------------------------------------------------------------------------------------------------

::SetPlayerAimOn <- function(player, pos){
	player.SetForwardVector( pos - player.EyePosition() )
}




function GetLadderCameraPositions(){
	foreach(ent in ladders){
		//ent.DebugDrawFilled(255, 0, 0, 255, 9999, false)
		local tab = { 
			campos = (ent.GetTopOrigin() + GetLadderOffset(ent))
			aimpos = (ent.GetBottomOrigin() + ent.GetTopOrigin() ) * 0.5
		}
		ladderCameraPositions.append(tab)
	}
}




function LookAtLadder(){
	local ds = ladderCameraPositions[RandomInt(0,ladderCameraPositions.len()-1)]
	player.SetOrigin(ds.campos)
	SetPlayerAimOn(player, ds.aimpos)
}

GetLadderCameraPositions()



/*

::bg <- SpawnEntityFromTable("env_sprite_oriented",{
targetname = "spr_bg"
origin = Vector(0,0,33000)
angles = "0 90 0"
disablereceiveshadows = 1
disableX360 = 0
fademaxdist = -1
fademindist = -1
spawnflags = 0
fadescale = 0
scale = 100.0
framerate = 0
rendermode = 1
GlowProxySize = 0.0
renderfx = 0
HDRColorScale = 1.0
rendercolor = Vector(15,20,35)
maxcpulevel = 0
renderamt = 255
maxgpulevel = 0
model = "materials/sprites/bg.spr"
mincpulevel = 0
mingpulevel = 0
})


local player = GetLocalPlayer()

NetProps.SetPropFloat(bg, "m_flFadeScale", 0.0)

DoEntFire("!self", "showsprite", "", 0.03, player, player)

*/





