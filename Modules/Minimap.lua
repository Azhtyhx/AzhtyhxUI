--[[
	Project.....: AzhtyhxUI
	File........: Minimap.lua
	Description.: Modifies the Minimap of the Blizzard UI
	Author......: Azhtyhx
]]

-- Setup module
local Module = AUI:NewModule("Minimap");

-- Module default user settings
Module.Defaults = {
	-- TODO
};

-----------------------
-- / Modifications / --
-----------------------

-- Enables the use of the mousewheel to zoom the minimap in and out
function Module:EnableMouseWheel()
	Minimap:EnableMouseWheel(true);
	Minimap:SetScript("OnMouseWheel", function()
		if (arg1 > 0) then
			-- Zoom in
			MinimapZoomIn:Click();
		else
			-- Zoom out
			MinimapZoomOut:Click();
		end
	end)
end

-- Constructs a frame with a fontstring to display the characters' current coordinates
function Module:SetupCoordinateFrame()
	-- Base Frame
	local Frame = CreateFrame("Frame", "MinimapCoordinateFrame", Minimap);
	Frame:SetWidth(50);
	Frame:SetHeight(50);
	Frame:SetPoint("TOP", Minimap, "BOTTOM", 0, 0);

	-- Text to hold the actual coordinates
	local FontString = Frame:CreateFontString("MinimapCoordinateFrameText", "ARTWORK", "GameFontHighlight");
	FontString:SetPoint("CENTER", 0, 15);

	-- Update locals
	local ElapsedTime = 0; -- The time passed since our last update
	local UpdateRate = 0.2; -- The rate at which the coordinate frame updates

	-- Using OnUpdate to update our text
	-- TODO: Move to separate function for enable/disable functionality
	Frame:SetScript("OnUpdate", function()
		-- Increment the time passed
		ElapsedTime = ElapsedTime + arg1;
		if (ElapsedTime >= UpdateRate) then
			-- Get the current coordinates of the player then format and display the text
			local X, Y = GetPlayerMapPosition("Player");
			FontString:SetText(format("%.1f, %.1f", X * 100, Y * 100));

			-- Reset the elapsed time
			ElapsedTime = 0;
		end
	end)
end

-- Moves the minimap slightly to make room for the informational bar
-- TODO: Check if the informational bar is actually enabled and shown
function Module:MoveMinimap()
	MinimapCluster:ClearAllPoints();
	MinimapCluster:SetPoint("TOPRIGHT", -15, -25);
end

-- Hides any unused children of this module
function Module:HideUnusedFrames()
	GameTimeFrame:Hide();
	MinimapBorderTop:Hide();
	MinimapZoneTextButton:Hide();
	MinimapToggleButton:Hide();
	MinimapZoomIn:Hide(); -- TODO: Add config for this, in case player has no mousewheel
	MinimapZoomOut:Hide(); -- TODO: Add config for this, in case player has no mousewheel
end

---------------
-- / Setup / --
---------------

function Module:Initialize()
	-- TODO: Register database defaults for this module
end

function Module:Enable()
	self:EnableMouseWheel();
	self:SetupCoordinateFrame();
	self:MoveMinimap();
	self:HideUnusedFrames();
end