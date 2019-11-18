//=============================================================================
// DragonsToothAttachment.
//
// Attachment for the Dragon's Tooth Sword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DragonsToothAttachment extends BallisticMeleeAttachment;

var   bool					bRedTeam;	//Owned by red team?

replication
{
	reliable if ( Role==ROLE_Authority )
		bRedTeam;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	if (Instigator != None)
	{
		if ((Instigator.PlayerReplicationInfo != None) && (Instigator.PlayerReplicationInfo.Team != None) || bRedTeam )
		{
			if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 || bRedTeam )
			{
				Skins[0] = Shader'BallisticRecolors3TexPro.DragonToothSword.DTS-Red3rd';
				LightHue=5;
			}			
			else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 1 )
				Skins[0] = Shader'BallisticRecolors3TexPro.DragonToothSword.DTS-Shine3rd';
		}
	
		if (Owner == None || Instigator == Owner)
		LightType = LT_None;
	}
}

defaultproperties
{
     ImpactManager=Class'BWBPRecolorsPro.IM_DTS'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     bHeavy=True
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=160
     LightSaturation=64
     LightBrightness=150.000000
     LightRadius=64.000000
     bDynamicLight=True
     AmbientSound=Sound'PackageSounds4Pro.DTS.DragonsTooth-Loop'
     Mesh=SkeletalMesh'BallisticRecolors4AnimPro.DragonsTooth_third'
     RelativeLocation=(Z=6.000000)
     DrawScale=0.120000
     bFullVolume=True
     SoundVolume=255
     SoundRadius=256.000000
     TransientSoundVolume=0.800000
     TransientSoundRadius=256.000000
}
