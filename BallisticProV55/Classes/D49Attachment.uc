//=============================================================================
// 3rd person weapon class for the D49 Revolver
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class D49Attachment extends HandgunAttachment;

var   byte		RevolverBrass;

replication
{
	reliable if (Role == ROLE_Authority)
		RevolverBrass;
}

simulated event PostNetReceive()
{
	if (RevolverBrass > 0)
	{
		if (RevolverBrass > 127)
			RevolverBrass -= 128;
		RevolverEjectBrass(RevolverBrass);
		RevolverBrass = 0;
	}
	super.PostNetReceive();
}

simulated function RevolverEjectBrass(byte Num)
{
	local int i;
	local Rotator R;

	if (Role == ROLE_Authority)
	{
		if (RevolverBrass > 127)
			RevolverBrass = Num;
		else
			RevolverBrass = Num + 128;
	}
	if (level.NetMode == NM_DedicatedServer)
		return;
	if (Instigator!=None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	for (i=0;i<Num;i++)
		Spawn(BrassClass, self,, GetEjectorLocation(R)+VRand()*2, R);
}

simulated function EjectBrass(byte Mode);

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     FlashScale=0.300000
     ImpactManager=Class'BallisticProV55.IM_Bullet'	 
     BrassClass=Class'BallisticProV55.Brass_D49Pistol'	 
     BrassBone="MagnumWhole"
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'	 
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'	 
	 ReloadAnim="Reload_Pistol"
     ReloadAnimRate=0.350000
     Mesh=SkeletalMesh'BallisticProAnims.D49_TP'
     DrawScale=0.125000
	 Skins(0)=Texture'BallisticProTex.D49.D49-Main'
	 Skins(1)=Texture'BallisticProTex.D49.D49-Shells'
}
