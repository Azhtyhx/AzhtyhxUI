--[[
	Project.....: AzhtyhxUI
	File........: MainMenuBar.lua
	Description.: Modifies the Main Menu Bar of the Blizzard UI
	Author......: Azhtyhx
]]

local Module = AUI:NewModule("MainMenuBar");

local function HideButtons()
	-- Bag Buttons
	MainMenuBarBackpackButton:Hide();
	for i = 0, 3 do
		getglobal("CharacterBag"..i.."Slot"):Hide();
	end

	-- Key Ring
	KeyRingButton:Hide();
	-- Override to avoid having the keyring button show up again
	MainMenuBarArtFrame:SetScript("OnLoad", nil);
	MainMenuBarArtFrame:SetScript("OnEvent", nil);

	-- Micromenu Buttons
	CharacterMicroButton:Hide();
	SpellbookMicroButton:Hide();
	TalentMicroButton:Hide();
	QuestLogMicroButton:Hide();
	SocialsMicroButton:Hide();
	WorldMapMicroButton:Hide();
	MainMenuMicroButton:Hide();
	HelpMicroButton:Hide();

	-- Override to avoid having the talent button show up again
	TalentMicroButton:SetScript("OnLoad", nil);
	TalentMicroButton:SetScript("OnEvent", nil);

	-- Action Bar page up/down buttons
	ActionBarUpButton:Hide();
	ActionBarDownButton:Hide();
end

local function ModifyFrames()
	-- Main Menu Bar
	MainMenuBar:SetWidth(512);

	-- Main Action Bar
	MainMenuBarTexture0:SetPoint("CENTER", MainMenuBarArtFrame, -128, 0);
	MainMenuBarTexture1:SetPoint("CENTER", MainMenuBarArtFrame, 128, 0);

	-- Action Bar page number frame
	MainMenuBarPageNumber:Hide();

	-- Latency Frame
	MainMenuBarPerformanceBarFrame:Hide();

	-- Art frames
	MainMenuBarTexture2:Hide();
	MainMenuBarTexture3:Hide();

	-- Gryphons
	MainMenuBarRightEndCap:SetPoint("CENTER", MainMenuBarArtFrame, 290, 0);
	MainMenuBarLeftEndCap:SetPoint("CENTER", MainMenuBarArtFrame, -290, 0);
end

local function ModifyBars()
	-- Experience Bar
	MainMenuExpBar:SetWidth(512);
	MainMenuXPBarTexture0:SetPoint("CENTER", -128, 0);
	MainMenuXPBarTexture1:SetPoint("CENTER", 128, 0);
	MainMenuXPBarTexture2:Hide()
	MainMenuXPBarTexture3:Hide();

	-- Reputation Watch Bar
	ReputationWatchStatusBar:SetWidth(512);
	ReputationWatchBarTexture0:SetPoint("CENTER", -128, 0);
	ReputationWatchBarTexture1:SetPoint("CENTER", 128, 0);
	ReputationXPBarTexture2:SetTexture(nil);
	ReputationXPBarTexture3:SetTexture(nil);
	ReputationWatchBarTexture2:SetTexture(nil);
	ReputationWatchBarTexture3:SetTexture(nil);

	-- Max Level Bar
	MainMenuBarMaxLevelBar:SetWidth(512);
	MainMenuMaxLevelBar0:SetPoint("CENTER", MainMenuBarArtFrame, -128, 0);
	MainMenuMaxLevelBar2:SetTexture(nil);
	MainMenuMaxLevelBar3:SetTexture(nil);
end

---------------
-- / Setup / --
---------------

function Module:Enable()
	HideButtons();
	ModifyFrames();
	ModifyBars();
end