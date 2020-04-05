//=============================================================================
// 3rd person weapon class for R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class R78Attachment extends BallisticAttachment;

simulated function Vector GetTipLocation()
{
    local Coords C;
    local Vector X, Y, Z;

	if (Instigator.IsFirstPerson())
	{
		if (R78Rifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			C = Instigator.Weapon.GetBoneCoords('tip');
	}
	else
		C = GetBoneCoords('tip');
    return C.Origin;
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
     FlashMode=MU_Primary  
     FlashScale=0.900000
     LightMode=MU_Primary		 
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassMode=MU_Primary	 
     InstantMode=MU_Primary
     TrackAnimMode=MU_None	 
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
	 TracerMode=MU_Primary
     TracerChance=1.000000						  
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary
     FlyBySound=(Sound=Sound'BallisticRecolorsSounds.X82.X82-FlyBy',Volume=1.500000)
     FlyByMode=MU_Primary	 
     ReloadAnim="Reload_AR"
     CockingAnim="Cock_RearPull"
     CockAnimRate=1.100000
     Mesh=SkeletalMesh'BallisticAnims2.Rifle-3rd'
     DrawScale=0.200000
}
