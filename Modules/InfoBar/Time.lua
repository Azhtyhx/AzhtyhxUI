--[[
	Project.....: AzhtyhxUI
	File........: Time.lua
	Description.: Time element of the informational bar, displays the current time
	Author......: Azhtyhx
]]

-- Get the mother module
local Module = AUI:GetModule("InfoBar");
-- Setup element
local Element = Module:NewElement("Time");

-- Element defaults
local Defaults = {
	Anchors = {
		Point = "RIGHT", xOffset = -10,
	},
};

local tonumber;
local ElapsedTime = 0;
local CLOCK_UPDATE_RATE = 1;

local function UpdateTime(Button, UseLocal)
	-- Some locals
	local Hour, Minute, PM;

	if (UseLocal) then
		Hour, Minute = tonumber(date("%H")), date("%M");
	else
		Hour, Minute = GetGameTime();
	end

	local Test = format("%d:%.2d %s", Hour, Minute, PM or "");
	(Button or this).Text:SetText(Test);
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

function Element:OnUpdate()
	ElapsedTime = ElapsedTime + arg1;
	if (ElapsedTime >= CLOCK_UPDATE_RATE) then
		UpdateTime();

		ElapsedTime = 0;
	end
end

---------------
-- / Setup / --
---------------

function Element:OnCreate(Button)
	-- Set the text
	UpdateTime(Button);

	-- Setup OnUpdate callback
	Button:SetScript("OnUpdate", Element.OnUpdate);
end

function Element:Initialize()
	Module:RegisterDatabase(Element.Name, Defaults);
end