--[[
	Project.....: AzhtyhxUI
	File........: Money.lua
	Description.: Money element of the informational bar, displays the players' money
	Author......: Azhtyhx
]]

----------------
-- / Locals / --
----------------

-- Get the mother module
local Module = AUI:GetModule("InfoBar");
-- Setup element
local Element = Module:NewElement("Money");

-- Element defaults
local Defaults = {
	Anchors = {
		Point = "LEFT", xOffset = 10,
	},
};

local function FormatMoney(Money)
	-- Get the absolute value of our money
	Money = abs(Money);

	-- Turn it into gold, silver, and copper
	local Gold = math.floor(Money / 10000);
	local Silver, Copper = mod(floor(Money / 100), 100), mod(floor(Money), 100);

	-- Format text based on our gold, silver, and copper
	-- and return it
	if (Gold > 0) then
		return format("%dg %ds", Gold, Silver);
	elseif (Silver > 0) then
		return format("%ds %dc", Silver, Copper);
	else
		return format("%dc", Copper);
	end
end

local function UpdateMoneyText(Button)
	local NewMoney = GetMoney();

	Button.Text:SetText(FormatMoney(NewMoney));
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
	-- The usual event check
	if (event == "PLAYER_MONEY") then
		UpdateMoneyText(this);
	end
end

---------------
-- / Setup / --
---------------

function Element:OnCreate(Button)
	-- Set the button text
	UpdateMoneyText(Button);

	-- Register for Events
	Button:RegisterEvent("PLAYER_MONEY");

	-- Setup OnEvent callback
	Button:SetScript("OnEvent", Element.OnEvent);
end

function Element:Initialize()
	Module:RegisterDatabase(Element.Name, Defaults);
end