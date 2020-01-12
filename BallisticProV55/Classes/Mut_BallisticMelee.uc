//=============================================================================
// Mut_BallisticMelee.
//
// Replaces normal weapons with Ballistic's melee ones
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_BallisticMelee extends Mut_Ballistic;

simulated event PreBeginPlay()
{
	Replacements.Length = 23;
	super.PreBeginPlay();
}
// Modify players and bots a bit
function ModifyPlayer(Pawn Other)
{
	local class<Weapon> FW;
	local int i;

/*	// Make players a bit crap
	Other.GroundSpeed=350;
	Other.WaterSpeed=220;
	Other.AirSpeed=440;
	Other.JumpZ=340;
	Other.WalkingPct=0.5;
	Other.CrouchedPct=0.4;
*/
	// Different UDamage sound
	if (xPawn(Other) != none)
		xPawn(Other).UDamageSound=UDamageSnd;

	// Change things that we can't get to from the server
//	Other.Spawn(class'ClientModifier', Other);

	// No lights please
	xPlayerReplicationInfo(Other.PlayerReplicationInfo).bForceNoPlayerLights = true;

	// Change favorite weapons for bots
	if (Other.Controller != None && Bot(Other.Controller) != None && Bot(Other.Controller).FavoriteWeapon != None)
	{
		FW = Bot(Other.Controller).FavoriteWeapon;
		for (i=0;i<Replacements.Length;i++)
		{
			if (GetInventoryFor(Replacements[i].OldItem) == FW)
				Bot(Other.Controller).FavoriteWeapon = class<Weapon>(GetInventoryFor(GetNewItem(i, true)));
		}
	}
	Super(Mutator).ModifyPlayer(Other);
}

// Check for item replacement.
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	if (Ammo(Other) != None)
	{
		bSuperRelevant = 0;
		return false;
	}
	return super.CheckReplacement(Other, bSuperRelevant);
}

defaultproperties
{
     Replacements(0)=(OldItem=Class'XPickups.HealthPack',NewItemNames=("BallisticProV55.IP_HealthKit"))
     Replacements(1)=(OldItem=Class'XPickups.UDamagePack',NewItemNames=("BallisticProV55.IP_UDamage"))
     DefaultWeaponName="BallisticProV55.X4knife"
     FriendlyName="BallisticPro: Melee Only"
     Description="Play with Ballistic Weapons mutator using only the melee weapons.||http://www.runestorm.com"
}
