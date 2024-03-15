//****************************************************************************************
//																						//
//									ov_entity_manipulator.nut							//
//																						//
//****************************************************************************************



function ManipulateMapEntities(){
	KillEntities()
	KillAnyWind()
	StopSpotLights()
	StopDynamicProps()
	StopRotators()
}




// Disable wind when theres any
// ----------------------------------------------------------------------------------------------------------------------------

function KillAnyWind(){
	for(local wind = null; wind = Entities.FindByClassname(wind, "env_wind");){
		NetProps.SetPropInt(wind,"m_EnvWindShared.m_iMinGust", 0)
		NetProps.SetPropInt(wind,"m_EnvWindShared.m_iMaxGust", 0)
		NetProps.SetPropInt(wind,"m_EnvWindShared.m_iMinWind", 0)
		NetProps.SetPropInt(wind,"m_EnvWindShared.m_iMaxWind", 0)
		NetProps.SetPropFloat(wind,"m_EnvWindShared.m_flWindSpeed", 0.0)
	}
}




local SpotlightPositions =
{
	c11m3_garage =
	[
		Vector(-5383.870117, -2136.669922, 190.904999)
		Vector(-5384.870117, -2119.669922, 189.904999)
		Vector(-3562.330078, 2872.129883, 189.889008)
		Vector(-3579.330078, 2871.129883, 188.889008)
		Vector(-3452.129883, 2524.669922, 147.494003)
		Vector(-3451.129883, 2507.669922, 146.494003)
		Vector(-933.130005, 3356.669922, 421.028992)
		Vector(-932.130005, 3339.669922, 420.028992)
		Vector(-4193.805176, 864.737488, 74.623703)
		Vector(-4167.615234, 891.403503, 74.623703)
		Vector(-4167.615234, 891.403503, 74.623703)
		Vector(-4193.805176, 864.737488, 74.623703)
		Vector(-5304.609863, -920.182983, 227.893005)
		Vector(-5287.609863, -919.182983, 226.893005)
		Vector(-2730.080078, 3838.850098, 130.423996)
		Vector(-2731.080078, 3855.850098, 129.423996)
		Vector(-4615.870117, 1840.829956, 177.595001)
		Vector(-4616.870117, 1857.829956, 176.595001)
		Vector(-6327.819824, -1528.609985, 395.649994)
		Vector(-6328.819824, -1511.609985, 394.649994)
		Vector(-5850.270020, -2200.300049, 190.904999)
		Vector(-5833.270020, -2199.300049, 189.904999)
		Vector(-1235.109985, 2930.219971, 389.764008)
		Vector(-1232.810059, 1853.160034, 387.917999)
		Vector(-1233.949951, 3754.040039, 391.295990)
		Vector(-1245.300049, 4276.720215, 392.000000)
		Vector(-4547.330078, 764.979004, 49.115700)
		Vector(-4494.129883, 728.554993, 48.879398)
		Vector(-1938.910034, 3390.209961, 430.074005)
		Vector(-1938.959961, 3314.169922, 430.074005)
		Vector(-1748.069946, 3314.129883, 430.074005)
		Vector(-1748.020020, 3390.159912, 430.074005)
		Vector(-1556.959961, 3314.129883, 430.074005)
		Vector(-1556.910034, 3390.159912, 430.074005)
		Vector(-6264.979980, -1197.800049, 287.795990)
		Vector(-6257.060059, -1231.170044, 288.277008)
		Vector(-6233.970215, -1224.790039, 258.431000)
		Vector(-6245.890137, -1191.410034, 257.950989)
		Vector(-6235.810059, -2070.600098, 204.427002)
		Vector(-6266.919922, -2053.629883, 204.427002)
		Vector(-6235.810059, -2070.600098, 168.427002)
		Vector(-6266.919922, -2053.629883, 168.427002)
		Vector(-1862.519897, 4021.057617, 38.262249)
		Vector(-1847.395386, 4077.046875, 38.276249)
	]
}




function StopSpotLights(){
	for(local spotlight = null; spotlight = Entities.FindByClassname(spotlight, "beam_spotlight");){
			NetProps.SetPropInt(spotlight, "m_isRotating", 0)
			EntFire("beam_spotlight", "stop", 0.0)
			DoEntFire("!self", "stop", "", 0.0, spotlight, spotlight)
	}

	if(mapname == "c8m5_rooftop"){
		local ent = null
		ent = Entities.FindByClassnameWithin(null, "func_rotating", Vector(5218.000, 9138.500, 5954.800), 4.0); ent.SetAngles(QAngle(0,135,0))
		DoEntFire("!self", "stop", "", 0.00, ent, ent)
		ent = Entities.FindByClassnameWithin(null, "func_rotating", Vector(5214.00, 7873.400, 5954.800), 4.0); ent.SetAngles(QAngle(0,45,0))
		DoEntFire("!self", "stop", "", 0.00, ent, ent)
		ent = Entities.FindByClassnameWithin(null, "func_rotating", Vector(7714.000, 7873.500, 5954.800), 4.0); ent.SetAngles(QAngle(0,-45,0))
		DoEntFire("!self", "stop","", 0.00, ent, ent)
		ent = Entities.FindByClassnameWithin(null, "func_rotating", Vector(6968.000, 8984.500, 6208.500), 4.0); ent.SetAngles(QAngle(0,45,0))
		DoEntFire("!self", "stop", "", 0.00, ent, ent)
	}
	


	if(mapname == "c11m3_garage"){
		local ent = null
		if(mapname in SpotlightPositions){
			foreach(pos in SpotlightPositions[mapname]){
				while(ent=Entities.FindByClassnameWithin(ent, "beam_spotlight", pos, 4.0))
				if(ent){
					ent.SetAngles(QAngle(0,45,0))
					DoEntFire("!self", "stop", "", 0.00, ent, ent)
					NetProps.SetPropInt(ent, "m_isRotating", 0)
					NetProps.SetPropFloat(ent, "m_flRotationSpeed", 0.0)
					
				}
			}
		}
	}
}




function KillEntities(){
	local ents = [
	//"keyframe_rope"
	//"move_rope"
	"func_areaportalwindow"
	]
	foreach(entname in ents){
		for(local ent = null; ent = Entities.FindByClassname(ent, entname);){
			ent.Kill()
		}
	}
}


function StopDynamicProps(){
	local prop = null;
	while(prop = Entities.FindByClassname(prop, "prop_dynamic")){
		NetProps.SetPropFloat(prop, "m_flPlaybackRate", 0.0)
	}
}

function StopRotators(){
	local ent = null;
	while(ent = Entities.FindByClassname(ent, "func_rotating")){
		NetProps.SetPropInt(ent, "m_iEFlags", 0)
	}
}


