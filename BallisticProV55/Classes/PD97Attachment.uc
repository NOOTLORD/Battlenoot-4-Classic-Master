//=============================================================================
// 3rd person weapon class for the PD-97 Bloodhound
//
// by Azarael
// adapting code by Nolan "Dark Carnivour" Richert
// Aspects of which are copyright (c) 2006 RuneStorm. All rights reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class PD97Attachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     FlashMode=MU_Primary 
	 FlashScale=0.350000
     ImpactManager=Class'BallisticProV55.IM_Bullet' 
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassMode=MU_None	 
     InstantMode=MU_None
     LightMode=MU_Primary
     TrackAnimMode=MU_None
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     TracerMode=MU_Primary
     TracerChance=1.000000	 
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_None
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     FlyByMode=MU_Primary	 
     ReloadAnim="Reload_BreakOpen"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=1.70000
     Mesh=SkeletalMesh'BallisticAnims1.Bloodhound_TP'
     RelativeLocation=(Z=11.000000)
     DrawScale=0.150000	
	 Skins(0)=Texture'BallisticWeapons1.Bloodhound.BloodhoundMain'
	 Skins(1)=Texture'BallisticWeapons1.Bloodhound.BloodhoundAmmo'
	 Skins(2)=Texture'BallisticWeapons1.Bloodhound.BloodhoundAcc'
	 Skins(3)=Shader'BallisticWeapons1.General.RedDotSightShader'
}
