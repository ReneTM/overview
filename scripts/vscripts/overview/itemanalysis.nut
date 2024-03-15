/*
	VISUALISATION OF CURRENTLY SPAWNED ITEMS | ReneTM | 20210317
*/

local WeaponEntityNames =
[
	// Health
	{ entname = "weapon_adrenaline", color = Vector(0,255,0) }
	{ entname = "weapon_first_aid_kit",  color = Vector(0,255,0) }
	{ entname = "weapon_pain_pills",  color = Vector(0,255,0) }
	{ entname = "weapon_defibrillator",  color = Vector(0,255,0) }
	// Throwables
	{ entname = "weapon_molotov",  color = Vector(255,122,0) }
	{ entname = "weapon_pipe_bomb",  color = Vector(255,122,0) }
	{ entname = "weapon_vomitjar",  color = Vector(255,122,0) }
	// Carryables
	{ entname = "weapon_propanetank",  color = Vector(0,255,174) }
	{ entname = "weapon_oxygentank",  color = Vector(0,255,174) }
	{ entname = "weapon_gascan",  color = Vector(0,255,174) }
	{ entname = "weapon_cola_bottles",  color = Vector(0,255,174) }
	{ entname = "weapon_fireworkcrate",  color = Vector(0,255,174) }
	{ entname = "weapon_gnome",  color = Vector(0,255,174) }
	// Pistols
	{ entname = "weapon_pistol_magnum",  color = Vector(255,0,0) }
	{ entname = "weapon_pistol",  color = Vector(255,0,0) }
	// Shotguns
	{ entname = "weapon_autoshotgun",  color = Vector(255,0,0) }
	{ entname = "weapon_pumpshotgun",  color = Vector(255,0,0) }
	{ entname = "weapon_shotgun_chrome",  color = Vector(255,0,0) }
	{ entname = "weapon_shotgun_spas",  color = Vector(255,0,0) }
	// Rifles
	{ entname = "weapon_rifle_ak47",  color = Vector(255,0,0) }
	{ entname = "weapon_rifle_desert",  color = Vector(255,0,0) }
	{ entname = "weapon_rifle_m60",  color = Vector(255,0,0) }
	{ entname = "weapon_rifle_sg552",  color = Vector(255,0,0) }
	{ entname = "weapon_rifle",  color = Vector(255,0,0) }
	// SMGs
	{ entname = "weapon_smg_mp5",  color = Vector(255,0,0) }
	{ entname = "weapon_smg_silenced",  color = Vector(255,0,0) }
	{ entname = "weapon_smg",  color = Vector(255,0,0) }
	// Snipers
	{ entname = "weapon_sniper_awp",  color = Vector(255,0,0) }
	{ entname = "weapon_sniper_military",  color = Vector(255,0,0) }
	{ entname = "weapon_sniper_scout",  color = Vector(255,0,0) }
	{ entname = "weapon_hunting_rifle",  color = Vector(255,0,0) }
	// Upgradepacks
	{ entname = "weapon_upgradepack_explosive",  color = Vector(255,90,0) }
	{ entname = "weapon_upgradepack_incendiary",  color = Vector(255,90,0) }
	{ entname = "upgrade_laser_sight",  color = Vector(255,90,0) }
	// Specials
	{ entname = "weapon_chainsaw",  color = Vector(255,0,0) }
	{ entname = "weapon_grenade_launcher",  color = Vector(255,0,0) }
	// Etc
	//{ entname = "weapon_melee",  color = Vector(255,0,0) }
	{ entname = "weapon_ammo",  color = Vector(255,0,0) }
]


local counts_weps = {}

// Iteration over all current spawned items
// ----------------------------------------------------------------------------------------------------------------------------

foreach(DS in WeaponEntityNames){
	local ent = null
	while(ent = Entities.FindByClassname(ent, DS.entname)){
		if(!(DS.entname in counts_weps)){
			counts_weps[DS.entname] <- 1
		}else{
			counts_weps[DS.entname]+=1
		}
		DebugDrawText(ent.GetOrigin() + Vector(0,0,16), DS.entname, false, 60.0)
		DebugDrawBox(ent.GetOrigin() + Vector(0,0,32), Vector(1,1,1024), Vector(-1,-1,-1), DS.color.x, DS.color.y, DS.color.z, 150, 60.0)
	}
}

foreach(DS in WeaponEntityNames){
	local ent = null
	while(ent = Entities.FindByClassname(ent, DS.entname + "_spawn")){
		if(!((DS.entname + "_spawn") in counts_weps)){
			counts_weps[(DS.entname + "_spawn")] <- 1
		}else{
			counts_weps[(DS.entname + "_spawn")]+=1
		}
		DebugDrawText(ent.GetOrigin() + Vector(0,0,16), DS.entname + "_spawn", false, 60.0)
		DebugDrawBox(ent.GetOrigin() + Vector(0,0,32), Vector(1,1,1024), Vector(-1,-1,-1), DS.color.x, DS.color.y, DS.color.z, 150, 60.0)
	}
}






// Output of counts_weps
// ----------------------------------------------------------------------------------------------------------------------------

foreach(entname, count in counts_weps){
	ClientPrint(null, 5, "" + entname + ": " + count)
}




local models =
[
	{ model = "models/props_junk/gascan001a.mdl", name = "Gascan" }
	{ model = "models/props_junk/propanecanister001a.mdl", name = "Propane Canister" }
	{ model = "models/props_equipment/oxygentank01.mdl", name = "Oxygentank" }
	{ model = "models/props_junk/explosive_box001.mdl", name = "Explosive Box" }
]


foreach(DS in models){
	local ent = null
	while(ent = Entities.FindByModel(ent, DS.model)){
		DebugDrawText(ent.GetOrigin() + Vector(0,0,16), ent.GetClassname() + " (" + DS.name + ")", false, 60.0)
		DebugDrawBox(ent.GetOrigin() + Vector(0,0,32), Vector(1,1,1024), Vector(-1,-1,-1), 0, 64, 128, 150, 60.0)
	}
}





local ent = null;



while(ent = Entities.FindByClassname(ent, "weapon_spawn")){
	local wepname = NetProps.GetPropString(ent, "m_iszWeaponToSpawn")
	local count = NetProps.GetPropInt(ent, "m_itemCount")
	DebugDrawText(ent.GetOrigin() + Vector(0,0,16), ent.GetClassname() + " " + wepname + "(" + count + ")", false, 60.0)
	DebugDrawBox(ent.GetOrigin() + Vector(0,0,32), Vector(1,1,1024), Vector(-1,-1,-1), 255, 255, 255, 150, 60.0)
}

while(ent = Entities.FindByClassname(ent, "weapon_melee_spawn")){
	local wepname = NetProps.GetPropString(ent, "m_iszMeleeWeapon")
	local count = NetProps.GetPropInt(ent, "m_itemCount")
	DebugDrawText(ent.GetOrigin() + Vector(0,0,16), ent.GetClassname() + " " + wepname + "(" + count + ")", false, 60.0)
	DebugDrawBox(ent.GetOrigin() + Vector(0,0,32), Vector(1,1,1024), Vector(-1,-1,-1), 255, 0, 255, 150, 60.0)
}

while(ent = Entities.FindByClassname(ent, "weapon_melee")){
	local wepname = NetProps.GetPropString(ent, "m_strMapSetScriptName")
	DebugDrawText(ent.GetOrigin() + Vector(0,0,16), ent.GetClassname() + "(" + wepname + ")", false, 60.0)
	DebugDrawBox(ent.GetOrigin() + Vector(0,0,32), Vector(1,1,1024), Vector(-1,-1,-1), 225, 42, 247, 150, 60.0)
}


::upgradeData <-
{
c10m1_caves =
[
{ origin = Vector(-12544,-12064,-51), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-12672,-7888,-40), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-12296,-7296,-40), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-13584,-5224,-248), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c10m2_drainage =
[
{ origin = Vector(-8080,-7200,-554), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8944,-8608,-388), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6152,-6832,-4), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-9842,-7348,-728), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c10m3_ranchhouse =
[
{ origin = Vector(-9584,-7392,-55), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c10m4_mainstreet =
[
{ origin = Vector(-3500,-2340,-9), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3488,-2656,-48), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-48,-736,-16), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(32,-2400,-40), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(773.518,-1809.97,10.3761), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1064,-1712,22), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1960,-2928,238), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2552,-3160,240), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c10m5_houseboat =
[
{ origin = Vector(1920,3800,-55), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3376,2736,-32), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3648,272,-142), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3384,-2640,-56.9985), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c11m1_greenhouse =
[
{ origin = Vector(6304,-1016,681), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(5160,-1000,680), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4880,720,545), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3464,32,536), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2768,1440,408), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3248,1808,408), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2720,2288,272), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3360,2040,304), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3112,1968,72), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3176,2400,72), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4576,2304,56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4968,2008,56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2664,2400,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c11m2_offices =
[
{ origin = Vector(5608,3144,57), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4472,3072,448), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4576,2424,448), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(5264,3000,584), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8592,3528,712), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(9424,4528,648), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8980,3968,654), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8672,4096,648), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8576,4576,648), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8560,4016,398), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(9456,4576,368), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(9712,4256,368), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(10224,4496,368), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(10240,4288,232), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(9504,4576,232), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8944,4512,232), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8600,4112,265), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8880,4376,96), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(7928,5736,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c11m3_garage =
[
{ origin = Vector(-2544,3536,305), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2192,3536,32), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2688,3536,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3024,4720,160), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3504,3376,36.9224), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2480,2864,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2479.27,2496.91,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2864,2432,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3536,2304,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3328,2800,66), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3904,2256,40), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4128,3472,56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4320,1536,56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4880,-64,36), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-5184,-1328,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4992,-576,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6016,-1344,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c11m4_terminal =
[
{ origin = Vector(2440,3288,196), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2240,3216,160), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3096,2112,160), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1552,2672,60), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1216,392,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(896,224,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(808,880,256), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1056,2312,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(208,3568,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-472,5176,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-408,5616,334), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(232,5472,340), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c11m5_runway =
[
{ origin = Vector(-4480,9984,-120), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c12m1_hilltop =
[
{ origin = Vector(-10752,-12432,456), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-11276,-9760,456), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-11456,-10156,456), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-10008,-8912,440), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7840,-9056,296), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7244,-8924,312), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6560,-8096,392), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c12m2_traintunnel =
[
{ origin = Vector(-6314,-6170,395), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6468,-7064,220), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6672,-6176,220), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7192,-6168,178), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8736,-6900,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7680,-7776,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7988,-7776,176), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7976,-7328,176), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7360,-8028,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7984,-8544,-49.9735), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6528,-7240,220), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6632,-7064,220), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7392,-7232,208), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7584,-7216,208), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8752,-7200,208), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8744,-6040,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7720,-6048,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7344,-6048,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7184,-6040,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6672,-6992,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6280,-6776,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6560,-6352,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c12m3_bridge =
[
]
c12m4_barn =
[
]
c12m5_cornfield =
[
{ origin = Vector(8736,736,209), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8152,184,208), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(7340,-224,395), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(6980,940,246), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(6352,1044,446), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8768,184,208), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c13m1_alpinecreek =
[
{ origin = Vector(-3080,-704,83), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c13m2_southpinestream =
[
{ origin = Vector(773,4801,281), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c13m3_memorialbridge =
[
{ origin = Vector(-752,-4396,1343), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(920,-4312,266), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c13m4_cutthroatcreek =
[
]
c1m1_hotel =
[
]
c1m2_streets =
[
{ origin = Vector(-8984,-1664,397), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-9152,-3872,397), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7872,-3352,420), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1752,3856,564), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(1664,2840,588), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(1128,2472,624), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-960,2880,324), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-640,3032,80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2176,528,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2200,976,56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2616,1368,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-3676,2164,144), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-3740,2260,339), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-5096,1768,392), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-5496,1261,400), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-8264,-1460,392), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-4784,-1864,505), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c1m3_mall =
[
]
c1m4_atrium =
[
{ origin = Vector(-2361,-5169,544.209), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2248,-5226,544.209), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2597.03,-5191,544.209), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2374,-5233,544.209), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2256,-5322,544.209), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2597.03,-5255,544.209), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2597.03,-5319,544.209), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2373,-5306,544.209), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
{ origin = Vector(-2258,-5198,544), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 0 }
]
c2m1_highway =
[
{ origin = Vector(2411.55,5835.94,-919), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4800.81,7863.08,-696), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1636,5889,-925.711), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2070,3157,-762.393), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2940,4135,-927.75), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1187.65,2258,-1203.4), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2348.83,5235.06,-760), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2736,4480,-960), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c2m2_fairgrounds =
[
{ origin = Vector(2352.92,1758.43,17), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3355.03,995.207,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3091.37,-559.016,141), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3884,-4056,-120), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4368,-1888,-116), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1560,1644,20), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3806,-809,-84), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1560,1688,17), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1688,1824,48), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2752,416,32), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3712,464,44), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4352,176,48), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4096,368,48), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3904,-144,48), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4352,-976,8.00001), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2208,-1560,10.4075), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1496,-1344,66), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1000,-1488,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(680,-80,43), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2400,1024,-88.0002), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2608,-1240,-83), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2696,-1392,-83), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2984,-1392,-80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3208,-1376,-80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3184,-1640,-89), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3520,-672,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1248,-3168,-84), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1392,-3200,-84), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3360,-3888,-120), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1680,-6736,-80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1872,-6768,-80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-48,384,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2502,-1466,64.0677), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2948.26,-4927.5,-120), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c2m3_coaster =
[
{ origin = Vector(-373.16,4413.06,192), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-464,4464,164), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1480,3076,0), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2912,2244,0), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1460,1504,12), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1568,1996,48), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1808,1408,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1720,2016,12), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3529,1689,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3648,2292,280), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-556,2028,12), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1747.79,1048.29,44.0183), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1721.75,1308.29,44.0183), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1596,4672,61.5383), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(412.939,4829.19,133), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1517.13,1375.16,68), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1359.75,1499.63,20.0183), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3712,2292,280), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-608,4592,192), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-608,4524,192), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2262,3734,-0.0142975), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1996,2900,-0.0142975), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2336,2908,-0.0142975), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2240,3680,-0.0142975), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(306,3948,218), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-608,4488,164), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-608,4564,164), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3680,2292,280), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1517.13,1407.16,44), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1900,3096,0), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(78.1655,4136.96,1), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1741.75,1308.29,68.0183), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1727.79,1048.29,68.0183), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-532,2028,40), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2912,1852,40), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4304,1536,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2832,1744,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1824,1080,16), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1440,1976,48), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-816,1404,12), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1383.75,1499.63,68.0183), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1517.13,1375.16,12), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1896,2876,0), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1472,3968,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-464,4492,192), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-401.16,4413.06,140), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-704,1560,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3683.78,1371.01,168), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c2m4_barns =
[
]
c2m5_concert =
[
{ origin = Vector(-2338.5,3573.75,-133.9), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c3m1_plankcountry =
[
{ origin = Vector(-9072,9096,152), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-10080,8864,200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-10688,10668,201), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7926,8712,208), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8536,7284,80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8548,6984,94), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7016,7688,128), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-6240,6464,218), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1968,8536,36), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-792,7480,152), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-710,7708,210), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c3m2_swamp =
[
{ origin = Vector(-7880,5412,15), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4720.68,3796.33,30.7098), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2796.23,4208.21,21.1018), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1972,2880,43.5199), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1974.1,2393.39,17.96), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2043.97,3456.2,144), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(6617.05,1618.96,25.0655), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(7774.4,2954.18,129.433), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c3m3_shantytown =
[
{ origin = Vector(-3853,-3241,140), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3869,-2940,127), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3926,-2940,127), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3948,-3224,107), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-5801.14,737,206), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-5836.95,737,206), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-5390.7,-3301.68,191.649), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-5529.5,-3096.62,143.649), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1556,-4736,18), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c3m4_plantation =
[
]
c4m1_milltown_a =
[
{ origin = Vector(-540.76,6380.25,312.458), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-858.755,5629.57,272), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1647.35,4414.01,225.273), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1973.53,3228.4,218), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2695.84,2478.13,112), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4310.26,1369.84,192), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4173.88,904.444,109), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4322.05,-413.058,112), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1322.09,6356,174.016), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3897,-1881,136.342), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3977,-1877,169.496), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c4m2_sugarmill_a =
[
{ origin = Vector(1677,-5424,271.25), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
{ origin = Vector(3641,-2009,136.592), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3721,-2005,169.746), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c4m3_sugarmill_b =
[
{ origin = Vector(1677,-5424,271), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
{ origin = Vector(3641,-2009,136.342), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3721,-2005,169.496), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c4m4_milltown_b =
[
{ origin = Vector(-540.76,6380.25,312.458), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-858.755,5629.57,272), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1647.35,4414.01,225.273), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1973.53,3228.4,218), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2695.84,2478.13,112), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4310.26,1369.84,192), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4173.88,904.444,109), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4322.05,-413.058,112), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1322.09,6356,174.016), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3897,-1881,136.342), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3977,-1877,169.496), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c4m5_milltown_escape =
[
{ origin = Vector(-540.76,6380.25,312.458), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-858.755,5629.57,272), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1647.35,4414.01,225.273), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1973.53,3228.4,218), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2695.84,2478.13,112), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4310.26,1369.84,192), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4173.88,904.444,109), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4322.05,-413.058,112), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1322.09,6356,174.016), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3897,-1881,136.342), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3977,-1877,169.496), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c5m1_waterfront =
[
{ origin = Vector(-1361,-1239,-366), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c5m1_waterfront_sndscape =
[
]
c5m2_park =
[
]
c5m3_cemetery =
[
{ origin = Vector(4425,2866,67.039), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2822.47,2795.54,229.25), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3013.58,2459.96,186.873), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3302.07,314.995,200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2868.8,902.647,174.378), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(5982.7,839.062,8.2005), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c5m4_quarter =
[
{ origin = Vector(-2828.68,4089.32,121), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3034.43,3124.81,239), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2400,2208,72), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-296,2080,100), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-696,1701,80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-408,2336,271), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-800,2440,295), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1184,2184,265), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-384,1200,264), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1976,800,248), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1920,800,88), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2544,-240,112), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2272,-216,111), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1416,-1584,104), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-600,-1256,264), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-552,-2512,80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-48,-2080,80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2028,908,116), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c5m5_bridge =
[
]
c6m1_riverbank =
[
{ origin = Vector(1393.74,-951.951,584), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1393.74,-951.951,584), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2194.92,1890.62,681), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1596.38,1838.25,520), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1239.24,1580.38,200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1631.93,2133.9,520), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2012.69,2143.94,680), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3026.28,-849.743,698.132), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2915.97,245.353,682.132), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2200.4,2018.07,680), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2261.07,1944.97,395.96), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c6m2_bedlam =
[
{ origin = Vector(1466.51,-247.995,73), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2378.54,141.163,-7), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1019.46,688.364,41), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(165.171,2749.11,-107.749), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(538.435,3617.34,177), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1240.6,4944.63,41), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1889.79,4922.31,-143), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2212.42,5178.28,-351), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2262.69,4497.76,-335), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1514.14,4518.87,-358.574), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(956.158,4509.62,-360.8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(354.616,5142.87,-326.77), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2466.89,5028.46,-1055), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(105.098,2768.42,184), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2974.71,-1115.75,-288), angles = "0 0 0", Explosive = 0 , Incendiary = 0 , Laser = 1 }
]
c6m3_port =
[
{ origin = Vector(-1504,-588,14.7617), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1576,-984,-88), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-688,288,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-696,776,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-936,1016,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1224,1024,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2296,904,11), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1400,2120,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1168,1616,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(534,-490,52), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(784,-496,52), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(768,-288,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1072,-304,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(768,-632,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c7m1_docks =
[
{ origin = Vector(7920,189.05,0.85533), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(7909,193,0.85533), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(10132,591,16), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8987.3,1990.68,140.227), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8876.88,952.905,55), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(5920,1056,175.621), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4086,968,186), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2865.49,947.217,320), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c7m2_barge =
[
{ origin = Vector(2024,1597,167.625), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4197,-766,198), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3588,1533,52.5), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2498,1170.53,193), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(11071.7,-195.099,136.063), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-760,479,200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8988.06,1839.32,129.732), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1439.77,864.099,209.026), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(5950.76,1301.41,182.221), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8075.87,1337.65,88), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c7m3_port =
[
{ origin = Vector(-1171.7,-290.171,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(895.699,-738.644,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1846.92,-847.971,41.85), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1626.22,777.54,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1317.44,-287.882,168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(727,-353,36.0857), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(737,-353,36.0857), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-540.882,-1184.06,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(527.191,-494.383,52.2776), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c8m1_apartment =
[
]
c8m2_subway =
[
{ origin = Vector(7449.28,2444.73,-280), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(6267.1,4511.69,-328), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4040,3743,-464), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(7197.11,4541.75,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8162,4112,288), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8602.3,4067.92,-140.768), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(7731,3945,40.4485), angles = "0 0 0", Explosive = 0 , Incendiary = 1 , Laser = 0 }
]
c8m3_sewers =
[
{ origin = Vector(13612.7,9475.49,-472), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(10787.2,7427.93,204.141), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(12252.8,5152.12,62.3813), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(10578.9,5654.54,55.1265), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(12684.4,10059.8,-472), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(12919.2,8820.29,-248), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(14392.4,11194.3,-344), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c8m4_interior =
[
{ origin = Vector(12564.3,13577.5,296.939), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(13738.7,14211.7,466), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(12097,12132,160), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(12890.5,13479,24), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c9m1_alleys =
[
{ origin = Vector(-9576,-10600,-80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-9432,-10664,-80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-9480,-10920,-80), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8872,-10952,72), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-9016,-10944,72), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-9624,-10592,72), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8888,-10616,72), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8040,-9648,20), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-8040,-9944,16), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7336,-9752,16), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-7568,-9920,16), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-5800,-10280,72), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-5312,-10280,72), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-5080,-10968,72), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4184,-9656,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4184,-9848,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-4080,-9080,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-3784,-9304,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2632,-8808,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2264,-9064,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2424,-9064,8), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2648,-5768,40), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(848,-6344,-136), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1024,-6336,-136), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(864,-5784,-136), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(840,-5552,-136), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(944,-5264,-136), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-1752,-5896,40), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2258,-5565,40), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-2000,-5416,40), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(32,-1472,-200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(-352,-1632,-200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(720,-1584,-168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
c9m2_lots =
[
{ origin = Vector(800,-1120,-168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1800,-1360,-184), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1824,-768,-184), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1536,-616,-184), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2296,-488,-216), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2056,-928,-216), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2336,336,-152), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2656,-608,-172), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2776,-604,-200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2776,-676,-200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4676,496,-208), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(1656,-1048,-184), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2544,168,-208), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3008,552,-168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2592,-496,-208), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(2296,-560,-216), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3800,-872,-200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3928,-1104,-200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3864,-664,-200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4936,344,-168), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(5800,960,-136), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(3432,4720,56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4640,4904,56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4632,5352,56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4256,5856,104), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4024,6440,104), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(6888,6456,184), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8488,6416,200), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(8480,5880,56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
{ origin = Vector(4008,1576,-56), angles = "0 0 0", Explosive = 1 , Incendiary = 1 , Laser = 1 }
]
}

if(mapname in upgradeData){
	foreach(DS in upgradeData[mapname]){
		DebugDrawText(DS.origin, "Exp:" + DS.Explosive + ", Incendiary: " + DS.Incendiary + ", Laser: " + DS.Laser, false, 60.0)
		//DebugDrawBox(ent.GetOrigin() + Vector(0,0,32), Vector(1,1,1024), Vector(-1,-1,-1), 225, 42, 247, 150, 60.0)
	}
}
