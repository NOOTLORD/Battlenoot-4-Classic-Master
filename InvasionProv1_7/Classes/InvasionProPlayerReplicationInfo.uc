class InvasionProPlayerReplicationInfo extends xPlayerReplicationInfo;

var() int PlayerHealth;
var() int PlayerHealthMax;

replication
{
    reliable if(Role == ROLE_Authority)
    	PlayerHealth, PlayerHealthMax;
}

defaultproperties
{
}
