class InvasionProMapListManager extends MaplistManager;

protected function GenerateGroupMaplist(int GroupIndex)
{
    local int i;
	local array<CacheManager.MapRecord> Records;
	local MaplistRecord.MapItem  Item;
	local PlayerController PC;
	local UT2K4GamePageBase Menu;

	if ( !ValidGameIndex(GroupIndex) )
		return;

	i = GetCacheGameIndex(Groups[GroupIndex].GameType);
	if ( i == -1 )
		return;

	if ( !(CachedGames[i].ClassName ~= "InvasionProv1_7.InvasionPro") )
	{
		Super.GenerateGroupMaplist(GroupIndex);
		return;
	}

	class'CacheManager'.static.GetMapList(Records, "");
	for ( i = 0; i < Records.Length; i++ )
	{
		if ( Records[i].Acronym ~= "MOV"
		     || Records[i].Acronym ~= "TUT"
		     || Records[i].MapName ~= "Entry"
			 || Records[i].Acronym ~= "ONS"
			 || Records[i].Acronym ~= "AS"
			 || Records[i].Acronym ~= "DM"
			 || Records[i].Acronym ~= "BR"
			 || Records[i].Acronym ~= "CTF"
			 || Records[i].Acronym ~= "DOM" 
			 || Records[i].Acronym ~= "VCTF"
		     || InStr(Records[i].MapName, "AutoSave") != -1)
		{
			Records.Remove(i, 1);
			i--;
			continue;
		}

		class'MaplistRecord'.static.CreateMapItem(Records[i].MapName, Item);
		Groups[GroupIndex].AllMaps[Groups[GroupIndex].AllMaps.Length] = Item;
	}

	PC = Level.GetLocalPlayerController();
	if (PC != None && PC.Player != None && GUIController(PC.Player.GUIController) != None)
	{
		Menu = UT2K4GamePageBase(GUIController(PC.Player.GUIController).TopPage());
		if (Menu != None && Menu.p_Main != None)
			Menu.p_Main.CacheMaps = Records;
    }
}

function bool GetAvailableMaps(int GameIndex, out array<MapListRecord.MapItem> Ar)
{
	if (Super.GetAvailableMaps(GameIndex, Ar))
	{
		if (Level.GetLocalPlayerController() != None)
		{
			GenerateGroupMaplist(GameIndex);
		}
		return true;
	}

	return false;
}

defaultproperties
{
}
