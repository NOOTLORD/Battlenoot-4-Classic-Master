class InvasionProNecroMessages extends CriticalEventPlus;

var() string SingleMessage, GroupMessage;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
	if( Switch == 0 )
	{
		return default.SingleMessage;
	}
	else
	{
		return RelatedPRI_1.PlayerName@default.GroupMessage;
	}

}

defaultproperties
{
     SingleMessage="You are about to be resurrected!"
     GroupMessage="was resurrected!"
     bIsConsoleMessage=False
     DrawColor=(B=0,G=255,R=255)
     StackMode=SM_Down
     PosY=0.300000
     FontSize=2
}
