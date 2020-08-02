//=============================================================================
// L8 Ammo Pack Thrown projectile class
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//
// Modified by (NL)NOOTLORD
//=============================================================================
class L8GIThrown extends BallisticGrenade;

var() int HealingAmount;
var() bool bSuperHeal;
var() Sound HealSound;
var IP_L8GIAmmoPack AmmoPack1;

replication
{
	reliable if (Role < ROLE_Authority)
		SpawnPack, AmmoPack1;
}

simulated event Timer()
{
	if (StartDelay > 0)
	{
		StartDelay = 0;
		bHidden=false;
		SetPhysics(default.Physics);
		SetCollision (default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
		InitProjectile();
		return;
	}
}


function SpawnPack()
{
	if (AmmoPack1 == None)
	{
		AmmoPack1 = Spawn(class'IP_L8GIAmmoPack',,,Self.Location, Self.Rotation);
		AmmoPack1.SetPhysics(PHYS_Falling);
		if (AmmoPack1 != None)
			AmmoPack1.SetBase (self);
		AmmoPack1.bDropped = true;
		AmmoPack1.LifeSpan = 16;
	}
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	SpawnPack();
	
	super.HitWall(HitNormal, Wall);
	
	Destroy();
}

simulated event ProcessTouch( actor Other, vector HitLocation )
{
	local xPawn HitPawn;

	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Base != None)
		return;

	HitPawn = xPawn(Other);
		
	if ( PlayerImpactType == PIT_Stick || (PlayerImpactType == PIT_Bounce))
	{
		HitWall (Normal(HitLocation - Other.Location), Other);
			GiveAmmo(HitPawn);
			if (HealSound != None)
				PlaySound(HealSound, SLOT_Interact );
	}
	
	if (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact)
	{		
		HitWall (Normal(HitLocation - Other.Location), Other);
			GiveAmmo(HitPawn);
			if (HealSound != None)
				PlaySound(HealSound, SLOT_Interact );		
	}	
}

function GiveAmmo( actor Other )
{
	local Inventory Inv, GW;
	local int Count;
	local Weapon W;
	local bool bGetIt;
	local Ammunition A;

	// First go through our inventory and revive all the ghosts
	for (Inv=Pawn(Other).Inventory; Inv!=None && /*!Inv.IsA('L8GIAmmoPack') &&*/ Count < 1000; Count++)
	{
		if (!Inv.IsA('L8GIAmmoPack'))
		{
			// If our grenades ran out, this should bring them back...
			if (BCGhostWeapon(Inv) != None && BCGhostWeapon(Inv).MyWeaponClass != class'L8GIAmmoPack')
			{
				GW = Inv;
				Inv = Inv.Inventory;
				BCGhostWeapon(GW).ReviveWeapon();
			}
			else
				Inv=Inv.Inventory;
		}
	}
	Count = 0;
	// Now give all weapons some ammo
	for (Inv=Pawn(Other).Inventory; Inv!=None && /*!Inv.IsA('L8GIAmmoPack') &&*/ Count < 1000; Inv=Inv.Inventory)
	{
		A = Ammunition(Inv);
		if (A!= None && !A.IsA('Ammo_L8GI'))
		{
			if (A.AmmoAmount < A.MaxAmmo)
			{
				A.AddAmmo(A.InitialAmount);
				BGetIt=true;
			}
		}
		else
		{
			W = Weapon(Inv);
			if (W != None &&  !W.IsA('L8GIAmmoPack')) 
			{
				if (W.bNoAmmoInstances)
				{
					if ( !W.AmmoMaxed(0) && W.GetAmmoClass(0) != None)
					{
						W.AddAmmo(W.GetAmmoClass(0).default.InitialAmount, 0);
						BGetIt=true;
					}
					if ( W.GetAmmoClass(1) != None && W.GetAmmoClass(1) != W.GetAmmoClass(0) && (!W.AmmoMaxed(1)) )
					{
						BGetIt=true;
						W.AddAmmo(W.GetAmmoClass(1).default.InitialAmount, 1);
					}
				}
			}
		}
		Count++;
	}
}

defaultproperties
{
	 Speed=500.000000
	 MaxSpeed=500.000000
     HealSound=Sound'BallisticSounds2.Ammo.AmmoPackPickup'
     RandomSpin=0.000000
     bNoInitialSpin=True 
     TrailOffset=(X=1.600000,Z=6.400000)
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     StaticMesh=StaticMesh'BallisticHardware1.Ammo.AmmoPackHi'
     DrawScale=0.250000
     Skins(0)=Texture'BallisticRecolorsTex.AmmoPack.L8GISkin'
     CollisionRadius=16.000000
     CollisionHeight=15.000000
     bBounce=False
     RotationRate=(Roll=0)
     AmbientGlow=5
     bUnlit=False	 
}
