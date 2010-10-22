local keaFrame = CreateFrame("Frame")
local barked = 0

if keaCfg == nil or tonumber(keaCfg) > 100 or tonumber(keaCfg) <= 0 then
  keaCfg = 25
end

local unitHealth = function(unit)
  if unit == "target" then
    local health, max = UnitHealth("target"), UnitHealthMax("target")
    if (health < (max / 100) * keaCfg) and (barked == 0) then
      RaidNotice_AddMessage(RaidBossEmoteFrame, "|cffff0000"..UnitName("target").. " is at or below "..keaCfg.."% health", ChatTypeInfo["RAID_WARNING"])
      barked = 1
    end
  end
end

keaFrame:RegisterEvent("UNIT_HEALTH")
keaFrame:RegisterEvent("PLAYER_TARGET_CHANGED")

keaFrame:SetScript("OnEvent", function(self, event, ...)
  if event == "UNIT_HEALTH" then
    unitHealth(...)
  elseif event == "PLAYER_TARGET_CHANGED" then
    barked = 0
  end
end)

SLASH_KEA1 = "/kea"

SlashCmdList["KEA"] = function(str)
  num = tonumber(str)
  if num == nil or num == 0 or str == "" then
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00Kill 'em All: |rCurrently at ".. keaCfg)    
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00Kill 'em All: |r/kea (above||below)<healthpercent>")
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000Leave the rest to Odin to sort out!|r")
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00Kill 'em All: |r now set to "..num.."%")
    keaCfg = num
  end
end