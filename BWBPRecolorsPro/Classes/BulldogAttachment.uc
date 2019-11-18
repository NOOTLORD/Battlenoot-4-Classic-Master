//=============================================================================
// BulldogAttachment.
//
// 3rd person weapon attachment for the Suzuki XL7
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BulldogAttachment extends BallisticAttachment;
var() class<actor>			AltBrassClass1;			//Alternate Fire's brass
var() class<actor>			AltBrassClass2;			//Alternate Fire's brass (whole FRAG-12)

// Fling out shell casing
simulated function EjectBrass(byte Mode)
{
	local Rotator R;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	if (BrassClass == None)
		return;
	if (BrassMode == MU_None || (BrassMode == MU_Secondary && Mode == 0) || (BrassMode == MU_Primary && Mode != 0))
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;
	if (Mode == 0)
		Spawn(BrassClass, self,, GetEjectorLocation(R), R);
	else if (Mode != 0)
		Spawn(AltBrassClass1, self,, GetEjectorLocation(R), R);
}

defaultproperties
{
     AltBrassClass1=Class'BWBPRecolorsPro.Brass_FRAGSpent'
     AltBrassClass2=Class'BWBPRecolorsPro.Brass_FRAG'
     MuzzleFlashClass=Class'BWBPRecolorsPro.AH104FlashEmitter'
     AltMuzzleFlashClass=Class'BWBPRecolorsPro.AH104FlashEmitter'
     ImpactManager=Class'BWBPRecolorsPro.IM_ExpBulletLarge'
     AltFlashBone="ejector"
     BrassClass=Class'BWBPRecolorsPro.Brass_BOLT'
     BrassMode=MU_Both
     FlashMode=MU_Both
     TracerClass=Class'BWBPRecolorsPro.TraceEmitter_Bulldog'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.3RD-Bulldog'
     RelativeLocation=(X=-2.000000,Z=-3.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.300000
}
