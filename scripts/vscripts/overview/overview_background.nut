//****************************************************************************************
//																						//
//								overview_background.nut									//
//																						//
//****************************************************************************************

//backgroundModel <- "models/overview/overview_bg.mdl"
backgroundModel <- "models/overview/overviewmax.mdl"


local backgroundPosition = Vector(0,0,25000.000)
switch(mapname){
	case "c8m5_rooftop" : backgroundPosition = Vector(0,0,256)
}

local BackgroundTable = {
	model = backgroundModel
	targetname = "background_model"
	origin = backgroundPosition
	rendercolor = "25 35 44"
	disableX360 = 0
	ExplodeDamage = 0
	ExplodeRadius = 0
	fademaxdist = 0
	fademindist = 0
	fadescale = -1
	glowrange = 0
	glowrangemin = 0
	glowstate = 0
	health = 0
	LagCompensate = 0
	maxcpulevel = 0
	mincpulevel = 0
	mingpulevel = 0
}

for(local bg = null; bg = Entities.FindByModel(bg, BackgroundTable.model);){
	bg.Kill()
}

SpawnEntityFromTable("prop_dynamic", BackgroundTable)




// Create custom cvars
// ----------------------------------------------------------------------------------------------------------------------------

function AcceptEntityInput(hEntity, sInput, sValue = "", flDelay = 0.0, hActivator = null){
	if (!hEntity) return printl("[AcceptEntityInput] Entity doesn't exist")
	DoEntFire("!self", sInput.tostring(), sValue.tostring(), flDelay.tofloat(), hActivator, hEntity)
}




function ServerCommand(sCommand = "", flDelay = 0.0){
	local hServerCommand = SpawnEntityFromTable("point_servercommand", {})
	AcceptEntityInput(hServerCommand, "Command", sCommand.tostring(), flDelay.tofloat(), null)
	AcceptEntityInput(hServerCommand, "Kill", "", flDelay.tofloat(), null)
}




ServerCommand("setinfo sv_overview_bg_color \"25 35 44\"")
ServerCommand("setinfo sv_orthoscale \"1\"")




::CustomConvars <-
{
	sv_overview_bg_color = { type = "strcolor", defaultValue = "25 35 44", hint = "R G B" }
	sv_orthoscale = { type = "float", defaultValue = "30.0", hint = "FLOAT" }
	
}




foreach(var,varData in CustomConvars){
	ServerCommand(var + " " + varData.defaultValue)
}




::CustomConvarsPreviousValues <- {} 

function CustomConvarListener(){
	foreach(var, property in CustomConvars){
		if(var in CustomConvarsPreviousValues){
			if(property.type == "float"){
				if(CustomConvarsPreviousValues[var].tofloat() != Convars.GetFloat(var)){
					
					CustomConvarChangedValueEvent({ var = var, old_value = CustomConvarsPreviousValues[var], new_value = Convars.GetFloat(var)})
				}
			}else{
				if(CustomConvarsPreviousValues[var] != Convars.GetStr(var)){
					
					CustomConvarChangedValueEvent({ var = var, old_value = CustomConvarsPreviousValues[var], new_value = Convars.GetStr(var)})
				}
			}
		}
		property.type == "float" ? CustomConvarsPreviousValues[var] <- Convars.GetFloat(var) : CustomConvarsPreviousValues[var] <- Convars.GetStr(var)
	}
}




function CustomConvarChangedValueEvent(params){
	switch(params.var){
		case "sv_overview_bg_color" : ChangeBackgroundColor(params.new_value); break
		case "sv_orthoscale": SetOrthoScale(params.new_value); break
	}
}




// Change color of the background prop
// ----------------------------------------------------------------------------------------------------------------------------

function ChangeBackgroundColor(color){
	local model = Entities.FindByModel(null, backgroundModel)
	if(model){
		NetProps.SetPropInt(model, "m_clrRender", GetColorInt(color))
	}
}

