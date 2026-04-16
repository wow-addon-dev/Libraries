ArcaneWizardLibrary_OptionsMenuTextMixin = {}

function ArcaneWizardLibrary_OptionsMenuTextMixin:Init(initializer)
	local data = initializer:GetData()
	self.LeftText:SetTextToFit(data.leftText)
	self.RightText:SetTextToFit(data.rightText)
end
