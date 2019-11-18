//=============================================================================
// XMK5Attachment.
//
// 3rd person weapon attachment for XMK5 SubMachinegun
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class XMK5Attachment extends BallisticAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashBone="Muzzle"
     AltFlashBone="Muzzle2"
     FlashScale=0.200000
     BrassClass=Class'BallisticProV55.Brass_XMK5SMG'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     TracerChance=0.500000
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.250000
     bRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims_25.OA-SMG_3rd'
     DrawScale=0.325000
     bSelected=True
}
