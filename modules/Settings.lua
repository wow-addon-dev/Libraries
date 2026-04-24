local addonName, LIB = ...

local L = LIB.Localization

--- Adds a clickable button to the settings layout.
---
--- @param layout table The layout object to append the initializer to.
--- @param config table Configuration table. Expected keys: name (string), buttonText (string), onClick (function), tooltip (string).
---
--- @return table initializer The layout initializer object for the button.
function ArcaneWizardLibrary.Settings:AddButton(layout, config)
    local initializer = CreateSettingsButtonInitializer(
        config.name,
        config.buttonText,
        config.onClick,
        config.tooltip,
        true
    )

    layout:AddInitializer(initializer)

    return initializer
end

--- Adds a static text row (typically used for key-value pairs like in an "About" section).
--- The height of the frame can be dynamically adjusted via the config.
---
--- @param layout table The layout object to append the initializer to.
--- @param config table Configuration table. Expected keys: leftText (string), rightText (string), height (number, optional).
---
--- @return table initializer The layout initializer object for the text panel.
function ArcaneWizardLibrary.Settings:AddInfoText(layout, config)
    local initializer = Settings.CreateElementInitializer("ArcaneWizardLibrary_SettingsPanelText", {
        leftText = config.leftText or "",
        rightText = config.rightText or "",
    })

    local line = layout:AddInitializer(initializer)

    function line:GetExtent()
        return config.height or 13
    end

    return initializer
end

--- Registers and creates a standard checkbox setting.
--- Supports automatic visual indentation and state handling if a parent element is provided.
---
--- @param category table The settings category object to which this option belongs.
--- @param config table Configuration table. Expected keys: settingKey, variableName, variableTable, name, tooltip, default. Optional: parentInit, parentCondition, onClick.
---
--- @return table checkbox The layout element for the checkbox.
--- @return table setting The registered setting object.
function ArcaneWizardLibrary.Settings:AddCheckbox(category, config)
    local setting = Settings.RegisterAddOnSetting(category, config.settingKey, config.variableName, config.variableTable, Settings.VarType.Boolean, config.name, config.default or false)
    local checkbox = Settings.CreateCheckbox(category, setting, config.tooltip)

    if config.parentInit and config.parentCondition then
        checkbox:SetParentInitializer(config.parentInit, config.parentCondition)
    end

    if config.onClick then
        setting:SetValueChangedCallback(config.onClick)
    end

    return checkbox, setting
end

--- Creates a combined Checkbox and Slider element in the WoW Settings menu.
--- This function registers both variables, sets up the layout initializer,
--- and applies a patch allowing the combo to act as a parent for dependent settings.
---
--- @param category table The settings category object.
--- @param layout table The layout object to append the initializer to.
--- @param config table Configuration table. Expected keys: checkboxSettingKey, checkboxVarName, checkboxName, checkboxTooltip, checkboxDefault, sliderSettingKey, sliderVariableName, sliderName, sliderTooltip, sliderDefault, sliderMin, sliderMax, sliderStep, sliderFormatter, variableTable.
---
--- @return table initializer The layout initializer object for the combined element.
--- @return table settingCheckbox The registered setting object for the checkbox.
--- @return table settingSlider The registered setting object for the slider.
function ArcaneWizardLibrary.Settings:AddCheckboxSliderCombo(category, layout, config)
    local settingCheckbox = Settings.RegisterAddOnSetting(category, config.checkboxSettingKey, config.checkboxVarName, config.variableTable, Settings.VarType.Boolean, config.checkboxName, config.checkboxDefault or false)
    local settingSlider = Settings.RegisterAddOnSetting(category, config.sliderSettingKey, config.sliderVariableName, config.variableTable, Settings.VarType.Number, config.sliderName, config.sliderDefault or 1)
    local optionsSlider = Settings.CreateSliderOptions(config.sliderMin or 1, config.sliderMax or 10, config.sliderStep or 1)

    if config.sliderFormatter then
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, config.sliderFormatter)
    end

    local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, config.checkboxName, config.checkboxTooltip, settingSlider, optionsSlider, config.sliderName, config.sliderTooltip)
    initializer.GetSetting = function() return settingCheckbox end

    layout:AddInitializer(initializer)

    return initializer, settingCheckbox, settingSlider
end


--- Creates a Dropdown menu in the WoW Settings.
---
--- @param category table The settings category object.
--- @param config table Configuration table. Expected keys: settingKey, variableName, variableTable, name, tooltip, default, options.
---                     'options' should be a table containing subtables: { { value = 1, label = "One" }, { value = 2, label = "Two" } }
---
--- @return table dropdown The layout initializer object for the dropdown.
--- @return table setting The registered setting object.
function ArcaneWizardLibrary.Settings:AddDropdown(category, config)
    local varType = type(config.default) == "string" and Settings.VarType.String or Settings.VarType.Number
    local setting = Settings.RegisterAddOnSetting(category, config.settingKey, config.variableName, config.variableTable, varType, config.name, config.default)

    local function GetOptions()
        local container = Settings.CreateControlTextContainer()
        if config.options then
            for _, opt in ipairs(config.options) do
                container:Add(opt.value, opt.label)
            end
        end
        return container:GetData()
    end

    local dropdown = Settings.CreateDropdown(category, setting, GetOptions, config.tooltip)

    if config.parentInit and config.parentCondition then
        dropdown:SetParentInitializer(config.parentInit, config.parentCondition)
    end

    if config.onClick then
        setting:SetValueChangedCallback(config.onClick)
    end

    return dropdown, setting
end
