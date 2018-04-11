--[[
	Project.....: AzhtyhxUI
	File........: Money.lua
	Description.: Money element of the informational bar, displays the players' gold
	Author......: Azhtyhx
]]

-- Get the mother module
local Module = AUI:GetModule("InfoBar");
-- Setup element
local Element = Module:NewElement("Money", "Left", 1);

function Element:OnClick()
	AUI:Print(self.Name.." clicked.");
end

function Element:OnEnter()
	AUI:Print(self.Name.." entered.");
end

function Element:OnLeave()
	AUI:Print(self.Name.." left.");
end