class InvasionProPetInventory extends Inventory;

var() Monster MyPet;
var() InvasionProPetStatsItem MyStats;
var() float CompanionCooldown;
var() float AuraPower;
var() float AuraRadius;
var() bool bCompanionPet;
var() float LastResurrectTime;
var() float LastLightningTime;
var() float AuraTimer;

replication
{
	reliable if(Role == Role_Authority)
		MyStats, MyPet, AuraRadius, bCompanionPet;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(1,true);
}

function Destroyed()
{
	if(MyStats != None)
	{
		if(bCompanionPet)
		{
			MyStats.CompanionPetDied();
		}
		else if(MyStats.PetCompanion != None)
		{
			MyStats.RecallPet(true);
		}
	}

	Super.Destroyed();
}
//
function DamagedPawn(Pawn P)
{
	local Inventory Inv;

	if(MyStats != None && MyPet != None && Monster(P) != None && P != MyPet && P.Health > 0 && (Level.TimeSeconds - LastLightningTime > (fRand()*5)) &&
	P.Controller != None && FriendlyMonsterController(MyPet.Controller) != None && !FriendlyMonsterController(MyPet.Controller).IsFriend(P.Controller))
	{
		LastLightningTime = Level.TimeSeconds;
		Inv = P.FindInventoryType(class'InvasionProPetLightningInventory');
		if(InvasionProPetLightningInventory(Inv) == None)	//pawn wasnt recently hit with lightning
		{
			Inv = Spawn(class'InvasionProPetLightningInventory',P);
			if(InvasionProPetLightningInventory(Inv) != None)
			{
				InvasionProPetLightningInventory(Inv).MyOwner = MyPet;
				InvasionProPetLightningInventory(Inv).BounceLimit = RandRange(3,8);
				InvasionProPetLightningInventory(Inv).LightningDamage = MyStats.AAXp*MyStats.Ability_AuraChainLightning.AuraChainLightningIncrease;
				InvasionProPetLightningInventory(Inv).BounceRange = MyStats.ABxp*MyStats.Ability_AuraChainLightning.AuraRadiusIncrease;
				InvasionProPetLightningInventory(Inv).BounceCount = 0;
				InvasionProPetLightningInventory(Inv).GiveTo(P);
			}
		}
	}
}

function bool CanResurrect()
{
	local InvasionProPetMinionInventory Inv;
	local int i;

	i = 0;
	foreach DynamicActors(class'InvasionProPetMinionInventory',Inv)
	{
		if(Inv != None && Inv.Master == Self)
		{
			i++;
		}
	}

	if(i >= MyStats.Ability_AuraResurrect.MaxMinions)
	{
		return false;
	}

	return true;
}

simulated function Timer()
{
	local Pawn P, Minion;
	local Monster M;
	local Inventory Inv;
	local float SpeedReduction;

	if(MyPet == None || MyStats == None)
	{
		return;
	}

	if(bCompanionPet)
	{
		if(Role == Role_Authority)
		{
			MyPet.GiveHealth(MyStats.HpRegenXp*MyStats.Ability_HealthRegen.HealthRegenIncrease, MyPet.SuperHealthMax);
		}

		return;
	}

	//update aura id for players hud
	if(Role == Role_Authority)
	{
		Inv = None;
		Inv = MyPet.FindInventoryType(class'InvasionProMonsterIDInv');
		if(InvasionProMonsterIDInv(Inv) != None)
		{
			InvasionProMonsterIDInv(Inv).AuraID = MyStats.Aura;
		}
	}

	if(Role == Role_Authority && FriendlyMonsterController(MyPet.Controller) != None)
	{
		MyPet.GiveHealth(MyStats.HpRegenXp*MyStats.Ability_HealthRegen.HealthRegenIncrease, MyPet.SuperHealthMax);
		Switch(MyStats.Aura)
		{
			case 1:
				AuraTimer = 1.00;
				AuraRadius = MyStats.ABxp*MyStats.Ability_AuraHeal.AuraRadiusIncrease;
				if(AuraRadius > 0)
				{
					AuraPower = MyStats.AAXp*MyStats.Ability_AuraHeal.AuraHealIncrease;
					foreach VisibleCollidingActors(class'Pawn',P,AuraRadius,MyPet.Location)
					{
						if(P != None && P.Health > 0 && P.Controller != None && FriendlyMonsterController(MyPet.Controller).IsFriend(P.Controller))
						{
							P.GiveHealth(int(AuraPower), P.SuperHealthMax);
							Spawn(class'InvasionProPetHealthFX',MyPet,,P.Location);
						}
					}
				}
			break;
			case 2: //damage aura
				AuraTimer = 1.00;
				AuraRadius = MyStats.ABxp*MyStats.Ability_AuraDamage.AuraRadiusIncrease;
				if(AuraRadius > 0)
				{
					AuraPower = MyStats.AAXp*MyStats.Ability_AuraDamage.AuraDamageIncrease;
					foreach VisibleCollidingActors(class'Pawn',P,AuraRadius,MyPet.Location)
					{
						if(P != None && P.Health > 0 && P.Controller != None && !FriendlyMonsterController(MyPet.Controller).IsFriend(P.Controller))
						{
							P.TakeDamage(int(AuraPower), P, P.Location, vect(0,0,0), class'DamType_PetAuraDamage');
							Spawn(class'InvasionProPetDamageFX',MyPet,,P.Location);
						}
					}
				}
			case 4:
				AuraTimer = 1.00;
				//companion aura
				//summon pet if it exists, when it dies do cooldown in inventory class
				if(MyStats.PetCompanion == None && CompanionCooldown <= 0)
				{
					MyStats.SummonCompanion();
				}

				CompanionCooldown -= 1;
			break;
			case 5: //frost aura
				AuraTimer = 1.00;
				AuraRadius = MyStats.ABxp*MyStats.Ability_AuraFrost.AuraRadiusIncrease;
				if(AuraRadius > 0)
				{
					AuraPower = MyStats.AAXp*MyStats.Ability_AuraFrost.AuraFrostIncrease;
					foreach VisibleCollidingActors(class'Monster',M,AuraRadius,MyPet.Location)
					{
						if(M != None && M.Health > 0 && M.Controller != None)
						{
							if(!FriendlyMonsterController(MyPet.Controller).IsFriend(M.Controller) )
							{
								Inv = None;
								Inv = M.FindInventoryType(class'InvasionProFrostInventory');
								if(InvasionProFrostInventory(Inv) == None)
								{
									Inv = Spawn(class'InvasionProFrostInventory',M);
									if(InvasionProFrostInventory(Inv) != None)
									{
										InvasionProFrostInventory(Inv).GiveTo(M);
										InvasionProFrostInventory(Inv).MonsterGroundSpeed = M.GroundSpeed;
										InvasionProFrostInventory(Inv).MonsterAirSpeed = M.AirSpeed;
										InvasionProFrostInventory(Inv).MonsterWaterSpeed = M.WaterSpeed;
										InvasionProFrostInventory(Inv).MonsterJumpZ = M.JumpZ;
										SpeedReduction = ((AuraPower)/100)*M.GroundSpeed;
										M.GroundSpeed -= SpeedReduction;
										SpeedReduction = ((AuraPower)/100)*M.AirSpeed;
										M.AirSpeed -= SpeedReduction;
										SpeedReduction = ((AuraPower)/100)*M.WaterSpeed;
										M.WaterSpeed -= SpeedReduction;
										SpeedReduction = ((AuraPower)/100)*M.JumpZ;
										M.JumpZ -= SpeedReduction;
										Spawn(class'InvasionProPetFrostFX',MyPet,,M.Location);
									}
								}
							}
						}
					}
				}
			break;
			case 7://resurrect
				AuraTimer = 0.1;
				if(CanResurrect() && Level.TimeSeconds - LastResurrectTime > 5)
				{
					AuraRadius = MyStats.ABxp*MyStats.Ability_AuraResurrect.AuraRadiusIncrease;
					AuraPower = MyStats.AAXp*MyStats.Ability_AuraResurrect.AuraResurrectIncrease;
					foreach VisibleCollidingActors(class'Monster',M,AuraRadius,MyPet.Location)
					{
						if(M != None && M.Health <= 0)// && P.Controller != None)
						{
							Inv = None;
							Inv = M.FindInventoryType(class'InvasionProPetMinionInventory');
							if(InvasionProPetMinionInventory(Inv) == None)
							{
								M.SetCollision(false,false,false);
								M.bHidden = true;
								Minion = Spawn(M.class, MyPet,, M.Location,);
								if(Minion != None)
								{
									Minion.Health = AuraPower;
									Inv = Spawn(class'InvasionProPetMinionInventory',Minion);
									if(InvasionProPetMinionInventory(Inv) != None)
									{
										InvasionProPetMinionInventory(Inv).Master = Self;
										InvasionProPetMinionInventory(Inv).GiveTo(Minion);
										//InvasionProPetMinionInventory(Inv).SpawnResurrectTrail();
									}

									Minion.LifeSpan = RandRange(MyStats.Ability_AuraResurrect.MinionLifeSpanMin,MyStats.Ability_AuraResurrect.MinionLifeSpanMax);
									LastResurrectTime = Level.TimeSeconds;
								}
							}
						}
					}
				}
			break;
		}
	}

	if(MyStats.Aura == 3) //defense aura
	{
		AuraTimer = 0.20;
		AuraRadius = MyStats.ABxp*MyStats.Ability_AuraDefense.AuraRadiusIncrease;
		if(AuraRadius > 0)
		{
			ReflectProjectiles(AuraRadius);
		}

		AuraPower += 1;
	}

	SetTimer(AuraTimer,true);
}

simulated function ReflectProjectiles(float ProjRadius)
{
	local Projectile P;
	local float VelMag;
	local vector Dir;

	foreach RadiusActors(class'Projectile',P,ProjRadius,MyPet.Location)
	{
		if(P != None && P.Instigator != None && P.Instigator.PlayerReplicationInfo == None && P.MyDamageType != class'DamType_PetAuraProjectileReflect')
		{
			P.MyDamageType = class'DamType_PetAuraProjectileReflect';
			Dir = Normal(P.Location - MyPet.Location);
			VelMag = VSize(P.Velocity);
			P.Velocity = VelMag * Dir;
			P.Acceleration = Dir;
			P.SetRotation(Rotator(P.Velocity));
			if(Level.NetMode != NM_DedicatedServer)
			{
				Spawn(class'InvasionProPetDeflectFX',MyPet,,P.Location,P.Rotation);
			}
		}
	}
}

defaultproperties
{
     CompanionCooldown=10.000000
     AuraTimer=1.000000
     ItemName="PetInv"
     bOnlyRelevantToOwner=False
     bAlwaysRelevant=True
     bReplicateInstigator=True
}
