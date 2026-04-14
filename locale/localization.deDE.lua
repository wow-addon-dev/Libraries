local _, LIB = ...

if GetLocale() ~= "deDE" then return end

local L = LIB.Localization

-- Dialog

L["dialog.copy-address.text"] = "Um den Link zu kopieren drücke STRG + C."
L["dialog.delete-data.text"] = "Sollen alle Addon Daten wirklich gelöscht werden?\n|cnNORMAL_FONT_COLOR:Achtung:|r Es erfolgt ein automatischer Reload der Spieloberfläche!"
