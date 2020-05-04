class InvasionProAlienGibOrganicTorso extends GibOrganicGreenTorso;

simulated function PostBeginPlay()
{
	local Monster M;
	local InvasionProMonsterReplicationInfo IGI;
	local int i;
	local InvasionProAlienGibOrganicLesser Gibble;
	local float NewDrawScale;

	if(Instigator != None)
	{
		M = Monster(Instigator);
		foreach DynamicActors(class'InvasionProMonsterReplicationInfo', IGI)
		{
			NewDrawScale = DrawScale * IGI.GetGibSize(string(M.Class),M.bBoss);
			for(i=0;i<IGI.GetGibCount(string(M.Class),M.bBoss);i++)
			{
				Gibble = Spawn(class'InvasionProAlienGibOrganicLesser',Self,,Location,Rotation);
				if(Gibble != None)
				{
					Gibble.SetDrawScale(NewDrawScale);
					Gibble.SetStaticMesh(StaticMesh);
				}
			}
		}
	}

	Super.PostBeginPlay();
}

defaultproperties
{
     GibGroupClass=Class'InvasionProv1_7.InvasionProAlienGibGroupClass'
     TrailClass=None
     HitSounds(0)=None
     HitSounds(1)=None
     bHidden=True
     CollisionRadius=0.000000
     CollisionHeight=0.000000
}
