local L = LibStub("AceLocale-3.0"):GetLocale("SmexyMats");
local SmexyMats = SmexyMats;

function SmexyMats:trim(s)
	return SmexyMats:rtrim(SmexyMats:ltrim(s));
end;

function SmexyMats:ltrim(s)
	return (s:gsub("^%s*", ""));
end;

function SmexyMats:rtrim(s)
	local n = #s;
	while n > 0 and s:find("^%s", n) do 	
		n = n - 1;
	end;
	return s:sub(1, n);
end;

function SmexyMats:IsInTable(tbl, val)
    for a, b in pairs(tbl) do
        if(tonumber(a) == tonumber(val)) then
			return true;
		end;
    end;
    return false;
end;

function SmexyMats:Gear_ExpackID(obj)
	if (obj.ff == "Armor") or (obj.ff == "Weapon") or (obj.gg == "Artifact Relic") then 
		return true, tonumber(obj.oo), SmexyMats.ExPacks[obj.oo].color;
	end;
	if (obj.ff == L["Armor"]) or (obj.ff == L["Weapon"]) or (obj.gg == L["Artifact Relic"]) then 
		return true, tonumber(obj.oo), SmexyMats.ExPacks[obj.oo].color;
	end;
	--[[
	if obj.oo then
		return true, tonumber(obj.oo), SmexyMats.ExPacks[obj.oo].color;
	else
		return false, -1, SmexyMats.ExPacks[-1].color;
	end;
	]]--
end;

SmexyMats.Colors = {
	CLASSIC		 = "|cFFE6CC80",
	TBC			 = "|cFF1EFF00",
	WOTLK		 = "|cFF66ccff",
	CATA		 = "|cFFff3300",
	MOP			 = "|cFF00FF96",
	WOD			 = "|cFFff8C1A",
	LEGION		 = "|cFFA335EE",
	BFA 		 = "|cFFFF7D0A",
	SHADOWLANDS  = "|cFFE6CC80",
	DRAGONFLIGHT = "|cFF33937F",
	TWW 		 = "|cFFff3300",
	
	yellow 		 = "|cFFFFFF00",
	white 		 = "|cFFFFFFFF",

	common 		 = "|cFFFFFFFF",
	uncommon 	 = "|cFF1EFF00",
	rare 		 = "|cFF0070DD",
	epic 		 = "|cFFA335EE",
	legendary 	 = "|cFFFF8000",
	artifact 	 = "|cFFE6CC80",
	wowtoken	 = "|cFF00CCFF",

	DeathKnight  = "|cFFC41F3B",
	DemonHunter  = "|cFFA330C9",
	Druid 		 = "|cFFFF7D0A",
	Evoker       = "|cFF33937F",
	Hunter 		 = "|cFFABD473",
	Mage 		 = "|cFF69CCF0",
	Monk 		 = "|cFF00FF96",
	Paladin 	 = "|cFFF58CBA",
	Priest 		 = "|cFFFFFFFF",
	Rogue 		 = "|cFFFFF569",
	Shaman 		 = "|cFF0070DE",
	Warlock 	 = "|cFF9482C9",
	Warrior 	 = "|cFFC79C6E",
};

SmexyMats.ExPacks = {
	[-1] = {
		name = L["Unknown"],
		color = SmexyMats.Colors.white,
		icon = "Interface\\Addons\\SmexyMats\\icon\\Classic-Logo-Small.blp",
		geticon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[-1].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[0]  = {
		name = L["Classic"],
		color = SmexyMats.Colors.CLASSIC,
		icon = "Interface\\Addons\\SmexyMats\\icon\\Classic-Logo-Small.blp",
		geticon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[0].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[1]  = {
		name = L["The Burning Crusade"],
		color = SmexyMats.Colors.TBC,
		icon = "Interface\\Addons\\SmexyMats\\icon\\TBC-Logo-Small.blp",
		geticon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[1].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[2]  = {
		name = L["Wrath of the Lich King"],
		color = SmexyMats.Colors.WOTLK,
		icon = "Interface\\Addons\\SmexyMats\\icon\\Wrath-Logo-Small.blp",
		geticon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[2].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[3]  = {
		name = L["Cataclysm"],
		color = SmexyMats.Colors.CATA,
		icon = "Interface\\Addons\\SmexyMats\\icon\\Cata-Logo-Small.blp",
		geticon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[3].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[4]  = {
		name = L["Mists of Pandaria"],
		color = SmexyMats.Colors.MOP,
		icon = "Interface\\Addons\\SmexyMats\\icon\\Mists-Logo-Small.blp",
		geticon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[4].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[5]  = {
		name = L["Warlords of Draenor"],
		color = SmexyMats.Colors.WOD,
		icon = "Interface\\Addons\\SmexyMats\\icon\\WoD-Logo-Small.blp",
		geticon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[5].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[6]  = {
		name = L["Legion"],
		color = SmexyMats.Colors.LEGION,
		icon = "Interface\\Addons\\SmexyMats\\icon\\Legion-Logo-Small.blp",
		geticon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[6].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[7]  = {
		name = L["Battle for Azeroth"],
		color = SmexyMats.Colors.BFA,
		icon = "Interface\\Addons\\SmexyMats\\icon\\BFA-Logo-Small.blp",
		geticon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[7].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[8]  = {
		name = L["Shadowlands"],
		color = SmexyMats.Colors.SHADOWLANDS,
		icon = "Interface\\Addons\\SmexyMats\\icon\\SL-Logo-Small.blp",
		geticon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[8].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[9]  = {
		name = L["DragonFlight"],
		color = SmexyMats.Colors.DRAGONFLIGHT,
		icon = "Interface\\Addons\\SmexyMats\\icon\\DF-Logo-Small.blp",
		geticon = function() 
			local t = {} 
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[9].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
	[10]  = {
		name = "TWW", --L["TWW"],
		color = SmexyMats.Colors.TWW,
		icon = "Interface\\Addons\\SmexyMats\\icon\\DF-Logo-Small.blp",
		geticon = function() 
			local t = {} 
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.ExPacks[10].icon; t[ #t+1 ] = ":"; t[ #t+1 ] = 64; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
		},
};

SmexyMats.Profs = {
	[-3] = {
		name = L["Scrap"],
		spelltexture = "Interface\\ICONS\\INV_Misc_PunchCards_Blue",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[-3].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[-2] = {
		name = L["Drop"],
		spelltexture = "Interface\\ICONS\\INV_Box_01",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[-2].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[-1] = {
		name = L["Vendor"],
		spelltexture = "Interface\\ICONS\\inv_misc_coin_01",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[-1].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[1]	= {
		name = L["Alchemy"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Alchemy.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[1].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[2] = {
		name = L["Archaeology"],
		spelltexture = "Interface\\ICONS\\TRADE_ARCHAEOLOGY",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[2].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[3] = {
		name = L["Blacksmithing"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Blacksmithing.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[3].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[4] = {
		name = L["Cooking"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Cooking.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[4].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[5] = {
		name = L["Enchanting"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Enchanting.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[5].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[6] = {
		name = L["Engineering"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Engineering.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[6].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[7] = {
		name = L["Fishing"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Fishing.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[7].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[8] = {
		name = L["Herbalism"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Herbalism.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[8].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[9] = {
		name = L["Inscription"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Inscription.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[9].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[10] = {
		name = L["Jewelcrafting"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Jewelcrafting.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[10].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[11] = {
		name = L["Leatherworking"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Leatherworking.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[11].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[12] = {
		name = L["Mining"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Mining.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[12].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[13] = {
		name = L["Skinning"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Skinning.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[13].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
	[14] = {
		name = L["Tailoring"],
		spelltexture = "Interface\\ICONS\\UI_Profession_Tailoring.blp",
		icon = function() 
			local t = {}
			t[ #t+1 ] = "|T"; t[ #t+1 ] = SmexyMats.Profs[14].spelltexture; t[ #t+1 ] = ":"; t[ #t+1 ] = 25; t[ #t+1 ] = "|t "; return table.concat(t);
		end,
	},
};