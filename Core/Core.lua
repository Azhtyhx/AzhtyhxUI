--[[
	Project.....: AzhtyhxUI
	File........: Core.lua
	Description.: Sets up the addon namespace and holds any module functionality
	Author......: Azhtyhx
]]

-- Setup AddOn namespace
AUI = {
	Modules = {}, -- Table to hold any modules
	Localization = {}, -- Table to hold any localized strings
	Database = {}, -- Table to hold any user settings
};

-- Called by any modules of this addon
-- Gives us the ability to initalize, enable, and disable each module with ease
function AUI:NewModule(Name)
	-- We have no name, return
	if (not Name) then
		return;
	end

	-- Create a new module
	local Module = {
		Name = Name,
		Enabled = false, -- Used to track whether or not the module has been enabled yet this session
	};

	-- Insert the newly created module into our modules table
	AUI.Modules[Name] = Module;

	-- Return the created module
	return Module;
end

-- Returns a module with the specified name if it exists
function AUI:GetModule(Name)
	return AUI.Modules[Name] or nil;
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