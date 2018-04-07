--[[
	Project.....: AzhtyhxUI
	File........: Init.lua
	Description.: Initializes any addon data followed by any registered modules
	Author......: Azhtyhx
]]

local function Initialize()
	-- Call each registered modules' initialize function if it exists
	for ModuleName, ModuleData in AUI.Modules do
		if (ModuleData.Initialize) then
			ModuleData:Initialize();
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

-- OnEvent callback
InitFrame:SetScript("OnEvent", function()
	if (event == "ADDON_LOADED") then
		-- Initialize
		Initialize();

		-- We no longer need this event
		this:UnregisterEvent(event);
		this = nil;
	end
end)