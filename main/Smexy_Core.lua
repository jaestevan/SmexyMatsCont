--[[
	Data Parsed from WowHead.com and tradeskillmaster.com
	Locales: US, ES, MX, DE, FR, RU
	]]--

--local pairs, tonumber, print, string, table, _G = pairs, tonumber, print, string, table, _G;
SmexyMats = LibStub("AceAddon-3.0"):NewAddon("SmexyMats", "AceEvent-3.0", "AceConsole-3.0");
if SmexyMatsDB == nil then SmexyMatsDB = {}; end;
local L = LibStub("AceLocale-3.0"):GetLocale("SmexyMats");
local AceConfig = LibStub("AceConfigDialog-3.0");
local name = "SmexyMats(Retail)";
local version = "v10.1.0.0";
local isTooltipDone = nil;
local storedLink = nil;
local LID = nil;
local shiftDown = nil;
local btn_TS_Cache = nil;

function SmexyMats:OnInitialize()
	SmexyMats:RegisterChatCommand("sm", "ChatCommand");
	if (SmexyMatsDB.profile == nil) or not (SmexyMatsDB.profile) then 
		SmexyMatsDB.profile = SmexyMats.defaults.profile; 
	end;
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("SmexyMats", SmexyMats.options);
	AceConfig:AddToBlizOptions("SmexyMats", "SmexyMats(Retail)");
	local tooltipMethodHooks = {
		SetCurrencyToken = { 	
			nil, 
			Hook_SetCurrencyToken,
		},
		SetRecipeResultItem = { 
			function(self, recipeID) 
				if recipeID then 
					storedLink = C_TradeSkillUI.GetRecipeItemLink(recipeID) 
				end;
			end, 
			nil,
		},
		SetRecipeReagentItem = {	
			function(self, recipeID, reagentIndex) 
				if recipeID and reagentIndex then 
					storedLink = C_TradeSkillUI.GetRecipeFixedReagentItemLink(recipeID, reagentIndex)
				end;
			end, 
			nil, 
		},
	};
	for m, hooks in pairs(tooltipMethodHooks) do
		SmexyMats:InstallHook(GameTooltip, m, hooks[1], hooks[2]);
	end;
	if (SmexyMats:CheckDB() == true) then
		SmexyMats:HookTooltips();
		if (SmexyMatsDB.profile.SMMsg == true) then
			print(SmexyMats.Colors.wowtoken .. name,SmexyMats.Colors.legendary .. version,L["|rLoad Complete!"]);
		end;
	else
		if (SmexyMatsDB.profile.SMMsg == true) then
			print(SmexyMats.Colors.wowtoken .. name,SmexyMats.Colors.legendary .. version,SmexyMats.Colors.DeathKnight .. L["Failed! |rMissing Data-Tables. Reinstall SemxyMats(SM) to correct this issue or report the error to https://mods.curse.com/addons/wow/270824-smexymats"]);
		end;
	end;
end;	

function SmexyMats:InstallHook(tooltip, method, prehook, posthook)
	local orig = tooltip[method];
	local stub = function(...)
		if prehook then prehook(...); end;
		local a,b,c,d,e,f,g,h,i,j,k = orig(...);
		if posthook then posthook(...); end;
		return a,b,c,d,e,f,g,h,i,j,k;
	end;
	tooltip[method] = stub;
end;

function SmexyMats:GetItemProperties(item)
	local retObj = {}; 
	if not item then
		return; 
	end;
	retObj.aa, retObj.bb, retObj.cc, retObj.dd, retObj.ee, retObj.ff, retObj.gg, retObj.hh, retObj.ii, retObj.jj, retObj.kk, retObj.ll, retObj.mm, retObj.nn, retObj.oo, retObj.pp = GetItemInfo(item);
	if retObj.bb then 
		retObj.ID = SmexyMats:GetIDFromLink(retObj.bb);
	end;
	return retObj;
end;

function SmexyMats:HookTooltips()
	SmexyMats:RegisterEvent("TRADE_SKILL_SHOW");
	GameTooltip:HookScript("OnShow", JustTheTip);
	GameTooltip:HookScript("OnTooltipCleared", function(self) isTooltipDone = nil; end);
	
	ItemRefTooltip:HookScript("OnShow", JustTheTip);
	ItemRefTooltip:HookScript("OnTooltipCleared", function(self) isTooltipDone = nil; end);
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, ...)
		if (tooltip == GameTooltip or tooltip == ItemRefTooltip) then
			SmexyMats.ModifyItemTooltip(tooltip, ...)
		end
	end);
end;

function SmexyMats:ChatCommand()
	InterfaceOptionsFrame_OpenToCategory("SmexyMats(Retail)");
	InterfaceOptionsFrame_OpenToCategory("SmexyMats(Retail)");
end;

function SmexyMats:TRADE_SKILL_SHOW()
	local RealmName = GetRealmName();
	local FactionName = UnitFactionGroup("player");
	local CharacterName = UnitName("player");
	local ProTree = "ProTree";	
		
	local iPrimProA, iPrimProB, iPrimProC, iPrimProD, iPrimProE = GetProfessions();
	local PrimProA, PrimProB, PrimProC, PrimProD, PrimProE = nil, nil, nil, nil, nil;
	
	if not (SmexyMatsDB[ProTree]) or not (SmexyMatsDB.ProTree) then SmexyMatsDB[ProTree] = {}; end;
	
	if (iPrimProA ~= nil) then 
		PrimProA = GetProfessionInfo(iPrimProA);
		if not (SmexyMatsDB[ProTree][PrimProA]) then SmexyMatsDB[ProTree][PrimProA] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProA][FactionName]) then SmexyMatsDB[ProTree][PrimProA][FactionName] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProA][FactionName][RealmName]) then SmexyMatsDB[ProTree][PrimProA][FactionName][RealmName] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProA][FactionName][RealmName][CharacterName]) then SmexyMatsDB[ProTree][PrimProA][FactionName][RealmName][CharacterName] = {}; end;
	end;
	if (iPrimProB ~= nil) then 
		PrimProB = GetProfessionInfo(iPrimProB);
		if not (SmexyMatsDB[ProTree][PrimProB]) then SmexyMatsDB[ProTree][PrimProB] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProB][FactionName]) then SmexyMatsDB[ProTree][PrimProB][FactionName] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProB][FactionName][RealmName]) then SmexyMatsDB[ProTree][PrimProB][FactionName][RealmName] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProB][FactionName][RealmName][CharacterName]) then SmexyMatsDB[ProTree][PrimProB][FactionName][RealmName][CharacterName] = {}; end;
	end;
	if (iPrimProC ~= nil) then 
		PrimProC = GetProfessionInfo(iPrimProC);
		if not (SmexyMatsDB[ProTree][PrimProC]) then SmexyMatsDB[ProTree][PrimProC] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProC][FactionName]) then SmexyMatsDB[ProTree][PrimProC][FactionName] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProC][FactionName][RealmName]) then SmexyMatsDB[ProTree][PrimProC][FactionName][RealmName] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProC][FactionName][RealmName][CharacterName]) then SmexyMatsDB[ProTree][PrimProC][FactionName][RealmName][CharacterName] = {}; end;
	end;
	if (iPrimProD ~= nil) then 
		PrimProD = GetProfessionInfo(iPrimProD);
		if not (SmexyMatsDB[ProTree][PrimProD]) then SmexyMatsDB[ProTree][PrimProD] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProD][FactionName]) then SmexyMatsDB[ProTree][PrimProD][FactionName] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProD][FactionName][RealmName]) then SmexyMatsDB[ProTree][PrimProD][FactionName][RealmName] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProD][FactionName][RealmName][CharacterName]) then SmexyMatsDB[ProTree][PrimProD][FactionName][RealmName][CharacterName] = {}; end;
	end;
	if (iPrimProE ~= nil) then 
		PrimProE = GetProfessionInfo(iPrimProE);
		if not (SmexyMatsDB[ProTree][PrimProE]) then SmexyMatsDB[ProTree][PrimProE] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProE][FactionName]) then SmexyMatsDB[ProTree][PrimProE][FactionName] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProE][FactionName][RealmName]) then SmexyMatsDB[ProTree][PrimProE][FactionName][RealmName] = {}; end;
		if not (SmexyMatsDB[ProTree][PrimProE][FactionName][RealmName][CharacterName]) then SmexyMatsDB[ProTree][PrimProE][FactionName][RealmName][CharacterName] = {}; end;
	end;
	
	if (SmexyMatsDB.profile.SMMsg == true) then
		print(SmexyMats.Colors.wowtoken .. "Professions for: ");
		print(SmexyMats.Colors.wowtoken .. "Character: " .. CharacterName);
		print(SmexyMats.Colors.wowtoken .. "Faction: " .. FactionName);
		print(SmexyMats.Colors.wowtoken .. "Realm: " .. RealmName);
		print(SmexyMats.Colors.wowtoken .. "Professions: " .. PrimProA .. ", " .. PrimProB .. ", " .. PrimProC .. ", " .. PrimProD .. ", " .. PrimProE);
		print(SmexyMats.Colors.wowtoken .. "Have been cached. ");
	end;	
end;

function JustTheTip(tooltip, ...)
	tooltip:Show();
end;

function SmexyMats:GetIDFromLink(link)
	if link then
		local id = link:match("item:(%d+):");
		if id then 
			return tonumber(id); 
		else 
			return 0; 
		end;
	end;
end;

function SmexyMats:CheckDB()
	if not (SmexyMats.Sources) then return false; end;
	if not (SmexyMats.Reagents) then return false; end;
	if not (SmexyMats.Drop) then return false; end;
	if not (SmexyMats.Vendor) then return false; end;
	if not (SmexyMats.Scrap) then return false; end;
	return true;
end;

function SmexyMats:GetExPack(obj)
	if (obj.aa == nil) or (obj.aa == '') or (string.len(obj.aa) < 1) then 
		return -1, SmexyMats.ExPacks[-1].color; 
	end;

	if (SmexyMatsDB.profile.Equipment == true) and (SmexyMatsDB.profile.Contents == true) then 
		local X, Y = SmexyMats:Gear_ExpackID(obj); 
		if (X ~= -1) then return X, Y; end; 
	end;
	return -1, SmexyMats.ExPacks[-1].color;
end;

function SmexyMats:ProcessTooltip(tt, obj)
	local ItemInfoCached, r, g, b = true, .9, .8, .5;
	if not obj.ID then 
		ItemInfoCached = false; 
	end;
	if (obj.ID == 0) and (TradeSkillFrame ~= nil) and TradeSkillFrame:IsVisible() then
		if (GetMouseFocus():GetName()) == "TradeSkillSkillIcon" then
			obj.ID = tonumber(GetTradeSkillItemLink(TradeSkillFrame.selectedSkill):match("item:(%d+):")) or nil
		else
			for i = 1, 8 do
				if (GetMouseFocus():GetName()) == "TradeSkillReagent"..i then
					obj.ID = tonumber(GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, i):match("item:(%d+):")) or nil; 
					break;
				end;
			end;
		end;
	end;
	if (obj.ID == 0) then 
		ItemInfoCached = false; 
	end;
	if (not ItemInfoCached) then
		if (SmexyMatsDB.profile.ErrorReporting == true) then
			if (_G["GameTooltipTextLeft1"]:GetText() ~= SmexyMats.LID) then
				print(SmexyMats.Colors.wowtoken .. L["[SM]:"] .. SmexyMats.Colors.DeathKnight .. L["Cannot fetch information for:"]);
				print(SmexyMats.Colors.wowtoken .. L["[SM]:"] .. SmexyMats.Colors.common ..  _G["GameTooltipTextLeft1"]:GetText());
				print(SmexyMats.Colors.wowtoken .. L["[SM]:"] .. SmexyMats.Colors.yellow .. L["An info request has been sent to the server for details on this item."]);
				print(SmexyMats.Colors.wowtoken .. L["[SM]:"] .. SmexyMats.Colors.uncommon .. L["Temporary Solution:"]);
				print(SmexyMats.Colors.wowtoken .. L["[SM]:"] .. SmexyMats.Colors.yellow .. L["1. Link the item in chat."]);
				print(SmexyMats.Colors.wowtoken .. L["[SM]:"] .. SmexyMats.Colors.yellow .. L["2. Click on it."]);
				print(SmexyMats.Colors.wowtoken .. L["[SM]:"] .. SmexyMats.Colors.uncommon .. L["To turn off these errors:"]);
				print(SmexyMats.Colors.wowtoken .. L["[SM]:"] .. SmexyMats.Colors.yellow .. L["type /sm and uncheck 'Report errors to chat'."]);
				print(SmexyMats.Colors.wowtoken .. L["[SM]:"] .. SmexyMats.Colors.uncommon .. L["More Info:"]);
				print(SmexyMats.Colors.wowtoken .. L["[SM]:"] .. SmexyMats.Colors.yellow .. L["More info on why this error occured can be found here:"]);
				print(SmexyMats.Colors.Mage .. "http://wowprogramming.com/docs/api/GetItemInfo");
				LID = _G["GameTooltipTextLeft1"]:GetText();
			end;
		end;
		return;
	end;
	
	local ProFor, ProFrom, EP, AltFor;
	
	if (SmexyMats:Gear_ExpackID(obj)) == true then
		qwe, EP, ExpackID = SmexyMats:Gear_ExpackID(obj); 
		ProFor, ProFrom = SmexyMats:FormatToolTipString(obj.ID);
	else
		ProFor, ProFrom, EP, AltFor = SmexyMats:FormatToolTipString(obj.ID);
	end;
	
	local tttE, tttS, tttP, tttI;
	if (SmexyMatsDB.profile.SMText == true) then
		tttE = L["[SM]Expansion: "];
		tttS = L["[SM]Source(s): "];
		tttP = L["[SM]Profession(s): "];
		tttU = L["[SM]ExpackID: "];
		tttI = L["[SM]ItemID: "];
	else	
		tttE = L["Expansion: "];
		tttS = L["Source(s): "];
		tttP = L["Profession(s): "];
		tttU = L["ExpackID: "];
		tttI = L["ItemID: "];
	end;
	
	local CBOne, CBTwo = "", "";
	
	if (SmexyMatsDB.profile.ColorBlindPickedOne ~= nil) then 
		CBOne = tostring("|cFF" .. SmexyMatsDB.profile.ColorBlindPickedOne); 
	else 
		CBOne = "|cFFFFFFFF"; 
	end;
	if (SmexyMatsDB.profile.ColorBlindPickedTwo ~= nil) then 
		CBTwo = tostring("|cFF" .. SmexyMatsDB.profile.ColorBlindPickedTwo); 
	else 
		CBTwo = "|cFFFFFFFF"; 
	end;
	
	local EPC = nil;
	
	if (SmexyMatsDB.profile.Contents == true) then 
		if EP ~= nil then
			if(SmexyMatsDB.profile.ExpackIconsEnabled) then
				local t = {};
				t[ #t+1 ] = "|T"
				t[ #t+1 ] = SmexyMats.ExPacks[EP].icon
				t[ #t+1 ] = ":"
				t[ #t+1 ] = SmexyMatsDB.profile.TooltipExpackSize
				t[ #t+1 ] = "|t "
				local tx = table.concat(t);
				tt:AddLine(tx,0,0,0,true);
			else
				if (SmexyMatsDB.profile.IsColorBlind == true) then
					EPC = CBTwo .. SmexyMats.ExPacks[EP].name;
				else
					EPC = SmexyMats.ExPacks[EP].name;
				end;
			
				if (SmexyMatsDB.profile.IsColorBlind) then
					tt:AddLine(CBOne .. tttE .. EPC,0,0,0,true);
				else
					tt:AddLine(SmexyMats.Colors.wowtoken .. tttE .. SmexyMats.ExPacks[EP].color .. EPC,0,0,0,true);
				end;
			end;
		end; 
	end;
	if (SmexyMatsDB.profile.Sources == true) then
		if (obj.aa) and (ProFrom) and (#(ProFrom) > 0) then
			if (SmexyMatsDB.profile.IsColorBlind) then
				tt:AddLine(CBOne .. tttS .. CBTwo .. ProFrom,0,0,0,true);
			else
				if(SmexyMatsDB.profile.IconsEnabled) then
					tt:AddLine(SmexyMats.Colors.wowtoken .. tttS .. "\r\n\r\n" .. SmexyMats.Colors.white .. ProFrom,0,0,0,true);
				else
					tt:AddLine(SmexyMats.Colors.wowtoken .. tttS .. SmexyMats.Colors.white .. ProFrom,0,0,0,true);
				end;
			end;
		end;
	end;
	if (SmexyMatsDB.profile.Professions == true) then
		if (obj.aa) and (ProFor) and (#(ProFor) > 0) then 
			if (SmexyMatsDB.profile.IsColorBlind) then
				tt:AddLine(CBOne .. tttP .. CBTwo .. ProFor,0,0,0,true);
			else		
				if(SmexyMatsDB.profile.IconsEnabled) then
					tt:AddLine(SmexyMats.Colors.wowtoken .. tttP.. "\r\n\r\n" .. SmexyMats.Colors.white .. ProFor,0,0,0,true);
				else
					tt:AddLine(SmexyMats.Colors.wowtoken .. tttP .. SmexyMats.Colors.white .. ProFor,0,0,0,true);
				end;
			end;
		end;
	end;
	if (SmexyMatsDB.profile.ExpackIDs == true) then 
		if (SmexyMatsDB.profile.IsColorBlind) then
			tt:AddLine(CBOne .. tttU .. CBTwo .. obj.oo,0,0,0,true);
		else
			tt:AddLine(SmexyMats.Colors.wowtoken .. tttU .. SmexyMats.Colors.Paladin .. obj.oo,0,0,0,true);
		end;
	end;
	if (SmexyMatsDB.profile.ItemIDs == true) then 
		if (SmexyMatsDB.profile.IsColorBlind) then
			tt:AddLine(CBOne .. tttI .. CBTwo .. obj.ID,0,0,0,true);
		else
			tt:AddLine(SmexyMats.Colors.wowtoken .. tttI .. SmexyMats.Colors.Paladin .. obj.ID,0,0,0,true);
		end;
	end;
	
	local RealmName = GetRealmName();
	local _, FactionName = UnitFactionGroup("player");
	local CharacterName = UnitName("player");
	local FAH = nil;
	local proString = "";
	local appRealm = false;
	
	if (IsAltKeyDown()) then
		if isTooltipDone then isTooltipDone = false; end;
		tt:AddLine(" ",0,0,0);
		if (SmexyMatsDB.profile.IsColorBlind) then
			tt:AddLine(CBTwo .. "ALTS",0,0,0,true);
		else
			tt:AddLine(SmexyMats.Colors.artifact .. "ALTS",0,0,0,true);
		end;
		if (SmexyMatsDB.ProTree) then
			for pro, _ in pairs(SmexyMatsDB.ProTree) do
				if (ProFor) and (AltFor) then
					if (string.match(ProFor, SmexyMats:trim(pro))) or (string.match(AltFor, SmexyMats:trim(pro))) then
						if(SmexyMatsDB.profile.IconsEnabled) then
							local arrProfIDs = {-3,-2,-1,1,2,3,4,5,6,7,8,9,10,11,12,13,14}
							local pID;
							for _, j in pairs(arrProfIDs) do
								if (pro == SmexyMats.Profs[j].name) then
									pID = j;
									do break end;
								end;
							end;
							local t = {};
							t[ #t+1 ] = "|T"; 
							t[ #t+1 ] = SmexyMats.Profs[pID].spelltexture; 
							t[ #t+1 ] = ":"; 
							t[ #t+1 ] = SmexyMatsDB.profile.TooltipIconSize; 
							t[ #t+1 ] = "|t ";
							local AltProIcon = table.concat(t);
							tt:AddLine("\r\n"..AltProIcon,0,0,0,true);
						else
							if (SmexyMatsDB.profile.IsColorBlind) then
								tt:AddDoubleLine(CBOne .. pro, "",r,b,g,0,0,0,true);
							else
								tt:AddDoubleLine(SmexyMats.Colors.wowtoken .. pro, "",r,b,g,0,0,0,true);
							end;
						end;
						for fac, _ in pairs (SmexyMatsDB.ProTree[pro]) do
							local strFAC = "["..string.sub(fac, 1, 1).."]";
							for rel, _ in pairs (SmexyMatsDB.ProTree[pro][fac]) do
								local tblLen = SmexyMats:TableLength(SmexyMatsDB.ProTree[pro][fac][rel])
								if (tblLen > 0 ) then
									for chr,_ in pairs(SmexyMatsDB.ProTree[pro][fac][rel]) do
										if (proString == "") then
											proString = SmexyMats:trim(chr)..strFAC.."-"..rel..'\r\n';
										end;
										if not (string.match(proString, SmexyMats:trim(chr))) then
											proString = proString .. SmexyMats:trim(chr)..strFAC.."-"..rel..'\r\n';
										end;
										if(SmexyMatsDB.profile.AllRealms) then
											if (SmexyMatsDB.profile.IsColorBlind) then
												tt:AddLine(CBTwo .. proString,0,0,0,true);
											else
												tt:AddLine(SmexyMats.Colors.white .. proString,0,0,0,true);
											end;
										else
											if(rel == RealmName) then								
												if (SmexyMatsDB.profile.IsColorBlind) then
													tt:AddLine(CBTwo .. proString,0,0,0,true);
												else
													tt:AddLine(SmexyMats.Colors.white .. proString,0,0,0,true);
												end;
											end;
										end;
										proString = "";
									end;
								end;
							end;
						end;
					end;
				end;
			end;
		end;
		tt:AddLine(" ",0,0,0);
	end;
end;

function SmexyMats:TableLength(T)
	local count = 0;
	for _ in pairs(T) do 
		count = count + 1; 
	end;
	return count;
end;

function ExamineObject(obj)
	if not obj then 
		return false; 
	end; 
	if (not obj.aa) or (obj.aa == "") or (not obj.bb) or (not obj.ID) or (obj.ID == 0) then 
		return false; 
	end; 
	return true;
end;

function SmexyMats.ModifyItemTooltip(tt, ...)
	if (SmexyMatsDB.profile.Enabled == false) then  return; end;
	local obj, name, link, itemAquired = nil, nil, nil, false;
	local objTXT = _G["GameTooltipTextLeft1"]:GetText();
	if (isTooltipDone == nil) and tt then
		isTooltipDone = true;
		name, link = tt:GetItem();
		obj = SmexyMats:GetItemProperties(link)
		if (ExamineObject(obj)) and (ExamineObject(obj)) then
			itemAquired = true;
		else
			link = storedLink; 
			obj = SmexyMats:GetItemProperties(link);
			if (ExamineObject(obj) == true) and (ExamineObject(obj) == true) then 
				itemAquired = true;
			else
				obj = SmexyMats:GetItemProperties(objTXT);
				if (ExamineObject(obj)) and (ExamineObject(obj)) then 
					itemAquired = true; 
				end;
			end;
		end;
		if itemAquired then 
			SmexyMats:ProcessTooltip(tt, obj); 
		end;
	end;
end;

function SmexyMats:FormatToolTipString(iID)
	local zForTTL, zFromTTL, zEP, zAltTTL = SmexyMats:SearchDatabase(iID); 
	local zForTTS = "";
	local zFromTTS = "";
	local zAltTTS = "";
	
	table.sort(zAltTTL);
	for k, v in pairs(zAltTTL) do 
		if (zAltTTS == "") then 
			zAltTTS = SmexyMats:trim(v); 
		else
			if not (string.match(zAltTTS, SmexyMats:trim(v))) then
				zAltTTS = zAltTTS .. ", " .. SmexyMats:trim(v);
			end;
		end;
	end;
	
	table.sort(zForTTL);
	for k, v in pairs(zForTTL) do 
		if (zForTTS == "") then 
			zForTTS = SmexyMats:trim(v); 
		else
			if not (string.match(zForTTS, SmexyMats:trim(v))) then
				if(SmexyMatsDB.profile.IconsEnabled) then
					zForTTS = zForTTS .. " " .. SmexyMats:trim(v); 
				else
					zForTTS = zForTTS .. ", " .. SmexyMats:trim(v);
				end;
			end;
		end;
	end;
	
	table.sort(zFromTTL);
	for k, v in pairs(zFromTTL) do 
		if (zFromTTS == "") then 
			zFromTTS = SmexyMats:trim(v); 
		else 
			if not(string.match(zFromTTS, SmexyMats:trim(v))) then
				if(SmexyMatsDB.profile.IconsEnabled) then
					zFromTTS = zFromTTS .. " " .. SmexyMats:trim(v); 
				else
					zFromTTS = zFromTTS .. ", " .. SmexyMats:trim(v); 
				end;
			end;
		end;
	end;
	
	return zForTTS, zFromTTS, zEP, zAltTTS;
end;

function SmexyMats:SearchDatabase(iID)
	local xForTTL = {};
	local xFromTTL = {};
	local xAltTTL = {};
	local zz = nil;
	
	if not iID then return; end;
	
	--Loops through Professions
	for x = 1, 14 do
		--Loops through Expansions
		for y = 0, 10 do
			--Loops through Sources
			for k, v in pairs( SmexyMats.Sources[x][y] ) do 
				if (tonumber(iID) == v) then
					if(SmexyMatsDB.profile.IconsEnabled) then
						local t = {};
						t[ #t+1 ] = "|T"
						t[ #t+1 ] = SmexyMats.Profs[x].spelltexture
						t[ #t+1 ] = ":"
						t[ #t+1 ] = SmexyMatsDB.profile.TooltipIconSize
						t[ #t+1 ] = "|t "
						local tx = table.concat(t);
						table.insert(xFromTTL, tx);
					else
						table.insert(xFromTTL, SmexyMats.Profs[x].name);
					end;
					
					zz = y;
				end;
			end;
			--Loops through Reagents
			for l, w in pairs( SmexyMats.Reagents[x][y] ) do 
				if (tonumber(iID) == w) then
					table.insert(xAltTTL, SmexyMats.Profs[x].name);
					if(SmexyMatsDB.profile.IconsEnabled) then
						local t = {};
						t[ #t+1 ] = "|T"
						t[ #t+1 ] = SmexyMats.Profs[x].spelltexture
						t[ #t+1 ] = ":"
						t[ #t+1 ] = SmexyMatsDB.profile.TooltipIconSize
						t[ #t+1 ] = "|t "
						local tx = table.concat(t);
						table.insert(xForTTL, tx);
					else
						table.insert(xForTTL, SmexyMats.Profs[x].name);
					end;
					zz = y;
				end;
			end;
		end;
	end;
	--Loops through Vendor Mats
	for _c, _d in pairs( SmexyMats.Vendor ) do 
		if (tonumber(iID)) == _d then 
			if(SmexyMatsDB.profile.IconsEnabled) then
				local t = {};
				t[ #t+1 ] = "|T"
				t[ #t+1 ] = SmexyMats.Profs[-1].spelltexture
				t[ #t+1 ] = ":"
				t[ #t+1 ] = SmexyMatsDB.profile.TooltipIconSize
				t[ #t+1 ] = "|t "
				local tx = table.concat(t);
				table.insert(xFromTTL, tx);
			else
				table.insert(xFromTTL, SmexyMats.Profs[-1].name);
			end;
		end; 
	end;
	--Loops through Drops
	for _e, _f in pairs( SmexyMats.Drop ) do 
		if (tonumber(iID)) == _f then 
			if(SmexyMatsDB.profile.IconsEnabled) then
				local t = {};
				t[ #t+1 ] = "|T"
				t[ #t+1 ] = SmexyMats.Profs[-2].spelltexture
				t[ #t+1 ] = ":"
				t[ #t+1 ] = SmexyMatsDB.profile.TooltipIconSize
				t[ #t+1 ] = "|t "
				local tx = table.concat(t);
				table.insert(xFromTTL, tx);
			else
				table.insert(xFromTTL, SmexyMats.Profs[-2].name);
			end; 
		end; 
	end;
	--Loops through Scraps
	for _g, _h in pairs( SmexyMats.Scrap ) do 
		if (tonumber(iID)) == _h then 
			if(SmexyMatsDB.profile.IconsEnabled) then
				local t = {};
				t[ #t+1 ] = "|T"
				t[ #t+1 ] = SmexyMats.Profs[-3].spelltexture
				t[ #t+1 ] = ":"
				t[ #t+1 ] = SmexyMatsDB.profile.TooltipIconSize
				t[ #t+1 ] = "|t "
				local tx = table.concat(t);
				table.insert(xFromTTL, tx);
			else
				table.insert(xFromTTL, SmexyMats.Profs[-3].name);
			end;
		end; 
	end;
	--Returns Results
	return xForTTL, xFromTTL, zz, xAltTTL;
end;