//=============================================================================
// RSDarkPrimaryFire.
//
// A73 primary fire is a fast moving projectile that goes through enemies and
// isn't hard to spot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkPrimaryFire extends BallisticProProjectileFire;

#exec OBJ LOAD FILE=BWBP4-Sounds.uax

var   Actor						MuzzleFlashFast;
var   Actor						MuzzleFlashSlow;
var   Actor						MuzzleFlame;

var() sound					FireSoundLoop;
var() sound					FireSound2;
var   bool						bIsZapping;
var() int						Damage;

var 	float						ModePowerDrain;

var   bool						bPendingOwnerZap;
var   float						PendingZapDamage;

var   bool						bIgnited;

struct ImmolateVic
{
	var actor Vic;
	var float Dist;
	var RSDarkImmolateBurner Fire;
};
var float 						ImmolatePower;
var() sound					ImmolateSoundLoop;


// ModeDoFire from WeaponFire.uc, but with a few changes
simulated event ModeDoFire()
{
    if (!AllowFire())
        return;
    if (bIsJammed)
    {
    	if (BW.FireCount == 0)
    	{
    		bIsJammed=false;
			if (bJamWastesAmmo && Weapon.Role == ROLE_Authority)
			{
				ConsumedLoad += Load;
				Timer();
			}
	   		if (UnjamMethod == UJM_FireNextRound)
	   		{
		        NextFireTime += FireRate;
   			    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
				BW.FireCount++;
    			return;
    		}
    		if (!AllowFire())
    			return;
    	}
    	else
    	{
	        NextFireTime += FireRate;
   		    NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		return;
   		}
    }

	if (BW != None)
	{
		BW.bPreventReload=true;
		BW.FireCount++;

		if (BW.ReloadState != RS_None)
		{
			if (weapon.Role == ROLE_Authority)
				BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}
	}

    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

	ConsumedLoad += Load;
	SetTimer(FMin(0.1, FireRate/2), false);
    // server
    if (Weapon.Role == ROLE_Authority)
    {
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    if(InStr(Level.Game.GameName, "Freon") != -1 && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
		class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
    }

	if (!BW.bScopeView)
		BW.FireChaos = FClamp(BW.FireChaos + FireChaos, 0, 1);

	BW.LastFireTime = Level.TimeSeconds;


    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
    {
        ServerPlayFiring();
    }

    // set the next firing time. must be careful here so client and server do not get out of sync
    if (bFireOnRelease)
    {
        if (bIsFiring)
            NextFireTime += MaxHoldTime + FireRate;
        else
            NextFireTime = Level.TimeSeconds + FireRate;
    }
    else if (bBurstMode)
    {
		BurstCount++;
    	if (BurstCount >= MaxBurst)
    	{
    		NextFireTime += 0.7;
    		NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    		BurstCount = 0;
    	}
    	else
    	{
    		NextFireTime += FireRate * 0.75;
  			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
  		}
    }
    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	if (BW != None)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
		if (bCockAfterFire || (bCockAfterEmpty && BW.MagAmmo - ConsumedLoad < 1))
			BW.bNeedCock=true;
	}
}

simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;

	if (BW.bScopeView || BW.CurrentWeaponMode != 0 || BW.CurrentWeaponMode != 4)
		return super.GetFireSpread();
	else
	{
		fX = frand();
		R.Yaw =  1024 * sin ((frand()*2-1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
		R.Pitch = 1024 * sin ((frand()*2-1) * 1.5707963267948966) * cos(fX*1.5707963267948966);
		return Vector(R);
	}
}


function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if (MuzzleFlashFast == None || MuzzleFlashFast.bDeleteMe )
		class'RSDarkStar'.static.InitMuzzleFlash (MuzzleFlashFast, class'RSDarkFastMuzzleFlash', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if (MuzzleFlashSlow == None || MuzzleFlashSlow.bDeleteMe )
		class'RSDarkStar'.static.InitMuzzleFlash (MuzzleFlashSlow, class'RSDarkSlowMuzzleFlash', Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	MuzzleFlash = MuzzleFlashSlow;
}

// Remove effects
simulated function DestroyEffects()
{
	Super(WeaponFire).DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlashFast);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashSlow);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlame);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	RSDarkAttachment(Weapon.ThirdPersonActor).DarkUpdateHit(BW.CurrentWeaponMode);
}

simulated function SwitchWeaponMode (byte NewMode)
{
	Super.SwitchWeaponMode(NewMode);

	switch(NewMode)
	{
		case 0:
			MuzzleFlash = MuzzleFlashSlow;
			ModePowerDrain=0;
			break;
		case 1:
			MuzzleFlash = MuzzleFlashFast;
			ModePowerDrain=0;
			break;
		case 2:
			MuzzleFlash = None;
			ModePowerDrain=0.05;
			break;
		case 3:
			MuzzleFlash = None;
			ModePowerDrain=0.1;
			break;
		case 4:
			MuzzleFlash = MuzzleFlashSlow;
			ModePowerDrain=1;
			break;
		default:
			MuzzleFlash = MuzzleFlashFast;
			ModePowerDrain=0;
			break;
	}

	if (RSDarkStar(BW).bOnRampage)
		ModePowerDrain *= 0.4;
}

//Staves deal backlash damage to hip spammer scum (Slow Bolt)
function DoFireEffect()
{
	Super.DoFireEffect();

	if (BW.CurrentWeaponMode == 0 && !BW.bScopeView)
	{
		Instigator.PlaySound(Sound'BWBP4-Sounds.Dark-ImmolateIgnite',,3.7,,32);
		class'BallisticDamageType'.static.GenericHurt (Instigator, ProjectileClass.default.Damage * ((10 - RSDarkStar(BW).SoulPower) / 40), None, Instigator.Location, -vector(Instigator.GetViewRotation()) * 3000 + vect(0,0,1000), class'DT_RSDarkBacklash');
	}

	/*else if (BW.CurrentWeaponMode == 1)
		class'BallisticDamageType'.static.GenericHurt (Instigator, ProjectileClass.default.Damage * 0.1, None, Instigator.Location, vect(0,0,0), class'DT_RSDarkBacklash');*/
}

function StartBerserk()
{
   	FireRate *= 0.75;
    FireAnimRate = default.FireAnimRate/0.75;
    RecoilPerShot = default.RecoilPerShot * 0.75;
    FireChaos = default.FireChaos * 0.75;
}

function StopBerserk()
{
	if (BW.CurrentWeaponMode == 0)
		FireRate = default.FireRate;
	else FireRate = FireModes[BW.CurrentWeaponMode-1].mFireRate;
    FireAnimRate = default.FireAnimRate;
    RecoilPerShot = default.RecoilPerShot;
    FireChaos = default.FireChaos;
}

function StartSuperBerserk()
{
	if (BW.CurrentWeaponMode == 4)
    	FireRate = 0.8;
	else if (BW.CurrentWeaponMode == 3)
    	FireRate = 0.1;
	else if (BW.CurrentWeaponMode == 2)
    	FireRate = 0.1;
	else if (BW.CurrentWeaponMode == 1)
    	FireRate = 0.15;
	else
    	FireRate = 0.8;
    FireRate /= Level.GRI.WeaponBerserk;
    FireAnimRate = default.FireAnimRate * Level.GRI.WeaponBerserk;
    ReloadAnimRate = default.ReloadAnimRate * Level.GRI.WeaponBerserk;
}

event Timer()
{
	super.Timer();
	if (bIgnited && (!IsFiring() || Weapon.GetFireMode(1).IsFiring() || (!IsInState('DarkFlamer') && !IsInState('Immolate'))))
		StopFlaming();
}

function StopFlaming()
{
	bIgnited = false;
	ImmolatePower = 0;
	if (MuzzleFlame != None)
	{	Emitter(MuzzleFlame).Kill();	MuzzleFlame = None;	}
	Instigator.AmbientSound = BW.UsedAmbientSound;
	Instigator.SoundVolume = Weapon.default.SoundVolume;
}

// ========================================================================
// Flamer State
// ========================================================================
state DarkFlamer
{
	function float MaxRange()	{	return 800;	}

	function DoFireEffect()
	{
    	local Vector Start, Dir, End, HitLocation, HitNormal;
    	local Rotator Aim;
		local actor Other;
		local float Dist;
		local int i;
		local RSDarkFlameProjectile Prj;

	    // the to-hit trace always starts right in front of the eye
		Start = Instigator.Location + Instigator.EyePosition();
		Aim = GetFireAim(Start);
		Aim = Rotator(GetFireSpread() >> Aim);

	    Dir = Vector(Aim);
		End = Start + (Dir*MaxRange());

		Weapon.bTraceWater=true;
		for (i=0;i<20;i++)
		{
			Other = Trace(HitLocation, HitNormal, End, Start, true);
			if (Other == None || Other.bWorldGeometry || Mover(Other) != none || FluidSurfaceInfo(Other) != None || (PhysicsVolume(Other) != None && PhysicsVolume(Other).bWaterVolume))
				break;
			Start = HitLocation + Dir * FMax(32, (Other.CollisionRadius*2 + 4));
		}
		Weapon.bTraceWater=false;

		if (Other == None)
			HitLocation = End;
		if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			Other = None;

		Dist = VSize(HitLocation-Start);

		Prj = Spawn (class'RSDarkFlameProjectile',Instigator,, Start, Rotator(HitLocation-Start));
		if (Prj != None)
		{
			Prj.Instigator = Instigator;
			Prj.InitFlame(HitLocation);
			Prj.bHitWall = Other != None;
		}

		RSDarkAttachment(Weapon.ThirdPersonActor).DarkUpdateFlameHit(Other, HitLocation, HitNormal);

		Super(BallisticFire).DoFireEffect();

		//Consumes soulpower or HP
		if (RSDarkStar(Weapon).SoulPower >= ModePowerDrain)
			RSDarkStar(Weapon).AddSoul(-ModePowerDrain);
		else
		{
			Instigator.PlaySound(Sound'BWBP4-Sounds.Dark-ImmolateIgnite',,3.7,,32);
			RSDarkStar(Weapon).AddSoul(-5);
			class'BallisticDamageType'.static.GenericHurt (Instigator, 100 * (ModePowerDrain - RSDarkStar(Weapon).SoulPower), Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 3000 + vect(0,0,1000), class'DT_RSDarkBacklash');
		}
	}

	//Do the spread on the client side
	function PlayFiring()
	{
	    ClientPlayForceFeedback(FireForce);  // jdf
	    FireCount++;

		Instigator.AmbientSound = FireSoundLoop;
		Instigator.SoundVolume = 255;

		if (!bIgnited)
		{
			BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
			bIgnited = true;
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		}
		if (MuzzleFlame == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlame, class'RSDarkMuzzleFlame', Weapon.DrawScale*FlashScaleFactor, weapon, 'tip');
	}

	function ServerPlayFiring()
	{
		if (!bIgnited)
		{
			BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
			bIgnited = true;
			Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		}
	}

	simulated function bool AllowFire()
	{
		if (!super.AllowFire() || Instigator.HeadVolume.bWaterVolume)
		{
			if (bIgnited)
				StopFiring();
			return false;
		}
		return true;
	}

	function StopFiring()
	{

		bIgnited = false;
			Instigator.AmbientSound = BW.UsedAmbientSound;

		Instigator.SoundVolume = Weapon.default.SoundVolume;
		if (MuzzleFlame != None)
		{
			Emitter(MuzzleFlame).Kill();
			MuzzleFlame = None;
		}
	}

	function FlashMuzzleFlash();
}

//Fireballs
state Fireball
{
	function DoFireEffect()
	{
		Super.DoFireEffect();

		//Consumes soulpower or HP
		if (RSDarkStar(Weapon).SoulPower >= ModePowerDrain)
			RSDarkStar(Weapon).AddSoul(-ModePowerDrain);
		else
		{
			Instigator.PlaySound(Sound'BWBP4-Sounds.Dark-ImmolateIgnite',,3.7,,32);
			RSDarkStar(Weapon).AddSoul(-5);
			class'BallisticDamageType'.static.GenericHurt (Instigator, 100 * (ModePowerDrain - RSDarkStar(Weapon).SoulPower), Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 3000 + vect(0,0,1000), class'DT_RSDarkBacklash');
		}
	}
}

// ========================================================================
// Cone Immolation
// ========================================================================
state Immolate
{
	function float MaxRange()	{	return 1400;	}

	function DoFireEffect()
	{
		local Actor Victims;
		local array<ImmolateVic> Vics;
		local int i, j;
		local float Dist;

		foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, 1400, Instigator.Location )
		{
			if ( Victims != None && Victims != Instigator && Victims.Role == ROLE_Authority && Pawn(Victims)!=None && Pawn(Victims).Health > 0)
			{
				if (Normal(Victims.Location - Instigator.Location) Dot vector(Instigator.GetViewRotation()) > 0.75)
				{
					Dist = VSize(Victims.Location - Instigator.Location);
					for (i=0;i<Vics.length;i++)
						if (Vics[i].Dist > Dist)
							break;
					Vics.Insert(i, 1);
					Vics[i].Vic = Victims;
					Vics[i].Dist = Dist;
					for (j=0;j<Victims.Attached.length;j++)
						if (RSDarkImmolateBurner(Victims.Attached[j]) != None)
						{
							Vics[i].Fire = RSDarkImmolateBurner(Victims.Attached[j]);
							break;
						}
				}
			}
		}
		if (Vics.length > 0)
			ImmolatePower += 0.5;

		for (i=0;i<Vics.length;i++)
		{
			if (Vics[i].Fire != None)
			{
				Vics[i].Fire.AddPower(0.6);
				j++;
			}
		}
		if (ImmolatePower >= j + 1)
		{
			for (i=0;i<Vics.length;i++)
			{
				if (Vics[i].Fire == None)
				{
					Vics[i].Fire = spawn(class'RSDarkImmolateBurner', Vics[i].Vic,, Vics[i].Vic.Location);
					Vics[i].Fire.Initialize(Vics[i].Vic);
					Vics[i].Fire.InstigatorController = Instigator.Controller;
					Vics[i].Fire.Instigator = Instigator;
					break;
				}
			}
		}

		//Consumes soulpower or HP
		if (RSDarkStar(Weapon).SoulPower >= ModePowerDrain)
			RSDarkStar(Weapon).AddSoul(-ModePowerDrain);
		else
		{
			Instigator.PlaySound(Sound'BWBP4-Sounds.Dark-ImmolateIgnite',,3.7,,32);
			RSDarkStar(Weapon).AddSoul(-5);
			class'BallisticDamageType'.static.GenericHurt (Instigator, 100 * (ModePowerDrain - RSDarkStar(Weapon).SoulPower), Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 3000 + vect(0,0,1000), class'DT_RSDarkBacklash');
		}
	}

	function PlayFiring()
	{
	    ClientPlayForceFeedback(FireForce);  // jdf
	    FireCount++;

		if (!bIgnited)
		{
			Instigator.AmbientSound = ImmolateSoundLoop;
			Instigator.SoundVolume = 255;

			BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
			bIgnited = true;
		}
		if (MuzzleFlame == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlame, class'RSDarkMuzzleFlame', Weapon.DrawScale*FlashScaleFactor, weapon, 'tip');
	}

	function ServerPlayFiring()
	{
		BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (!bIgnited)
			bIgnited = true;
	}

	simulated function bool AllowFire()
	{
		if (!super.AllowFire() || Instigator.HeadVolume.bWaterVolume)
		{
			if (bIgnited)
				StopFiring();
			return false;
		}
		return true;
	}

	function StopFiring()
	{
		ImmolatePower = 0;
		bIgnited = false;
		Instigator.AmbientSound = BW.UsedAmbientSound;
		Instigator.SoundVolume = Weapon.default.SoundVolume;
		if (MuzzleFlame != None)
		{
			Emitter(MuzzleFlame).Kill();
			MuzzleFlame = None;
		}
	}

	function FlashMuzzleFlash();
}

//Accessor for stats
static function FireModeStats GetStats()
{
	local FireModeStats FS;

	FS.DamageInt = default.FireModes[0].mProjClass.default.Damage;
	FS.Damage = String(FS.DamageInt);
	FS.DPS = default.FireModes[0].mProjClass.default.Damage / default.FireModes[0].mFireRate;
	FS.TTK = default.FireModes[0].mFireRate * (Ceil(175/default.FireModes[0].mProjClass.default.Damage) - 1);
	if (default.FireModes[0].mFireRate < 0.5)
		FS.RPM = String(int((1 / default.FireModes[0].mFireRate) * 60))@default.ShotTypeString$"/min";
	else FS.RPM = 1/default.FireModes[0].mFireRate@"times/second";
	FS.RPShot = default.FireModes[0].mRecoil;
	FS.RPS = default.FireModes[0].mRecoil / default.FireModes[0].mFireRate;
	FS.FCPShot = default.FireModes[0].mFireChaos;
	FS.FCPS = default.FireModes[0].mFireChaos / default.FireModes[0].mFireRate;
	FS.Range = "Max:"@(10000 / 52.5)@"metres";

	return FS;
}

defaultproperties
{
     FireSoundLoop=Sound'BWBP4-Sounds.DarkStar.Dark-AltFireLoop'
     Damage=50
     ImmolateSoundLoop=Sound'BWBP4-Sounds.DarkStar.Dark-Immolation'
     SpawnOffset=(X=40.000000,Y=8.000000,Z=-10.000000)
     FireModes(0)=(mProjClass=Class'BallisticProV55.RSDarkFastProjectile',mFireRate=0.160000,mFireChaos=0.060000,mFireSound=Sound'BWBP4-Sounds.DarkStar.Dark-Fire2',mFireAnim="Fire2",mRecoil=192.000000,mAmmoPerFire=2,bModeLead=True,bModeSplash=True)
     FireModes(1)=(mFireRate=0.100000,mFireSound=Sound'BWBP4-Sounds.DarkStar.Dark-AltFireStart',mFireAnim="SecFireLoop",bLoopedAnim=True,mFireEndAnim="SecFireEnd",mRecoil=7.000000,mAmmoPerFire=1,TargetState="DarkFlamer",bModeInstantHit=True)
     FireModes(2)=(mFireRate=0.100000,mFireSound=Sound'BWBP4-Sounds.DarkStar.Dark-AltFireStart',mFireAnim="SecFireLoop",bLoopedAnim=True,mFireEndAnim="SecFireEnd",mRecoil=7.000000,mAmmoPerFire=1,TargetState="Immolate",bModeInstantHit=True)
     FireModes(3)=(mProjClass=Class'BallisticProV55.RSDarkFireBomb',mFireRate=0.800000,mFireChaos=0.150000,mFireSound=Sound'BWBP4-Sounds.DarkStar.Dark-FireBall',mFireAnim="Fire",mRecoil=1024.000000,mAmmoPerFire=4,TargetState="fireball",bModeLead=True,bModeSplash=True,bModeRecommendSplash=True)
     MuzzleFlashClass=Class'BallisticProV55.RSDarkSlowMuzzleFlash'
     RecoilPerShot=1024.000000
     FireChaos=0.250000
     FireChaosCurve=(Points=(,(InVal=0.160000),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     BallisticFireSound=(Sound=Sound'BWBP4-Sounds.DarkStar.Dark-Fire',Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     ReloadAnimRate=1.100000
     FireRate=1.350000
     AmmoClass=Class'BallisticProV55.Ammo_DarkDiamond'
     AmmoPerFire=10
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.RSDarkProjectile'
     WarnTargetPct=0.200000
}
