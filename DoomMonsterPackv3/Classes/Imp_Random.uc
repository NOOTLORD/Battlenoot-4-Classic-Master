class Imp_Random extends Imp;

var() Material ImpSkins[6];
var() class<MaterialSequence> ImpFadeClass[6];

simulated function PostBeginPlay()
{
	local int i;

	i = Rand(6);
	Skins[0] = ImpSkins[i];
	FadeClass = ImpFadeClass[i];
	Super.PostBeginPlay();
}

defaultproperties
{
     ImpSkins(0)=Texture'DoomMonsterPackv3.Imp.Imp_Skin_Purple'
     ImpSkins(1)=Texture'DoomMonsterPackv3.Imp.Imp_Skin_Red'
     ImpSkins(2)=Texture'DoomMonsterPackv3.Imp.Imp_Skin'
     ImpSkins(3)=Texture'DoomMonsterPackv3.Imp.Imp_Skin_Blue'
     ImpSkins(4)=Texture'DoomMonsterPackv3.Imp.Imp_Skin_Dark'
     ImpSkins(5)=Texture'DoomMonsterPackv3.Imp.Imp_Skin_Green'
     ImpFadeClass(0)=Class'DoomMonsterPackv3.Imp_Purple_MaterialSequence'
     ImpFadeClass(1)=Class'DoomMonsterPackv3.Imp_Red_MaterialSequence'
     ImpFadeClass(2)=Class'DoomMonsterPackv3.Imp_MaterialSequence'
     ImpFadeClass(3)=Class'DoomMonsterPackv3.Imp_Blue_MaterialSequence'
     ImpFadeClass(4)=Class'DoomMonsterPackv3.Imp_Dark_MaterialSequence'
     ImpFadeClass(5)=Class'DoomMonsterPackv3.Imp_Green_MaterialSequence'
}
