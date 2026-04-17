ArcaneWizardLibrary_SettingsPanelTextMixin = {}

function ArcaneWizardLibrary_SettingsPanelTextMixin:Init(initializer)
	local data = initializer:GetData()
	self.LeftText:SetTextToFit(data.leftText)
	self.RightText:SetTextToFit(data.rightText)
end
