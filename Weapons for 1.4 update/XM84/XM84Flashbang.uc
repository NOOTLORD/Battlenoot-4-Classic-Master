//=============================================================================
// XM84Flashbang.
//
// Elite disruption grenade.
// Can be rolled or thrown, but on detonation generates a disruptive wave that
// will disorient and confuse all types of enemies.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM84Flashbang extends BallisticHandGrenade;
var() Material          MatGlow1;     	// adren
var() Material          MatGlow2;    	// blue tech
var() Material          MatGlow3;     	// static
var() Material          MatSparks;    	// cocked

//For when the clip is released
simulated function XM84StaticProOn()
{
	Skins[1]=MatSparks;
}

simulated function XM84StaticProOff()
{
	local float f;

	f = FRand();
	if (f > 0.85)
		Skins[1]=MatGlow3;
	else if (f > 0.55)
		Skins[1]=MatGlow2;
	else
		Skins[1]=MatGlow1;
}

simulated function CheckNoGrenades()
{
	local BCGhostWeapon GW;
	if (Ammo[0]!= None && ( Ammo[0].AmmoAmount < 1 || (Ammo[0].AmmoAmount == 1 && (BFireMode[0].ConsumedLoad > 0  || BFireMode[1].ConsumedLoad > 0)) ))
	{
		AIRating = -999;
		Priority = -999;
		Instigator.Weapon = None;
		// Save a ghost of this wepaon so it can be brought back
		if (Role == ROLE_Authority)
		{
			GW = Spawn(class'BCGhostWeapon',,,Instigator.Location);
    	    if(GW != None)
        	{
        		GW.MyWeaponClass = class;
				GW.GiveTo(Instigator);
			}
		}

		if (Instigator!=None && Instigator.Controller!=None)
			Instigator.Controller.ClientSwitchToBestWeapon();
		Destroy();
	}
	else
		PlayAnim(SelectAnim, 1, 0.0);
}

// AI Interface =====
function byte BestMode()
{
	local Bot B;
	local float Dist, Height, result;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	result = 0.5;

	if (Dist > 500)
		result -= 0.4;
	else
		result += 0.4;
	if (Abs(Height) > 32)
		result -= Height / Dist;
	if (result > 0.5)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist, Height;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;

	Result = AIRating;
	// Enemy too far away
	result += Height/-500;
	if (Height > -200)
	{
		if (Dist > 800)
			Result -= (Dist-800) / 2000;
		if (Dist < 500)
			Result -= 1 - Dist/500;
	}
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.2;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}
// End AI Stuff =====

defaultproperties
{
     MatGlow1=Shader'BallisticRecolorsTex.XM84.XM84-Glow2'
     MatGlow2=Shader'BallisticRecolorsTex.XM84.XM84-Glow4'
     MatGlow3=Shader'BallisticRecolorsTex.XM84.XM84-Glow3'
     MatSparks=Shader'BallisticRecolorsTex.XM84.XM84-Glow'
     FuseDelay=3.000000
     HeldDamage=100
     HeldRadius=350
     HeldMomentum=75000
     HeldDamageType=Class'BWBPRecolorsPro.DT_XM84Held'
     GrenadeSmokeClass=Class'BWBPRecolorsPro.XM84Trail'
     ClipReleaseSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-ClipOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-PinOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI.Icons.BigIcon_XM84'
     BigIconCoords=(Y1=12,Y2=255)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Grenade=True
     ManualLines(0)="Throws an XM84 overarm. After the 1 second fuse has expired, it explodes with a wide radius, inflicting a long-lasting continuous blind with a damage over time component upon the enemy. Can affect allies."
     ManualLines(1)="As primary, but the XM84 is rolled underarm."
     ManualLines(2)="While the XM84 can be cooked in hand, its short fuse makes this a bad idea.||Effective in group engagements."
     SpecialInfo(0)=(Info="60.0;5.0;0.25;30.0;0.0;0.0;0.4")
     BringUpSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.NRP57.NRP57-Putaway')
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=1
     FireModeClass(0)=Class'BWBPRecolorsPro.XM84PrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.XM84SecondaryFire'
     SelectAnimRate=2.000000
     PutDownAnimRate=2.000000
     BringUpTime=0.900000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     bShowChargingBar=False
     bCanThrow=False	 
     AmmoClass(0)=Class'BWBPRecolorsPro.Ammo_XM84_Grenade'
     Description="The XM84 Heavy Disruptor grenade is an advanced electromagnetic pulsar weapon designed for incapacitation and disorientation. State of the art field psionic generators ensure the XM84 can tackle all types of targets. A fission criticality-inducing core combined with the Tandem MS flux generator gives the XM84 the destructive ability to strip away energy shields and fry any electrical system without a Warship-Grade Faraday cage. Warning: Long term exposure to armed XM84s is known to cause acute radiation poisoning and cerebral hemorrhaging. Proximity to a disruptive burst will cause permanent memory loss and irreversible neurological damage."
     Priority=142
     HudColor=(B=255,G=150,R=100)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     PlayerViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     BobDamping=1.000000
     AttachmentClass=Class'BWBPRecolorsPro.XM84Attachment'
     IconMaterial=Texture'BallisticUI.Icons.SmallIcon_XM84'
     IconCoords=(X2=127,Y2=31)
     ItemName="XM84 Flashbang Grenade"
     Mesh=SkeletalMesh'BallisticRecolorsAnims.XM84Grenade'
     DrawScale=0.400000
     AmbientGlow=5	 
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
}
