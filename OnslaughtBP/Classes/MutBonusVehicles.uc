//-----------------------------------------------------------
//
//-----------------------------------------------------------
class MutBonusVehicles extends Mutator;

var array<string> ArcticStrongholdFactories;
var array<string> AridoomFactories;
var array<string> AscendancyFactories;
var array<string> CrossfireFactories;
var array<string> DawnFactories;
var array<string> DriaFactories;
var array<string> FrostbiteFactories;
var array<string> PrimevalFactories;
var array<string> RedPlanetFactories;
var array<string> SeveranceFactories;
var array<string> TorlanFactories;

var array< class<ONSVehicle> > ArcticStrongholdReplacements;
var array< class<ONSVehicle> > AridoomReplacements;
var array< class<ONSVehicle> > AscendancyReplacements;
var array< class<ONSVehicle> > CrossfireReplacements;
var array< class<ONSVehicle> > DawnReplacements;
var array< class<ONSVehicle> > DriaReplacements;
var array< class<ONSVehicle> > FrostbiteReplacements;
var array< class<ONSVehicle> > PrimevalReplacements;
var array< class<ONSVehicle> > RedPlanetReplacements;
var array< class<ONSVehicle> > SeveranceReplacements;
var array< class<ONSVehicle> > TorlanReplacements;

function PostBeginPlay()
{
	local ONSVehicleFactory Factory;
	local array<string> MapFactories;
	local array< class<ONSVehicle> > MapReplacements;
	local string MapName, Garbage;
	local int i;

    Divide(Level.GetLocalURL(), "?", MapName, Garbage);
    Divide(MapName, "/", Garbage, MapName);

    log("GetLocalURL: "$Level.GetLocalURL());
    log("MapName: "$MapName);

	switch(MapName)
	{
        case "ONS-ArcticStronghold":    MapFactories = ArcticStrongholdFactories;
                                        MapReplacements = ArcticStrongholdReplacements;
                                        break;

        case "ONS-Aridoom":             MapFactories = AridoomFactories;
                                        MapReplacements = AridoomReplacements;
                                        break;

        case "ONS-Ascendancy":          MapFactories = AscendancyFactories;
                                        MapReplacements = AscendancyReplacements;
                                        break;

        case "ONS-Crossfire":           MapFactories = CrossfireFactories;
                                        MapReplacements = CrossfireReplacements;
                                        break;

        case "ONS-Dawn":                MapFactories = DawnFactories;
                                        MapReplacements = DawnReplacements;
                                        break;

        case "ONS-Dria":                MapFactories = DriaFactories;
                                        MapReplacements = DriaReplacements;
                                        break;

        case "ONS-Frostbite":           MapFactories = FrostbiteFactories;
                                        MapReplacements = FrostbiteReplacements;
                                        break;

        case "ONS-Primeval":            MapFactories = PrimevalFactories;
                                        MapReplacements = PrimevalReplacements;
                                        break;

        case "ONS-RedPlanet":           MapFactories = RedPlanetFactories;
                                        MapReplacements = RedPlanetReplacements;
                                        break;

        case "ONS-Severance":           MapFactories = SeveranceFactories;
                                        MapReplacements = SeveranceReplacements;
                                        break;

        case "ONS-Torlan":              MapFactories = TorlanFactories;
                                        MapReplacements = TorlanReplacements;
                                        break;
    }

	foreach AllActors( class 'ONSVehicleFactory', Factory )
	{
        for (i=0; i<MapFactories.Length; i++)
        {
            if (String(Factory.Name) == MapFactories[i])
                Factory.VehicleClass = MapReplacements[i];
        }
	}

	Super.PostBeginPlay();
}

defaultproperties
{
     ArcticStrongholdFactories(0)="ONSTankFactory2"
     ArcticStrongholdFactories(1)="ONSTankFactory1"
     ArcticStrongholdFactories(2)="ONSRVFactory5"
     ArcticStrongholdFactories(3)="ONSRVFactory6"
     ArcticStrongholdFactories(4)="ONSAttackCraftFactory0"
     AridoomFactories(0)="ONSTankFactory0"
     AridoomFactories(1)="ONSTankFactory1"
     AridoomFactories(2)="ONSTankFactory2"
     AscendancyFactories(0)="ONSTankFactory6"
     AscendancyFactories(1)="ONSPRVFactory0"
     AscendancyFactories(2)="ONSRVFactory5"
     AscendancyFactories(3)="ONSTankFactory0"
     AscendancyFactories(4)="ONSPRVFactory1"
     AscendancyFactories(5)="ONSRVFactory11"
     CrossfireFactories(0)="ONSHoverCraftFactory8"
     CrossfireFactories(1)="ONSPRVFactory7"
     CrossfireFactories(2)="ONSHoverCraftFactory9"
     CrossfireFactories(3)="ONSPRVFactory10"
     CrossfireFactories(4)="ONSRVFactory12"
     CrossfireFactories(5)="ONSPRVFactory1"
     CrossfireFactories(6)="ONSPRVFactory6"
     DawnFactories(0)="ONSAttackCraftFactory1"
     DawnFactories(1)="ONSAttackCraftFactory0"
     DawnFactories(2)="ONSTankFactory3"
     DawnFactories(3)="ONSTankFactory4"
     DawnFactories(4)="ONSRVFactory1"
     DawnFactories(5)="ONSRVFactory0"
     DawnFactories(6)="ONSHoverCraftFactory3"
     DriaFactories(0)="ONSPRVFactory3"
     DriaFactories(1)="ONSPRVFactory5"
     DriaFactories(2)="ONSAttackCraftFactory10"
     DriaFactories(3)="ONSAttackCraftFactory14"
     DriaFactories(4)="ONSTankFactory1"
     DriaFactories(5)="ONSTankFactory3"
     FrostbiteFactories(0)="ONSRVFactory3"
     FrostbiteFactories(1)="ONSRVFactory5"
     FrostbiteFactories(2)="ONSHoverCraftFactory3"
     PrimevalFactories(0)="ONSTankFactory0"
     RedPlanetFactories(0)="ONSAttackCraftFactory5"
     RedPlanetFactories(1)="ONSAttackCraftFactory0"
     RedPlanetFactories(2)="ONSRVFactory1"
     RedPlanetFactories(3)="ONSRVFactory5"
     RedPlanetFactories(4)="ONSHoverCraftFactory10"
     SeveranceFactories(0)="ONSPRVFactory3"
     SeveranceFactories(1)="ONSPRVFactory9"
     SeveranceFactories(2)="ONSAttackCraftFactory0"
     SeveranceFactories(3)="ONSAttackCraftFactory1"
     SeveranceFactories(4)="ONSRVFactory21"
     SeveranceFactories(5)="ONSRVFactory3"
     TorlanFactories(0)="ONSAttackCraftFactory1"
     TorlanFactories(1)="ONSAttackCraftFactory2"
     TorlanFactories(2)="ONSRVFactory0"
     TorlanFactories(3)="ONSRVFactory1"
     TorlanFactories(4)="ONSPRVFactory2"
     ArcticStrongholdReplacements(0)=Class'OnslaughtBP.ONSShockTank'
     ArcticStrongholdReplacements(1)=Class'OnslaughtBP.ONSShockTank'
     ArcticStrongholdReplacements(2)=Class'OnslaughtBP.ONSArtillery'
     ArcticStrongholdReplacements(3)=Class'OnslaughtBP.ONSArtillery'
     ArcticStrongholdReplacements(4)=Class'OnslaughtBP.ONSDualAttackCraft'
     AridoomReplacements(0)=Class'OnslaughtBP.ONSShockTank'
     AridoomReplacements(1)=Class'OnslaughtBP.ONSShockTank'
     AridoomReplacements(2)=Class'OnslaughtBP.ONSArtillery'
     AscendancyReplacements(0)=Class'OnslaughtBP.ONSShockTank'
     AscendancyReplacements(1)=Class'OnslaughtBP.ONSArtillery'
     AscendancyReplacements(2)=Class'OnslaughtBP.ONSDualAttackCraft'
     AscendancyReplacements(3)=Class'OnslaughtBP.ONSShockTank'
     AscendancyReplacements(4)=Class'OnslaughtBP.ONSArtillery'
     AscendancyReplacements(5)=Class'OnslaughtBP.ONSDualAttackCraft'
     CrossfireReplacements(0)=Class'OnslaughtBP.ONSDualAttackCraft'
     CrossfireReplacements(1)=Class'OnslaughtBP.ONSShockTank'
     CrossfireReplacements(2)=Class'OnslaughtBP.ONSDualAttackCraft'
     CrossfireReplacements(3)=Class'OnslaughtBP.ONSShockTank'
     CrossfireReplacements(4)=Class'Onslaught.ONSHoverTank'
     CrossfireReplacements(5)=Class'OnslaughtBP.ONSArtillery'
     CrossfireReplacements(6)=Class'OnslaughtBP.ONSArtillery'
     DawnReplacements(0)=Class'OnslaughtBP.ONSDualAttackCraft'
     DawnReplacements(1)=Class'OnslaughtBP.ONSDualAttackCraft'
     DawnReplacements(2)=Class'OnslaughtBP.ONSArtillery'
     DawnReplacements(3)=Class'OnslaughtBP.ONSArtillery'
     DawnReplacements(4)=Class'Onslaught.ONSHoverBike'
     DawnReplacements(5)=Class'OnslaughtBP.ONSShockTank'
     DawnReplacements(6)=Class'OnslaughtBP.ONSShockTank'
     DriaReplacements(0)=Class'OnslaughtBP.ONSShockTank'
     DriaReplacements(1)=Class'OnslaughtBP.ONSShockTank'
     DriaReplacements(2)=Class'OnslaughtBP.ONSDualAttackCraft'
     DriaReplacements(3)=Class'OnslaughtBP.ONSDualAttackCraft'
     DriaReplacements(4)=Class'OnslaughtBP.ONSArtillery'
     DriaReplacements(5)=Class'OnslaughtBP.ONSArtillery'
     FrostbiteReplacements(0)=Class'OnslaughtBP.ONSShockTank'
     FrostbiteReplacements(1)=Class'OnslaughtBP.ONSShockTank'
     FrostbiteReplacements(2)=Class'OnslaughtBP.ONSDualAttackCraft'
     PrimevalReplacements(0)=Class'OnslaughtBP.ONSShockTank'
     RedPlanetReplacements(0)=Class'OnslaughtBP.ONSDualAttackCraft'
     RedPlanetReplacements(1)=Class'OnslaughtBP.ONSDualAttackCraft'
     RedPlanetReplacements(2)=Class'OnslaughtBP.ONSShockTank'
     RedPlanetReplacements(3)=Class'OnslaughtBP.ONSShockTank'
     RedPlanetReplacements(4)=Class'OnslaughtBP.ONSArtillery'
     SeveranceReplacements(0)=Class'OnslaughtBP.ONSArtillery'
     SeveranceReplacements(1)=Class'OnslaughtBP.ONSArtillery'
     SeveranceReplacements(2)=Class'OnslaughtBP.ONSDualAttackCraft'
     SeveranceReplacements(3)=Class'OnslaughtBP.ONSDualAttackCraft'
     SeveranceReplacements(4)=Class'OnslaughtBP.ONSShockTank'
     SeveranceReplacements(5)=Class'OnslaughtBP.ONSShockTank'
     TorlanReplacements(0)=Class'OnslaughtBP.ONSDualAttackCraft'
     TorlanReplacements(1)=Class'OnslaughtBP.ONSDualAttackCraft'
     TorlanReplacements(2)=Class'OnslaughtBP.ONSShockTank'
     TorlanReplacements(3)=Class'OnslaughtBP.ONSShockTank'
     TorlanReplacements(4)=Class'OnslaughtBP.ONSArtillery'
     bAddToServerPackages=True
}