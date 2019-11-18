//=============================================================================
// AS50's burner effect.
//=============================================================================
class AS50ActorFire extends BallisticEmitter
	placeable;

var   Actor				Victim;
var   float				Fuel, MaxFuel, Damage;
var   Controller		InstigatorController;
var class<DamageType> DamageType;

function Reset()
{
	Destroy();
}

simulated event TornOff()
{
	Kill();
}

simulated function Initialize(Actor V)
{
	if (V == None)
		return;

	Victim = V;
	if (Role == ROLE_Authority)
		SetTimer(0.75, true);

	if (level.netMode == NM_DedicatedServer)
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
		Emitters[3].Disabled=true;
		Emitters[4].Disabled=true;
	}
	SetBase(Victim);
}

function AddFuel(float Amount)
{
	if (Fuel == -1)
		return;
	Fuel = FMin(Fuel+Amount, MaxFuel);
}

event Tick (float DT)
{
	if (Fuel == -1)
		return;

	Fuel -= DT;
	if (Victim == none || Fuel <= 0 || Victim.PhysicsVolume.bWaterVolume || (Pawn(Victim)!= None && Pawn(Victim).Health < 1))
	{
		Fuel=-1;
		if (level.netMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
			bTearOff=True;
		else Kill();
		return;
	}
}

event Timer()
{
	if (bTearOff)
		Destroy();
		
	if (Fuel == -1)
		return;

	if (Victim != None && Role ==ROLE_Authority && Fuel > 0)
	{
		if ( Instigator == None || Instigator.Controller == None )
			Victim.SetDelayedDamageInstigatorController( InstigatorController );

		class'BallisticDamageType'.static.GenericHurt (Victim, Damage, Instigator, Location, vect(0,0,0), DamageType);
	}
}

function PhysicsVolumeChange( PhysicsVolume NewVolume )
{
	if ( NewVolume.bWaterVolume )
	{
		if (level.netMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
			bTearOff=True;
			
		else Kill();
	}
}

defaultproperties
{
     Fuel=3.000000
     MaxFuel=5.000000
     Damage=7.000000
     DamageType=Class'BWBPRecolorsPro.DT_AS50Immolation'
     Emitters(0)=SpriteEmitter'BallisticProV55.RX22AActorFire.SpriteEmitter11'

     Emitters(1)=SpriteEmitter'BallisticProV55.RX22AActorFire.SpriteEmitter0'

     Emitters(2)=SpriteEmitter'BallisticProV55.RX22AActorFire.SpriteEmitter1'

     Emitters(3)=SpriteEmitter'BallisticProV55.RX22AActorFire.SpriteEmitter6'

     Emitters(4)=SpriteEmitter'BallisticProV55.RX22AActorFire.SpriteEmitter3'

     AutoDestroy=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     AmbientSound=Sound'BallisticSounds2.FP7.FP7FireLoop'
     bFullVolume=True
     SoundVolume=255
     SoundRadius=128.000000
     bNotOnDedServer=False
}
