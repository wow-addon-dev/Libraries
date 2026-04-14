local _, LIB = ...

LIB.Localization = setmetatable({},{__index=function(self,key)
        geterrorhandler()("Libraries (WoW Addon Development) (Debug): Missing entry for '" .. tostring(key) .. "'")
        return key
    end})

local L = LIB.Localization

-- Dialog

L["dialog.copy-address.text"] = "To copy the link press CTRL + C."
L["dialog.delete-data.text"] = "Do you really want to delete all addon data?\n|cnNORMAL_FONT_COLOR:Warning:|r The game interface will be automatically reloaded!"
