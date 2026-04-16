local addonName, LIB = ...

local L = LIB.Localization

ArcaneWizardLibrary.Dialog.linkDialog = nil
ArcaneWizardLibrary.Dialog.confirmDialog = nil

function ArcaneWizardLibrary.Dialog:ShowLinkDialog(address)
    if not self.linkDialog then
		local frameName = "ArcaneWizardLibrary_Dialog_LinkFrame"

        local frame = CreateFrame("Frame", frameName, UIParent, "TranslucentFrameTemplate")
        frame:SetFrameStrata("DIALOG")
        frame:SetClampedToScreen(true)
        frame:SetSize(400, 100)
        frame:SetPoint("CENTER", 0, 200)
        frame:Hide()

        tinsert(UISpecialFrames, frameName)

        frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.Text:SetJustifyH("CENTER")
        frame.Text:SetSpacing(2)
        frame.Text:SetPoint("TOPLEFT", 20, -20)
        frame.Text:SetPoint("TOPRIGHT", -20, -20)

        frame.EditBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
        frame.EditBox:SetSize(340, 20)
        frame.EditBox:SetAutoFocus(false)
        frame.EditBox:SetPoint("TOP", frame.Text, "BOTTOM", 0, -10)
        frame.EditBox:SetScript("OnEnterPressed", function(self)
            self:ClearFocus()
        end)

        frame.CloseButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        frame.CloseButton:SetSize(100, 22)
        frame.CloseButton:SetPoint("TOP", frame.EditBox, "BOTTOM", 0, -10)
        frame.CloseButton:SetScript("OnClick", function()
            frame:Hide()
        end)

        self.linkDialog = frame
    end

    if self.confirmDialog and self.confirmDialog:IsShown() then self.confirmDialog:Hide() end

    self.linkDialog.Text:SetText(L["dialog.link.text"])
    self.linkDialog.CloseButton:SetText(CLOSE)
    self.linkDialog.EditBox:SetText(address)
    self.linkDialog.EditBox:HighlightText()

    self.linkDialog:SetHeight(self.linkDialog:GetTop() - self.linkDialog.CloseButton:GetBottom() + 20)
    self.linkDialog:Show()
end

function ArcaneWizardLibrary.Dialog:ShowConfirmDialog(text, onConfirmCallback)
    if not self.confirmDialog then
        local frameName = "ArcaneWizardLibrary_Dialog_ConfirmFrame"

        local frame = CreateFrame("Frame", frameName, UIParent, "TranslucentFrameTemplate")
        frame:SetFrameStrata("DIALOG")
        frame:SetClampedToScreen(true)
        frame:SetSize(350, 100)
        frame:SetPoint("CENTER", 0, 200)
        frame:Hide()

        tinsert(UISpecialFrames, frameName)

        frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.Text:SetJustifyH("CENTER")
        frame.Text:SetSpacing(2)
        frame.Text:SetPoint("TOPLEFT", 20, -20)
        frame.Text:SetPoint("TOPRIGHT", -20, -20)

        frame.YesButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        frame.YesButton:SetSize(100, 22)
        frame.YesButton:SetPoint("TOP", frame.Text, "BOTTOM", -75, -10)

        frame.NoButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
        frame.NoButton:SetSize(100, 22)
        frame.NoButton:SetPoint("TOP", frame.Text, "BOTTOM", 75, -10)
        frame.NoButton:SetScript("OnClick", function()
            frame:Hide()
        end)

        self.confirmDialog = frame
    end

    if self.linkDialog and self.linkDialog:IsShown() then self.linkDialog:Hide() end

    self.confirmDialog.Text:SetText(text)
    self.confirmDialog.YesButton:SetText(YES)
    self.confirmDialog.NoButton:SetText(NO)

    self.confirmDialog.YesButton:SetScript("OnClick", function()
        if type(onConfirmCallback) == "function" then
            onConfirmCallback()
        end
        self.confirmDialog:Hide()
    end)

    self.confirmDialog:SetHeight(self.confirmDialog:GetTop() - self.confirmDialog.NoButton:GetBottom() + 20)
    self.confirmDialog:Show()
end
