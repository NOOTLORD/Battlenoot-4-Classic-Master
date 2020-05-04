class MutHUDFix extends Mutator;

function PreBeginPlay()
{
	Super.PreBeginPlay();
	
	switch(Level.Game.HUDType)
	{
		case "XInterface.HudCDeathMatch":	Level.Game.HUDType = "HUDFix.HudWDeathMatch"; break;
		case "XInterface.HudCTeamDeathMatch":	Level.Game.HUDType = "HUDFix.HudWTeamDeathMatch"; break;
		case "XInterface.HudCCaptureTheFlag":	Level.Game.HUDType = "HUDFix.HudWCaptureTheFlag"; break;
		case "Onslaught.ONSHUDOnslaught": Level.Game.HUDType = "HUDFix.ONSHUDWOnslaught"; break;
		case "SkaarjPack.HudInvasion":	Level.Game.HUDType = "HUDFix.HudWInvasion"; break;
		case "UT2k4Assault.HUD_Assault": Level.Game.HUDType = "HUDFix.HUDWAssault"; break;
		case "BonusPack.HudLMS":	Level.Game.HUDType = "HUDFix.HudWLMS"; break;
		case "XInterface.HudCDoubleDomination":	Level.Game.HUDType = "HUDFix.HudWDoubleDomination"; break;
		case "XInterface.HudCBombingRun":	Level.Game.HUDType = "HUDFix.HudWBombingRun"; break;
		case "BonusPack.HudMutant": Level.Game.HUDType = "HUDFix.HudWMutant"; break;
		//case "Jailbreak.JBInterfaceHUD": Level.Game.HUDType = "HUDFix.JBWInterfaceHUD"; break;
	}
}

defaultproperties
{
     GroupName="HUD"
     FriendlyName="Heads-Up Display Fix"
     Description="Enables various HUD fixes for UT2004's standard HUDs."
}
