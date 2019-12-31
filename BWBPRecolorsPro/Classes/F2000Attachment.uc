//=============================================================================
// F2000Attachment.
//
// Edited by (NL)NOOTLORD 
//=============================================================================
class F2000Attachment extends BallisticAttachment;

var	  BallisticWeapon		myWeap;
var Vector		SpawnOffset;

simulated function Vector GetTipLocation()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{
		if (F2000AssaultRifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			Loc = Instigator.Weapon.GetBoneCoords('tip').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}
	else
		Loc = GetBoneCoords('tip').Origin;
	if (VSize(Loc - Instigator.Location) > 200)
		return Instigator.Location;
    return Loc;
}


function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
}

defaultproperties
{
     MuzzleFlashClass=Class'BWBPRecolorsPro.MARSFlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
     FlashMode=MU_Both	 
     FlashBone="tip2"
     AltFlashBone="tip2"
     FlashScale=0.150000
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassMode=MU_Both
     InstantMode=MU_Both
     LightMode=MU_Primary
     TrackAnimMode=MU_None	 
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerMode=MU_Primary	 
     TracerChance=0.500000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Both 
     ReloadAnim="Reload_AR"
     ReloadAnimRate=0.800000
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.MARS3_TP'
     DrawScale=1.000000
}
