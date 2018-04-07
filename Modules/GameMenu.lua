--[[
	Project.....: AzhtyhxUI
	File........: GameMenu.lua
	Description.: Modifies the Game Menu of the Blizzard UI
	Author......: Azhtyhx
]]

local Module = AUI:NewModule("GameMenu");

local function ModifyGameMenu()
	-- Add a Help button to the game menu
	-- as it won't exist in the micromenu
	local Button = CreateFrame("Button", "GameMenuButtonHelp", GameMenuFrame, "GameMenuButtonTemplate");
	Button:SetText(HELP_BUTTON);
	Button:SetPoint("CENTER", GameMenuFrame, "TOP", 0, -37);
	Button:SetScript("OnClick", function()
		ToggleHelpFrame();
		HideUIPanel(GameMenuFrame);
	end)

	-- Alter the point of the options button
	GameMenuButtonOptions:ClearAllPoints();
	GameMenuButtonOptions:SetPoint("TOP", GameMenuButtonHelp, "BOTTOM", 0, -1);

	-- Increase the height of the game menu to fit all the widgets
	GameMenuFrame:SetHeight(255);
end

function Module:Enable()
	ModifyGameMenu();
end