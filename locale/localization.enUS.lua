local _, LIB = ...

LIB.Localization = setmetatable({},{__index=function(self,key)
        geterrorhandler()("Libraries (WoW Addon Development) (Debug): Missing entry for '" .. tostring(key) .. "'")
        return key
    end})

local L = LIB.Localization

-- Dialog

L["dialog.link.text"] = "To copy the link press CTRL + C."
