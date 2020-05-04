class InvasionProWaveHandler extends Actor;

var() string WaveName[999];

replication
{
    reliable if(bNetInitial && Role==ROLE_Authority)
        WaveName;
}

event PreBeginPlay()
{
	Super.PreBeginPlay();
}

function string GetTitle(int Index) {
	return WaveName[Index];
}

defaultproperties
{
     WaveName(0)=" Wave 1"
     WaveName(1)=" Wave 2"
     WaveName(2)=" Wave 3"
     WaveName(3)=" Wave 4"
     WaveName(4)=" Wave 5"
     WaveName(5)=" Wave 6"
     WaveName(6)=" Wave 7"
     WaveName(7)=" Wave 8"
     WaveName(8)=" Wave 9"
     WaveName(9)=" Wave 10"
     WaveName(10)=" Wave 11"
     WaveName(11)=" Wave 12"
     WaveName(12)=" Wave 13"
     WaveName(13)=" Wave 14"
     WaveName(14)=" Wave 15"
     WaveName(15)=" Wave 16"
     WaveName(16)=" Wave 17"
     WaveName(17)=" Wave 18"
     WaveName(18)=" Wave 19"
     WaveName(19)=" Wave 20"
     WaveName(20)=" Wave 21"
     WaveName(21)=" Wave 22"
     WaveName(22)=" Wave 23"
     WaveName(23)=" Wave 24"
     WaveName(24)=" Wave 25"
     WaveName(25)=" Wave 26"
     WaveName(26)=" Wave 27"
     WaveName(27)=" Wave 28"
     WaveName(28)=" Wave 29"
     WaveName(29)=" Wave 30"
     WaveName(30)=" Wave 31"
     WaveName(31)=" Wave 32"
     WaveName(32)=" Wave 33"
     WaveName(33)=" Wave 34"
     WaveName(34)=" Wave 35"
     WaveName(35)=" Wave 36"
     WaveName(36)=" Wave 37"
     WaveName(37)=" Wave 38"
     WaveName(38)=" Wave 39"
     WaveName(39)=" Wave 40"
     WaveName(40)=" Wave 41"
     WaveName(41)=" Wave 42"
     WaveName(42)=" Wave 43"
     WaveName(43)=" Wave 44"
     WaveName(44)=" Wave 45"
     WaveName(45)=" Wave 46"
     WaveName(46)=" Wave 47"
     WaveName(47)=" Wave 48"
     WaveName(48)=" Wave 49"
     WaveName(49)=" Wave 50"
     bHidden=True
     bAlwaysRelevant=True
}
