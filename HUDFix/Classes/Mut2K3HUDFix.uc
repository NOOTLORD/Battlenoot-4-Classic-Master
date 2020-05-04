class Mut2K3HUDFix extends Mutator;

function PreBeginPlay()
{
	Super.PreBeginPlay();

	switch(Level.Game.HUDType)
	{
		case "XInterface.HudCDeathMatch":	Level.Game.HUDType = "HUDFix.HudW2K3DeathMatch"; break;
		case "XInterface.HudCTeamDeathMatch":	Level.Game.HUDType = "HUDFix.HudW2K3TeamDeathMatch"; break;
		case "XInterface.HudCCaptureTheFlag":	Level.Game.HUDType = "HUDFix.HudW2K3CaptureTheFlag"; break;
		case "Onslaught.ONSHUDOnslaught": Level.Game.HUDType = "HUDFix.ONSHUDW2K3Onslaught"; Deathmatch(Level.Game).LoginMenuClass = "HUDFix.W2k3OnslaughtLoginMenu"; Level.Game.GameUMenuType = "HUDFix.W2k3OnslaughtLoginMenu"; break;
		case "SkaarjPack.HudInvasion":	Level.Game.HUDType = "HUDFix.HudW2K3Invasion"; break;
		case "UT2k4Assault.HUD_Assault": Level.Game.HUDType = "HUDFix.HUDW2K3Assault"; break;
		case "BonusPack.HudLMS":	Level.Game.HUDType = "HUDFix.HudW2K3LMS"; break;
		case "XInterface.HudCDoubleDomination":	Level.Game.HUDType = "HUDFix.HudW2K3DoubleDomination"; break;
		case "XInterface.HudCBombingRun":	Level.Game.HUDType = "HUDFix.HudW2K3BombingRun"; break;
		case "BonusPack.HudMutant": Level.Game.HUDType = "HUDFix.HudW2K3Mutant"; break;
	}
}

defaultproperties
{
     GroupName="HUD"
     FriendlyName="Heads-Up Display Fix: UT2003 HUDs"
     Description="Enables the UT2003 HUDs for all gametypes using a standard HUD class."
}
