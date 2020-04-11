//=============================================================================
// FP7Grenade.
//
// Fiery version of the hand grenade. Has all normal hand grenade features, but
// the projectile spawns fires instead of exploding with a damage radius.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7Grenade extends BallisticHandGrenade;

function DoExplosionEffects()
{
}

function DoExplosion()
{
	local FP7FireControl F;
	local Vector V;

	if (Role == Role_Authority)
	{
		if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
			V = Location;
		else
			V = ThirdPersonActor.Location;
		F = Spawn(class'FP7FireControl',,,Location, rot(0,0,0));
		F.Instigator = Instigator;
		F.bHeld=true;
		F.Initialize();
	}
}

defaultproperties
{
     GrenadeSmokeClass=Class'BallisticProV55.NRP57Trail'
     ClipReleaseSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-ClipOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-PinOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_FP7'
     BigIconCoords=(Y1=12,Y2=240)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Grenade=True
     InventorySize=2
     ManualLines(0)="Throws a grenade overarm. The FP7 grenade explodes into flames, igniting nearby players and obscuring their view for a short period of time. Flames cover the nearby area, dealing damage over time to players standing in them. FP7 flames will push allies of the user outwards, away from the centre of the fire."
     ManualLines(1)="As primary, except the grenade is rolled underarm."
     ManualLines(2)="As with all grenades, Weapon Function or Reload can be used to release the clip and cook the grenade in the user's hand. Care must be taken not to overcook the grenade, lest the user be incinerated. The FP7 grenade is effective in chokepoints, against static positions or when thrown at the enemy en masse."
     SpecialInfo(0)=(Info="0.0;5.0;-999.0;25.0;-999.0;0.0;0.5")
     BringUpSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Putaway')
     CurrentWeaponMode=1
     FireModeClass(0)=Class'BallisticProV55.FP7PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.FP7SecondaryFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.8500000
     CurrentRating=0.8500000
     bCanThrow=False
     AmmoClass(0)=BallisticProV55.Ammo_FP7Grenades'
     Description="A deadly hand grenade, the FP7 releases a searing blast of flames capable of melting metal with tempatures of over 7500 degrees farenheit. The flames will continue to burn for a while, causing significant damage to anyone caught within the blast radius. FP7's are still widely used against both soldiers and equipment. The weapon was used extensivly during both Human-Skrith wars and is especially famous for its part in the UTC-Cryon battles where the UTC 'Ice Hogs' used it to incinerate Cryon cyborgs."
     Priority=5
     HudColor=(G=50)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     GroupOffset=3
     PlayerViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     AttachmentClass=Class'BallisticProV55.FP7Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_FP7'
     IconCoords=(X2=127,Y2=31)
     ItemName="FP7 Grenade"
     Mesh=SkeletalMesh'BallisticAnims1.FP7Grenade'
     DrawScale=0.400000
}
