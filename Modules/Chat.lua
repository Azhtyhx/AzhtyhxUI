--[[
	Project.....: AzhtyhxUI
	File........: Chat.lua
	Description.: Modifies the Chat of the Blizzard UI
	Author......: Azhtyhx
]]

-- Setup module
local Module = AUI:NewModule("Chat");

-- Module default user settings
local Defaults = {
	-- TODO
};

local function EnableMouseWheel()
	-- Iterate through all chat windows
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = getglobal("ChatFrame"..i);
		-- Enable MouseWheel
		Frame:EnableMouseWheel(true);
		Frame:SetScript("OnMouseWheel", function()
			if (arg1 > 0 ) then
			-- Scroll up
			this:ScrollUp();
			else
			-- Scroll down
			this:ScrollDown();
			end
		end)
	end
end

local function HideButtons()
	-- Iterate through all chat windows
	for i = 1, NUM_CHAT_WINDOWS do
		local Frame = getglobal("ChatFrame"..i);

		-- Hide buttons
		ChatFrameMenuButton:Hide();
      getglobal(Frame:GetName().."DownButton"):Hide();
      getglobal(Frame:GetName().."UpButton"):Hide();

      local BottomButton = getglobal(Frame:GetName().."BottomButton");
     	BottomButton:Hide();

		-- Override to avoid having the buttons showing up again
		Frame:SetScript("OnShow", function()
			BottomButton:Show();
			SetChatWindowShown(Frame:GetID(), 1);
		end)

		-- Not sure that I like this. Works for now I guess
		BottomButton:SetScript("OnUpdate", function()
			if (Frame:AtBottom()) then
				BottomButton:SetAlpha(0);
			else
				BottomButton:SetAlpha(1);
			end
		end)

		-- Show the BottomButton
		BottomButton:Show();
	end
end

local function ResizeAndMoveWindow()
	ChatFrame1:SetWidth(404);
	ChatFrame1:SetHeight(171);

	ChatFrame1:SetMovable(true);
	ChatFrame1:ClearAllPoints();

	ChatFrame1:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 28, 46);

	ChatFrame1:SetUserPlaced(true);
	ChatFrame1:SetMovable(false);
end

---------------
-- / Setup / --
---------------

function Module:Initialize()
	-- TODO: Register database defaults for this module
end

function Module:Enable()
	EnableMouseWheel();
	HideButtons();
	ResizeAndMoveWindow();
end