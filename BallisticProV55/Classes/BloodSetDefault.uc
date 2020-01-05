//=============================================================================
// BloodSetDefault.
//
// Info for red blooded brutes like humans and juggs.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BloodSetDefault extends BallisticBloodSet;

defaultproperties
{
     MyBloodName="default-red"
     MyBloodColor=(R=255)
     WaterBloodClass=Class'BallisticProV55.IE_WaterBlood'
     BulletEffect=Class'BallisticProV55.BG_BulletHit'
     BulletHeadEffect=Class'BallisticProV55.BG_BulletHitHead'
     ShotgunEffect=Class'BallisticProV55.BG_ShellHit'
     ExplodeEffect=Class'BallisticProV55.IE_BloodExplode'
     SlashEffect=Class'BallisticProV55.BG_SlashHit'
     SlashHeadEffect=Class'BallisticProV55.BG_SlashHitHead'
     SawEffect=Class'BallisticProV55.BG_SawHit'
     SawHeadEffect=Class'BallisticProV55.BG_SawHit'
     BluntEffect=Class'BallisticProV55.BG_BluntHit'
     WoundDripper=Class'BallisticProV55.BG_BulletWoundSpurter'
     HeadExplode=Class'BallisticProV55.BG_HeadExplode'
     TorsoExplode=Class'BallisticProV55.BG_TorsoExplode'
     ShoulderExplode=Class'BallisticProV55.BG_ShoulderExplode'
     ArmExplode=Class'BallisticProV55.BG_ArmExplode'
     HandExplode=Class'BallisticProV55.BG_HandExplode'
     LegExplode=Class'BallisticProV55.BG_LegExplode'
     FootExplode=Class'BallisticProV55.BG_FootExplode'
     PelvisExplode=Class'BallisticProV55.BG_PelvisExplode'
     ShoulderExplodeLeft=Class'BallisticProV55.BG_ShoulderExplodeLeft'
     ArmExplodeLeft=Class'BallisticProV55.BG_ArmExplodeLeft'
     StumpDripper=Class'BallisticProV55.BG_StumpSpurter'
     DefaultStump=Class'BallisticProV55.BallisticStump'
     CharredStump=Class'BallisticProV55.BWStump_Charred'
     AltStumpMesh=StaticMesh'BWGoreHardwarePro.Stumps.LimbStump2'
     AltCharStumpMesh=StaticMesh'BWGoreHardwarePro.Stumps.StumpCharred2'
     BulletHitSound=SoundGroup'BallisticSounds2.BulletImpacts.BulletFlesh'
     BulletHitHeadSound=SoundGroup'BallisticSounds2.BulletImpacts.Headshot'
     ScreenEffectMisc=Class'BallisticProV55.BG_ScnBlood'
     ScreenEffectSlice=Class'BallisticProV55.BG_ScnBloodSlice'
     ScreenEffectSaw=Class'BallisticProV55.BG_ScnBloodSaw'
     DefaultGibClass=Class'BallisticProV55.BWGib_Default'
}
