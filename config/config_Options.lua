local L = LibStub("AceLocale-3.0"):GetLocale("SmexyMats");
local SmexyMats = SmexyMats;

SmexyMats.options = {
	name = "SmexyMats Options",
	type = 'group',
	args = {	
		Enabled = {
			type = "toggle",
			name = "Enable SmexyMats",
			desc = "Enables/Disables SmexyMats.",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.Enabled; end,
			set = function(info, v) SmexyMatsDB.profile.Enabled = v; end,
			order = 1
		},
		SMMsg = {
			type = "toggle",
			name = "Show SM chat messages.",
			desc = "Show SM chat messages.",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.SMMsg; end,
			set = function(info, v) SmexyMatsDB.profile.SMMsg = v; end,
			order = 2
		},
		SMText = {
			type = "toggle",
			name = "Show [SM] Text",
			desc = "Shows [SM] text in the tooltip.",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.SMText; end,
			set = function(info, v) SmexyMatsDB.profile.SMText = v; end,
			order = 3
		},
		Contents = {
			type = "toggle",
			name = "Enable Expansion Notation",
			desc = "Displays which expansion item is from in the tooltip",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.Contents; end,
			set = function(info, v) SmexyMatsDB.profile.Contents = v; end,
			order = 4
		},
		Sources = {
			type = "toggle",
			name = "Enable Source(s) Notation",
			desc = "Displays the crafting reagent source(s) in the tooltip",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.Sources; end,
			set = function(info, v) SmexyMatsDB.profile.Sources = v; end,
			order = 5
		},
		Professions = {
			type = "toggle",
			name = "Enable Profession(s) Notation",
			desc = "Displays professions for which the crafting reagent can be used in the tooltip",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.Professions; end,
			set = function(info, v) SmexyMatsDB.profile.Professions = v; end,
			order = 6
		},
		ItemIDs = {
			type = "toggle",
			name = "Enable Item IDs",
			desc = "Displays Item ID in the tooltip.",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.ItemIDs; end,
			set = function(info, v) SmexyMatsDB.profile.ItemIDs = v; end,
			order = 7
		},
		ExpackIDs = {
			type = "toggle",
			name = "Enable Expack IDs",
			desc = "Displays Expack ID in the tooltip.",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.ExpackIDs; end,
			set = function(info, v) SmexyMatsDB.profile.ExpackIDs = v; end,
			order = 7
		},
		ErrorReporting = {
			type = "toggle",
			name = "Report errors to chat window",
			desc = "Report errors to chat window",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.ErrorReporting; end,
			set = function(info, v) SmexyMatsDB.profile.ErrorReporting = v; end,
			order = 8
		},
		AllRealms = {
			type = "toggle",
			name = "Shows characters on all realms that can use the item.",
			desc = "Shows characters on all realms that can use the item.",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.AllRealms; end,
			set = function(info, v) SmexyMatsDB.profile.AllRealms = v; end,
			order = 9,
		},
		ClearDB = {
			type = "execute",
			name = "Clear Alt Database (Reloads UI after)",
			desc = "Clears the Alt Database for the Alt-modifier (holding Alt while mousing over items). Use this if your Alt-modifier is showing inaccurate information.",
			width = "double",
			func = function()
				SmexyMatsDB["ProTree"] = nil;
				SmexyMatsDB["ProTree"] = {};
				ReloadUI();
			end,
			order = 10,
		},
		ResetSmexyMats = {
			type = "execute",
			name = "Reset SmexyMats (Reloads UI after)",
			desc = "Recommended after SmexyMats updates to correct missing profile settings. This will reset your alt database (unfortunately).",
			width = "double",
			func = function()
				SmexyMatsDB = nil;
				SmexyMatsDB = {};
				SmexyMatsDB.profile = SmexyMats.defaults.profile;
				ReloadUI();
			end,
			order = 11,
		},
		Section3 = {
			type = "header",
			name = "Colorblind Options",
			order = 12,
		},
		IsColorBlind = {
			type = "toggle",
			name = "Colorblind mode",
			get = function(info) return SmexyMatsDB.profile.IsColorBlind; end,
			set = function(info, v) SmexyMatsDB.profile.IsColorBlind = v; end,
			order = 13,
		},
		ColorBlindPickedOne = {
			type = "color",
			name = "Pick the color #1 you want SmexyMats text to use.",
			set = function(info, r, g, b, a)
					if (r == nil) or (g == nil) or (b == nil) or (a == nil) then return; end;
					SmexyMatsDB.profile.cbOneR = r;
					SmexyMatsDB.profile.cbOneG = g;
					SmexyMatsDB.profile.cbOneB = b;
					SmexyMatsDB.profile.cbOneA = a;
					local rr = tostring(string.format("%x", r * 255));
					if (rr == "100") then rr = "FF" end;
					if (string.len(rr) < 2) then rr = "0"..rr end
					local gg = tostring(string.format("%x", g * 255));
					if (gg == "100") then gg = "FF" end;
					if (string.len(gg) < 2) then gg = "0"..gg end					
					local bb = tostring(string.format("%x", b * 255));
					if (bb == "100") then bb = "FF" end;
					if (string.len(bb) < 2) then bb = "0"..bb end
					local aa = tostring(string.format("%x", a * 255));
					local v = rr..gg..bb;
					SmexyMatsDB.profile.ColorBlindPickedOne = v; 
				end,
			get = function(info) 
					return SmexyMatsDB.profile.cbOneR, SmexyMatsDB.profile.cbOneG, SmexyMatsDB.profile.cbOneB;
				end,
			order = 14,	
		},
		ColorBlindPickedTwo = {
			type = "color",
			name = "Pick the color #2 you want SmexyMats text to use.",
			set = function(info, r, g, b, a)
					if (r == nil) or (g == nil) or (b == nil) or (a == nil) then return; end;
					SmexyMatsDB.profile.cbTwoR = r;
					SmexyMatsDB.profile.cbTwoG = g;
					SmexyMatsDB.profile.cbTwoB = b;
					SmexyMatsDB.profile.cbTwoA = a;
					local rr = tostring(string.format("%x", r * 255));
					if (rr == "100") then rr = "FF" end;
					if (string.len(rr) < 2) then rr = "0"..rr end
					local gg = tostring(string.format("%x", g * 255));
					if (gg == "100") then gg = "FF" end;
					if (string.len(gg) < 2) then gg = "0"..gg end					
					local bb = tostring(string.format("%x", b * 255));
					if (bb == "100") then bb = "FF" end;
					if (string.len(bb) < 2) then bb = "0"..bb end
					local aa = tostring(string.format("%x", a * 255));
					local v = rr..gg..bb;
					SmexyMatsDB.profile.ColorBlindPickedTwo = v; 
				end,
			get = function(info) 
					return SmexyMatsDB.profile.cbTwoR, SmexyMatsDB.profile.cbTwoG, SmexyMatsDB.profile.cbTwoB;
				end,
			order = 15,	
		},
		IconSection = {
			type = "header",
			name = "Icon Option",
			order = 16,
		},
		IconsEnabled = {
			type = "toggle",
			name = "Enable Profession Icons",
			desc = "Replaced SmexyMats Text with Icons",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.IconsEnabled; end,
			set = function(info, v) SmexyMatsDB.profile.IconsEnabled = v; end,
			order = 17,
		},
		ExpackIconsEnabled = {
			type = "toggle",
			name = "Enable Expack Icons",
			desc = "Replaced SmexyMats Text with Icons",
			width = "full",
			get = function(info) return SmexyMatsDB.profile.ExpackIconsEnabled; end,
			set = function(info, v) SmexyMatsDB.profile.ExpackIconsEnabled = v; end,
			order = 18,
		},
		IconDescription = {
			type = "description",
			name = "Set Icon Size (Recommended: 20)",
			fontSize = "medium",
			order = 19,
		},
		IconScaleDown = {
			type = "execute",
			width = "half",
			name = "<<",
			desc = "Changes the UI scale of the icons by -1",
			func = function(info) 
				if (SmexyMatsDB.profile.TooltipIconSize == nil) then
					SmexyMatsDB.profile.TooltipIconSize = 25;
				end;
				SmexyMatsDB.profile.TooltipIconSize = (tonumber(SmexyMatsDB.profile.TooltipIconSize) - 1)
			end,
			order = 20,
		},
		IconScaleUp = {
			type = "execute",
			width = "half",
			name = ">>",
			desc = "Changes the UI scale of the icons by +1",
			func = function(info) 
				if (SmexyMatsDB.profile.TooltipIconSize == nil) then
					SmexyMatsDB.profile.TooltipIconSize = 25;
				end;
				SmexyMatsDB.profile.TooltipIconSize = (tonumber(SmexyMatsDB.profile.TooltipIconSize) + 1)
			end,
			order = 20,
		},
		CurrentUI = {
			type = "description",
			name = function(info) 
				if (SmexyMatsDB.profile.TooltipIconSize == nil) then 
					return "Not Set"
				else 
					return "       " .. tostring(tonumber(SmexyMatsDB.profile.TooltipIconSize))
				end
			end,
			width = "full",
			fontSize = "large",
			order = 21,
		},
		ExpackDescription = {
			type = "description",
			name = "Set Expack Size (Recommended: 50)",
			fontSize = "medium",
			order = 22,
		},
		ExpackScaleDown = {
			type = "execute",
			width = "half",
			name = "<<",
			desc = "Changes the UI scale of the expack icon by -1",
			func = function(info) 
				if (SmexyMatsDB.profile.TooltipExpackSize == nil) then
					SmexyMatsDB.profile.TooltipExpackSize = 64;
				end;
				SmexyMatsDB.profile.TooltipExpackSize = (tonumber(SmexyMatsDB.profile.TooltipExpackSize) - 1)
			end,
			order = 23,
		},
		ExpackScaleUp = {
			type = "execute",
			width = "half",
			name = ">>",
			desc = "Changes the UI scale of the expack icons by +1",
			func = function(info) 
				if (SmexyMatsDB.profile.TooltipExpackSize == nil) then
					SmexyMatsDB.profile.TooltipExpackSize = 64;
				end;
				SmexyMatsDB.profile.TooltipExpackSize = (tonumber(SmexyMatsDB.profile.TooltipExpackSize) + 1)
			end,
			order = 23,
		},
		CurrentExpackUI = {
			type = "description",
			name = function(info) 
				if (SmexyMatsDB.profile.TooltipExpackSize == nil) then 
					return "Not Set"
				else 
					return "       " .. tostring(tonumber(SmexyMatsDB.profile.TooltipExpackSize))
				end
			end,
			width = "full",
			fontSize = "large",
			order = 24,
		},
		VisualSection = {
			type = "header",
			name = "Visual",
			order = 25,
		},
		IconRecommend = {
			type = "description",
			name =  SmexyMats.Profs[-3].icon() .." " .. SmexyMats.Profs[-3].name .. "\r\n" ..
					SmexyMats.Profs[-2].icon() .." " .. SmexyMats.Profs[-2].name .. "\r\n" ..
					SmexyMats.Profs[-1].icon() .." " .. SmexyMats.Profs[-1].name .. "\r\n" ..
					SmexyMats.Profs[1].icon() .." " .. SmexyMats.Profs[1].name .. "\r\n" ..
					SmexyMats.Profs[2].icon() .." " .. SmexyMats.Profs[2].name .. "\r\n" ..
					SmexyMats.Profs[3].icon() .." " .. SmexyMats.Profs[3].name .. "\r\n" ..
					SmexyMats.Profs[4].icon() .." " .. SmexyMats.Profs[4].name .. "\r\n" ..
					SmexyMats.Profs[5].icon() .." " .. SmexyMats.Profs[5].name .. "\r\n" ..
					SmexyMats.Profs[6].icon() .." " .. SmexyMats.Profs[6].name .. "\r\n" ..
					SmexyMats.Profs[7].icon() .." " .. SmexyMats.Profs[7].name .. "\r\n" ..
					SmexyMats.Profs[8].icon() .." " .. SmexyMats.Profs[8].name .. "\r\n" ..
					SmexyMats.Profs[9].icon() .." " .. SmexyMats.Profs[9].name .. "\r\n" ..
					SmexyMats.Profs[10].icon() .." " .. SmexyMats.Profs[10].name .. "\r\n" ..
					SmexyMats.Profs[11].icon() .." " .. SmexyMats.Profs[11].name .. "\r\n" ..
					SmexyMats.Profs[12].icon() .." " .. SmexyMats.Profs[12].name .. "\r\n" ..
					SmexyMats.Profs[13].icon() .." " .. SmexyMats.Profs[13].name .. "\r\n" ..
					SmexyMats.Profs[14].icon() .." " .. SmexyMats.Profs[14].name .. "\r\n\r\n" ..
					SmexyMats.ExPacks[0].geticon() ..
					SmexyMats.ExPacks[1].geticon() ..
					SmexyMats.ExPacks[2].geticon() .. 
					SmexyMats.ExPacks[3].geticon() .. 
					SmexyMats.ExPacks[4].geticon() .. "\r\n" ..
					SmexyMats.ExPacks[5].geticon() .. 
					SmexyMats.ExPacks[6].geticon() .. 
					SmexyMats.ExPacks[7].geticon() .. 
					SmexyMats.ExPacks[8].geticon() .. 
					SmexyMats.ExPacks[9].geticon(),
					
			width = "full",
			fontSize = "large",
			order = 26,
		},
		Section5 = {
			type = "header",
			name = "Synopsis",
			order = 27,
		},
		Synopsis = {
			type = "description",
			name = "Tooltip notation addon.\r\n\r\n" .. 
					"Mouse over an item in your inventory, auction house, dungeon journal or click on a linked item.\r\n" .. 
					"Hold Alt while mousing over an item to see which Alt can use it.\r\n" ..
					"Alt information is cached whenever you open the profession window.\r\n" ..
					"\r\n" ..
					"Crafting Reagents:\r\n" ..
					"    Show source types.(Drop, Vendor, etc)\r\n" ..
					"    Show professions that can use the reagent.\r\n" .. 
					"    Show what Expansion its from.\r\n" .. 
					"\r\n" ..
					"Equipment:\r\n" .. 
					"    Show what Expansion its from.\r\n" .. 
					"\r\n" ..
					"ItemID:\r\n" .. 
					"    Show the item ID for that item.\r\n" .. 
					"\r\n" ..
					"All item information is gathered from Wowhead. Please consider using the Wowhead client\r\n" ..
					"to help data mine for addons like this one.\r\n" ..
					"https://www.wowhead.com/client\r\n" ..
					"\r\n"..
					"Thank you all for your feedback and suggestions!",
			fontSize = "medium",
			order = 28,
		},
		Section4 = {
			type = "header",
			name = "Commands",
			order = 29,
		},
		CMDs = {
			type = "description",
			name = "/sm : Brings up this window.",
			fontSize = "medium",
			order = 30,
		},
		Section4 = {
			type = "header",
			name = "Author",
			order = 31,
		},
		About = {
			type = "description",
			name = SmexyMats.Colors.wowtoken .. "BattleTag & Discord: LunixiaLIVE#1737\r\n" ..
					"|cFFCC66FFTwitch: https://www.twitch.tv/LunixiaLIVE\r\n" ..
					"|rCheck out my other addons:\r\n" ..
					"|cFFFF8000SmexyMats(Classic)\r\n" ..
					"|cFFFF8000SmexyScaleUI(SSUI)\r\n" ..  
					"|cFFFF8000SmexyGMO(SGMO)\r\n\r\n" ..
					"CREDITS: I do not own any of the images for the icons. " ..
					"I got the expansion/profession icons from in-game resources.",
			fontSize = "medium",
			order = 32,
		},
	},
};