class Revenant_Projectile extends Doom_Projectile placeable;

var() Emitter SmokeTrail;
var() class<Emitter> SmokeTrailClass;

simulated function Destroyed()
{
	if(SmokeTrail != None)
	{
		SmokeTrail.Kill();
	}

    Super.Destroyed();
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
    if ( Level.NetMode != NM_DedicatedServer)
    {
        SmokeTrail = Spawn(SmokeTrailClass,self);
        SmokeTrail.SetBase(Self);
    }
}

simulated function PostNetBeginPlay()
{
    Super(Projectile).PostNetBeginPlay();
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
    if(Other != instigator && !Other.IsA('Projectile'))
    {
        Explode(HitLocation, vect(0,0,1));
    }
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,Vector momentum, class<DamageType> damageType)
{
    if ( (Damage > 0) && ((InstigatedBy == None) || (InstigatedBy.Controller == None) || (Instigator == None) || (Instigator.Controller == None) || !InstigatedBy.Controller.SameTeamAs(Instigator.Controller)) )
    {
		 Spawn(class'FatZombie_ProjectileExplosion');
		 HurtRadius(Damage, DamageRadius*0.125, MyDamageType, MomentumTransfer, Location);
		 SetCollision(false,false,false);
		 Destroy();
    }
}

defaultproperties
{
     SmokeTrailClass=Class'DoomMonsterPackv3.Revenant_ProjectileSmokeTrail'
     TrailClass=Class'DoomMonsterPackv3.Revenant_ProjectileTrail'
     Explosionclass=Class'XEffects.NewExplosionA'
     bSeeking=True
     Speed=500.000000
     MaxSpeed=700.000000
     Damage=20.000000
     DamageRadius=45.000000
     MyDamageType=Class'DoomMonsterPackv3.DamType_Revenant_Projectile'
     LightSaturation=127
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'DoomMonsterPackv3.SM.CyberDemonRocketMesh'
     CullDistance=4000.000000
     bNetTemporary=False
     Skins(0)=Texture'DoomMonsterPackv3.Cyberdemon.CyberDemon_RocketTex'
     Skins(1)=Texture'DoomMonsterPackv3.Cyberdemon.CyberDemon_RocketFin'
     SoundRadius=150.000000
     CollisionRadius=13.000000
     CollisionHeight=10.000000
     bProjTarget=True
}
