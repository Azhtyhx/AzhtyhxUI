--[[
	Project.....: AzhtyhxUI
	File........: InfoBar.lua
	Description.: Creates informational bars at the top of the screen to hold visual data.
	Author......: Azhtyhx

	Notes.......: Instead of OnCreate we could raise Enable
]]

-- Setup module
local Module = AUI:NewModule("InfoBar");

local Elements = {};

-- Module defaults
local Defaults = {
	
};

------------------
-- / Elements / --
------------------

-- Elements register via this function
--- @Name - The name of the element, also the title text of the tooltip
--- @Location - Whether the element should be positioned to the right or left
--- @Index - The order in which this element will be positioned, 1 = corner most, followed by 2 etc
function Module:NewElement(Name)
	-- We need a name, specified location, and index to continue
	if (not Name) then
		AUI:Print("Error");
	end

	-- Create the element
	local Element = {
		Name = Name,
	};

	-- Store the element in our table
	tinsert(Elements, Element);

	-- Return the newly created module
	return Element;
end

function Module:RegisterDatabase(Name, Database)
	-- Only continue if we have a name and database
	-- Could also check if database is a table
	if (not Name) or (not Database) then
		return;
	end

	-- Insert into the defaults if not already there
	if (not Defaults[Name]) then
		Defaults[Name] = Database;
	end
end

local function OnClickHandler()
	local Element = this.Element;
	if (Element and Element.OnClick) then
		Element:OnClick();
	end
end

local function OnEnterHandler()
	local Element = this.Element;
	if (Element and Element.OnEnter) then
		Element:OnEnter();
	end
end

local function OnLeaveHandler()
	local Element = this.Element;
	if (Element and Element.OnLeave) then
		Element:OnLeave();
	end
end

local function ConstructElement(Element)
	-- Button Base
	local Button = CreateFrame("Button", "InfoBar"..Element.Name, InfoBar);
	Button.Name = Element.Name;
	Button.Element = Element;

	-- Button Scripts
	Button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	Button:SetScript("OnClick", OnClickHandler);
	Button:SetScript("OnEnter", OnEnterHandler);
	Button:SetScript("OnLeave", OnLeaveHandler);

	-- Button Text
	Button.Text = Button:CreateFontString(Name, Layer);
	Button.Text:SetFont("Fonts\\FRIZQT__.TTF", 12);
	Button.Text:SetJustifyH("LEFT");

	-- Position the Text
	local Anchors = Defaults[Element.Name].Anchors;
	Button.Text:SetPoint(Anchors.Point, InfoBar, Anchors.xOffset, 0);

	-- Wrap the Text with the Button
	Button:SetAllPoints(Button.Text);

	Button.Text:SetText("Debug Text");

	-- Element specific functionality
	if (Element.OnCreate) then
		Element:OnCreate(Button);
	end
end

local function ConstructElements()
	-- We construct all the elements here, and point to the elements' own
	-- OnClick and OnEnter/OnLeave functions
	-- Any other specific functionality is set up locally by each element
	for K, V in Elements do
		-- A check will be done here later to find out if element is actually
		-- enabled by the user
		ConstructElement(V);
	end
end

local function SetupInfoBar()
	-- Just creating an empty frame to hold our elements
	local Frame = CreateFrame("Frame", "InfoBar", UIParent);
	Frame:SetWidth(GetScreenWidth() + 12);
	Frame:SetHeight(32);
	Frame:SetPoint("TOP", 0, 6);

	-- Frame Backdrop
	Frame:SetBackdrop({
		bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
      edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
      tile = true, tileSize = 16, edgeSize = 16, 
      insets = { left = 4, right = 4, top = 4, bottom = 4 }
   });
	Frame:SetBackdropColor(0.1, 0.1, 0.1, 0.8);

	-- Display the frame
	Frame:Show();
end

---------------
-- / Setup / --
---------------

function Module:Initialize()
	-- Initialize all elements
	for K, V in Elements do
		if (V.Initialize) then
			V:Initialize();
		end
	end
end

function Module:Enable()
	SetupInfoBar();
	ConstructElements();
end