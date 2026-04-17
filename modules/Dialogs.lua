local addonName, LIB = ...

local L = LIB.Localization

StaticPopupDialogs["ARCANE_WIZARD_LIB_LINK"] = {
    text = L["dialog.link.text"],
    button1 = CLOSE,
    hasEditBox = true,
	editBoxWidth = 300,
    OnShow = function(self, data)
		self:GetEditBox():SetText(data)
        self:GetEditBox():HighlightText()
        self:GetEditBox():SetFocus()
		self:SetWidth(350)
    end,
	EditBoxOnTextChanged = function(self, data)
		self:SetText(data)
        self:HighlightText()
        self:SetFocus()
    end,
    EditBoxOnEnterPressed = function(self)
        self:GetParent():Hide()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
	fullScreenCover = true
}

StaticPopupDialogs["ARCANE_WIZARD_LIB_CONFIRM"] = {
    text = "%s",
    button1 = YES,
    button2 = NO,
    OnAccept = function(self, data)
        if type(data) == "function" then
            data()
        end
    end,
    timeout = 0,
    whileDead = true,
	showAlert = true,
    hideOnEscape = true,
    preferredIndex = 3,
	fullScreenCover = true
}

function ArcaneWizardLibrary.Dialogs:ShowLinkDialog(address)
    StaticPopup_Show("ARCANE_WIZARD_LIB_LINK", nil, nil, address)
end

function ArcaneWizardLibrary.Dialogs:ShowConfirmDialog(text, onConfirmCallback)
    StaticPopup_Show("ARCANE_WIZARD_LIB_CONFIRM", text, nil, onConfirmCallback)
end
