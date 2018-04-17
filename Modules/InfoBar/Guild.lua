--[[
	Project.....: AzhtyhxUI
	File........: Guild.lua
	Description.: Guild element of the informational bar, displays online guild members
	Author......: Azhtyhx
]]

-- Get the mother module
local Module = AUI:GetModule("InfoBar");
-- Setup element
local Element = Module:NewElement("Guild");

-- Element defaults
local Defaults = {
	Anchors = {
		Point = "RIGHT", xOffset = -200,
	},
};

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
	
end

---------------
-- / Setup / --
---------------

function Element:OnCreate(Button)
	-- Set the default text for this element
	Button.Text:SetText("No Guild");

	-- Calling this function to query server for guild information
	-- in order for said information to be available on login
	if (IsInGuild()) then
		GuildRoster();
	end

	-- Register for events
	Button:RegisterEvent("GUILD_ROSTER_UPDATE");

	-- Setup OnEvent callback
	Button:SetScript("OnEvent", Element.OnEvent);
end

function Element:Initialize()
	Module:RegisterDatabase(Element.Name, Defaults);
end