--[[
	Project.....: AzhtyhxUI
	File........: InfoBar.lua
	Description.: Creates informational bars at the top of the screen to hold visual data.
	Author......: Azhtyhx
]]

-- Setup module
local Module = AUI:NewModule("InfoBar");

local Elements = {
	Left = {},
	Right = {},
};

------------------
-- / Elements / --
------------------

-- Elements register via this function
--- @Name - The name of the element, also the title text of the tooltip
--- @Location - Whether the element should be positioned to the right or left
--- @Index - The order in which this element will be positioned, 1 = corner most, followed by 2 etc
function Module:NewElement(Name, Location, Index)
	-- We need a name, specified location, and index to continue
	if (not Name) or (not Location) or (not Index) then
		AUI:Print("Error");
	end

	-- Create the element
	local Element = {
		Name = Name,
	};

	-- Store the element in our table
	tinsert(Elements[Location], Index, Element);

	-- Return the newly created module
	return Element;
end

local function SetFontString(Frame, Name, Font, Layer, hJustify, vJustfiy)
	local String = Frame:CreateFontString(Name, Layer);
	String:SetFont("Fonts\\FRIZQT__.TTF", 12);

	if (hJustify) then
		String:SetJustifyH(hJustify)
	end

	if (vJustify) then
		String:SetJustifyV(vJustify)
	end

	return String;
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

local function ConstructElement(Element, Bar)
	-- Frame Base
	local Frame = CreateFrame("Button", "InfoBar"..Element.Name, UIParent);
	Frame.Name = Element.Name;
	Frame.Element = Element;

	-- Frame FontString
	Frame.Text = SetFontString(Frame, Frame:GetName().."Text", nil, "OVERLAY", "LEFT");
	Frame.Text:SetTextColor(1, 1, 1);
	Frame.Text:SetShadowColor(0, 0, 0);
	Frame.Text:SetShadowOffset(1.25, -1.25);

	-- Frame Scripts
	Frame:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	Frame:SetScript("OnClick", OnClickHandler);
	Frame:SetScript("OnEnter", OnEnterHandler);
	Frame:SetScript("OnLeave", OnLeaveHandler);

	-- Specific element functionality
	if (Element.OnCreate) then
		Element:OnCreate(Frame);
	end

	-- Position the fontstring
	local Anchor = InfoBarLeft;
	Frame:SetParent(Anchor);
	Frame.Text:SetPoint("BOTTOMLEFT", Anchor, "BOTTOMLEFT", 5, 5);

	-- Wrap the fontstring with the frame
	Frame:SetAllPoints(Frame.Text);

	-- Frame Texture
	Frame.Texture = Frame:CreateTexture("DebugTexture", "ARTOWKR");
	Frame.Texture:SetTexture("Interface\\AddOns\\AzhtyhxUI\\Media\\InfoBar\\InfoBarElementLeft");
	Frame.Texture:SetAllPoints(Frame);

	-- Set the text and display the frame
	Frame.Text:SetText(Element.Name);
	Frame:Show();
end

local function ConstructElements(Bar)
	-- We construct all the elements here, and point to the elements own
	-- OnClick and OnEnter/OnLeave functions
	-- Any other specific functionality is set up locally by each element
	for K, V in Elements[Bar] do
		ConstructElement(V, Bar);
	end
end



local function ConstructInfoBar(Name, Point)
	local Frame = CreateFrame("Frame", "InfoBar"..Name, UIParent);
	Frame:SetWidth(28);
	Frame:SetHeight(28);
	Frame:SetPoint(Point, 0, 0);
end

local function SetupBars()
	ConstructInfoBar("Left", "TOPLEFT");
	ConstructInfoBar("Right", "TOPRIGHT");
end

local function SetupElements()
	ConstructElements("Left");
	ConstructElements("Right");
end

---------------
-- / Setup / --
---------------

function Module:Initialize()
	
end

function Module:Enable()
	SetupBars();
	SetupElements();
end