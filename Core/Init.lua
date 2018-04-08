--[[
	Project.....: AzhtyhxUI
	File........: Init.lua
	Description.: Initializes any addon data followed by any registered modules
	Author......: Azhtyhx
]]

local NumModules;

local function Initialize()
	NumModules = AUI:GetNumModules();

	-- Call each registered modules' initialize function if it exists
	local Module;
	for i = 1, NumModules do
		Module = AUI:GetModule(i);
		if (Module and Module.Initialize) then
			Module:Initialize();
		end
	end
end

local function Enable()
	-- TODO: Add database check in case module has been disabled

	-- Call each registered modules' enable function if it exists
	local Module;
	for i = 1, NumModules do
		Module = AUI:GetModule(i);
		if (Module and Module.Enable) then
			Module:Enable();
		end
	end
end

------------------------------
-- / Initialization Frame / --
------------------------------

-- Basic frame for initialization
local InitFrame = CreateFrame("Frame");

-- Register for events
InitFrame:RegisterEvent("ADDON_LOADED");
InitFrame:RegisterEvent("PLAYER_LOGIN");

-- OnEvent callback
InitFrame:SetScript("OnEvent", function()
	-- Using ADDON_LOADED to initialize the addon
	if (event == "ADDON_LOADED") then
		-- Initialize
		Initialize();

		-- We no longer need this event
		this:UnregisterEvent(event);
	end

	-- Using PLAYER_LOGIN to enable the addon
	if (event == "PLAYER_LOGIN") then
		-- Enable
		Enable();

		-- We no longer need this event
	end
end)