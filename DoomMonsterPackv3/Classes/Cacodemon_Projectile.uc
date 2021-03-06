class Cacodemon_Projectile extends Doom_Projectile;

defaultproperties
{
     TrailClass=Class'DoomMonsterPackv3.Cacodemon_ProjectileTrail'
     Explosionclass=Class'DoomMonsterPackv3.Cacodemon_ProjectileExplosion'
     Speed=900.000000
     MaxSpeed=1500.000000
     Damage=15.000000
     DamageRadius=150.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'DoomMonsterPackv3.DamType_Cacodemon_Projectile'
     ImpactSound=Sound'DoomMonsterPackv3.Cacodemon.caco_pimpact_05'
     ExplosionDecal=Class'XEffects.RocketMark'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=28
     LightSaturation=127
     LightBrightness=169.000000
     LightRadius=4.000000
     DrawType=DT_Sprite
     CullDistance=4000.000000
     bDynamicLight=True
     AmbientSound=Sound'DoomMonsterPackv3.Cacodemon.caco_fireball_travel_loop'
     LifeSpan=10.000000
     Texture=Texture'DoomMonsterPackv3.Effects.Invis_Mat'
     DrawScale=0.200000
     SoundVolume=255
     SoundRadius=150.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
}
