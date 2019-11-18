//=============================================================================
// MarlinAttachment.
//
// 3rd person weapon attachment for Deermaster Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MarlinAttachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     MeleeImpactManager=Class'BallisticProV55.IM_GunHit'
     FlashScale=1.500000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
	 TracerChance=1.000000					  
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
	 FlyBySound=(Sound=Sound'PackageSounds4Pro.X82.X83-FlyBy',Volume=1.500000)
     FlyByMode=MU_Primary
     MeleeStrikeAnim="Melee_Smash"
     Mesh=SkeletalMesh'BWBP4-Anims.Marlin-3rd'
     DrawScale=0.125000
     bSelected=True
}
