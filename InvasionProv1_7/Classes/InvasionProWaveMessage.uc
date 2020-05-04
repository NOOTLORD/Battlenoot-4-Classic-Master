class InvasionProWaveMessage extends CriticalEventPlus;

var() string DefaultWaveName;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
	if (InvasionProWaveHandler(OptionalObject) != None)
	{
		return InvasionProWaveHandler(OptionalObject).WaveName[switch];
	}
}

defaultproperties
{
     bIsConsoleMessage=False
     Lifetime=2
     DrawColor=(G=0)
     StackMode=SM_Down
     PosY=0.150000
     FontSize=5
}
