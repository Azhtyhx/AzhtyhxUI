--[[
	Project.....: AzhtyhxUI
	File........: Friends.lua
	Description.: Friends element of the informational bar, displays online friends
	Author......: Azhtyhx
]]

-- Get the mother module
local Module = AUI:GetModule("InfoBar");
-- Setup element
local Element = Module:NewElement("Friends");

-- Element defaults
local Defaults = {
	Anchors = {
		Point = "RIGHT", xOffset = -400,
	},
};

local OnlineFriends = {};

local function CreateFriend(index)
	
end

local function UpdateFriendlist()
	-- Iterate through all our friends
	for i = 1, GetNumFriends() do
		-- Gather information about each friend
		local Name, Level, Class, Area = GetFriendInfo(i);
		-- If the level is 0, the friend is not online, no need to continue
		if (Level ~= 0) then
			-- Insert the online friend into our table
			local Friend = { ["Name"] = Name, ["Level"] = Level, ["Class"] = Class, ["Area"] = Area };
			table.insert(OnlineFriends, Friend);
		end
	end

	-- Update button text
	this.Text:SetText(string.format("Friends: %d", table.getn(OnlineFriends))); -- Localize me
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
	if (event == "FRIENDLIST_UPDATE") then
		UpdateFriendlist();
	end
end

---------------
-- / Setup / --
---------------

function Element:OnCreate(Button)
	-- Calling this function to query server for social information
	-- in order for said information to be available on login
	ShowFriends();

	-- Register for events
	Button:RegisterEvent("FRIENDLIST_UPDATE");

	-- Setup OnEvent callback
	Button:SetScript("OnEvent", Element.OnEvent);
end

function Element:Initialize()
	Module:RegisterDatabase(Element.Name, Defaults);
end