--[[
	Project.....: AzhtyhxUI
	File........: Durability.lua
	Description.: Durability element of the informational bar, displays the players' durability
	Author......: Azhtyhx
]]

----------------
-- / Locals / --
----------------

-- Get the mother module
local Module = AUI:GetModule("InfoBar");
-- Setup element
local Element = Module:NewElement("Durability");

-- Element defaults
local Defaults = {
	Anchors = {
		Point = "LEFT", xOffset = 150,
	},
};

-- Table to hold the current durability in percent of any equipped items with durability
local ItemDurability = {};

-- All the equipment slots that can come with durability
local EquipmentSlots = {
	[(INVTYPE_HEAD)] = 1,
	[(INVTYPE_SHOULDER)] = 3,
	[(INVTYPE_CHEST)] = 5,
	[(INVTYPE_WAIST)] = 6,
	[(INVTYPE_LEGS)] = 7,
	[(INVTYPE_FEET)] = 8,
	[(INVTYPE_WRIST)] = 9,
	[(INVTYPE_HAND)] = 10,
	[(INVTYPE_WEAPONMAINHAND)] = 16,
	[(INVTYPE_WEAPONOFFHAND)] = 17,
	[(INVTYPE_RANGED)] = 18,
};

local Tooltip; -- Local custom tooltip used to gather durability information

local function UpdateDurability()
	-- Iterate through all the equipment slots that can come with durability
	for LocalName, EquipId in pairs(EquipmentSlots) do
		local HasItem = Tooltip:SetInventoryItem("Player", EquipId);
		if (HasItem) then
			-- If we actually have an item equipped in said slot
			-- Iterate through the tooltip to find the durability
			for i = 1, 30 do
				local TooltipLine = getglobal("DurabilityTooltipTextLeft"..i); -- Get the indexed line of the tooltip
				if (TooltipLine) then
					local Text = TooltipLine:GetText();
					if (Text) then
						local _, _, CurDurability, MaxDurability = string.find(Text, "^Durability (%d+) / (%d+)$"); -- Localize me
						if (CurDurability and MaxDurability) then
							-- Add the durability of the item to the table for future use
							ItemDurability[LocalName] = CurDurability and CurDurability / MaxDurability or nil;
						end
					end
				end
			end
		end
	end

	-- Find the lowest durability percentage for button text display
	local DisplayDurability = AUI:MinValue(ItemDurability, 1) * 100 or nil;
	this.Text:SetText(string.format("Armor: %d%%", DisplayDurability or 100)); -- Localize me

	-- We also want to update the actual tooltip in case we are showing it during update
	
end

--------------------------
-- / Script Callbacks / --
--------------------------

function Element:OnClick()
	
end

function Element:OnEnter()
	
end

function Element:OnLeave()
	
end

function Element:OnEvent()
	-- The usual check
	if (event == "UPDATE_INVENTORY_ALERTS") then
		UpdateDurability();
	end
end

---------------
-- / Setup / --
---------------

local function SetupTooltip()
	Tooltip = CreateFrame("GameTooltip", "DurabilityTooltip", UIParent, "GameTooltipTemplate");
	Tooltip:SetOwner(WorldFrame, "ANCHOR_NONE");

	-- Need to clear all the scripts to avoid problems, won't need them anyway
	Tooltip:SetScript("OnLoad", nil);
	Tooltip:SetScript("OnHide", nil);
	Tooltip:SetScript("OnTooltipSetDefaultAnchor", nil);
	Tooltip:SetScript("OnTooltipAddMoney", nil);
	Tooltip:SetScript("OnTooltipCleared", nil);
end

local function HideDurabilityFrame()
	-- The durability frame need to fire it's OnEvent callback at least once
	-- Otherwise the ActionBars go haywire
	-- That is why I keep the PLAYER_ENTERING_WORLD event
	DurabilityFrame:SetScript("OnUpdate", nil);
	DurabilityFrame:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
end

function Element:OnCreate(Button)
	-- Setup our tooltip
	SetupTooltip();

	-- Hide Blizzard Durability Frame
	HideDurabilityFrame();

	-- Register for Events
	Button:RegisterEvent("UPDATE_INVENTORY_ALERTS");

	-- Setup OnEvent callback
	Button:SetScript("OnEvent", Element.OnEvent);
end

function Element:Initialize()
	Module:RegisterDatabase(Element.Name, Defaults);
end