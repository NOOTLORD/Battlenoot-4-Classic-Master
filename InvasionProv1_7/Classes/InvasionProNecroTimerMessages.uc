class InvasionProNecroTimerMessages extends CriticalEventPlus;

var() string NumberMessage[4];

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
	return default.NumberMessage[Switch];
}

defaultproperties
{
     NumberMessage(0)="0"
     NumberMessage(1)="1"
     NumberMessage(2)="2"
     NumberMessage(3)="3"
     bIsConsoleMessage=False
     Lifetime=1
     DrawColor=(B=0,G=1,R=255)
     StackMode=SM_Down
     PosY=0.300000
}
