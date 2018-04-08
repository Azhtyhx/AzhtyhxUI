--[[
	Project.....: AzhtyhxUI
	File........: Core.lua
	Description.: Sets up the addon namespace and holds any module functionality
	Author......: Azhtyhx
]]

-- Setup AddOn namespace
AUI = {};

local Modules = {}; -- Table to hold any modules
local ModuleKeys = {}; -- Table to hold any module names, used as key when fetching a module with a number

local Localization = {}; -- Table to hold any localized strings
local Database = {}; -- Table to hold any user settings

-- Called by any modules of this addon
-- Gives us the ability to initalize, enable, and disable each module with ease
function AUI:NewModule(Name)
	-- We have no name, return
	if (not Name) then
		return;
	end

	-- A module with specified name already exists
	if (Modules[Name]) then
		return;
	end

	-- Create a new module
	local Module = {
		Name = Name,
		Enabled = false, -- Used to track whether or not the module has been enabled yet this session
	};

	-- Insert the newly created module into our modules table
	Modules[Name] = Module;
	-- Also store the name in the module names table
	tinsert(ModuleKeys, Name);

	-- Return the created module
	return Module;
end

-- Returns a registered module with the specified key if it exists
function AUI:GetModule(Key)
	return Modules[Key] or Modules[ModuleKeys[Key]] or nil;
end

-- Returns the number of registered modules
function AUI:GetNumModules()
	local Count = 0;

	-- Iterate through the modules and increment the count
	for K in Modules do
		Count = Count + 1;
	end

	return Count;
end

-- Print function for easy logging to chat window
-- Might be moved to another location later on
function AUI:Print(Message, R, G, B, Frame)
	-- Is the message empty?
	if (not Message or string.len(Message) == 0) then
		Message = " ";
	end

	-- Print the message to the specified chat frame or default
	(Frame or DEFAULT_CHAT_FRAME):AddMessage("|cffffff78AUI:|r " .. Message, R, G, B);
end