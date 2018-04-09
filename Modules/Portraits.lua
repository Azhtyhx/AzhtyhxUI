--[[
	Project.....: AzhtyhxUI
	File........: Portraits.lua
	Description.: Modifies the Player, Target, and Party portraits of the Blizzard UI
	Author......: Azhtyhx

	Note........: If this script grows too large, split it up
]]

-- Setup module
local Module = AUI:NewModule("Portraits");

local function MovePlayerPortrait()
	PlayerFrame:ClearAllPoints();
	PlayerFrame:SetPoint("CENTER", -200, -200);
end

local function MoveTargetPortrait()
	TargetFrame:ClearAllPoints();
	TargetFrame:SetPoint("CENTER", 200, -200);
end

---------------
-- / Setup / --
---------------

function Module:Enable()
	MovePlayerPortrait();
	MoveTargetPortrait();
end