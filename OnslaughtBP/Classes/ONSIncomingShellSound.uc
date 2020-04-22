//-----------------------------------------------------------
//
//-----------------------------------------------------------
class ONSIncomingShellSound extends Actor;

var() float SoundLength;
var() sound ShellSound;

function StartTimer(float TimeToImpact)
{
    SetTimer(TimeToImpact - SoundLength, false);
}

function Timer()
{
    PlaySound(ShellSound, SLOT_None, 2.0, false, 500.0);
	Destroy();
}

defaultproperties
{
     SoundLength=3.000000
     ShellSound=Sound'ONSBPSounds.Artillery.ShellIncoming1'
     DrawType=DT_None
     RemoteRole=ROLE_None
     LifeSpan=8.000000
}