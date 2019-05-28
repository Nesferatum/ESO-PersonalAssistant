-- Local instances of Global tables --
local PA = PersonalAssistant
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local function showDebugInformationWindow()
    local window = PADebugWindow

    local debugBgControl = window:GetNamedChild("DebugBg")
    local debugEditControl = debugBgControl:GetNamedChild("DebugEdit")

    function debugEditControl:InsertLine(text)
        debugEditControl:InsertText("\n"..text)
    end
    function debugEditControl:InsertBreak()
        debugEditControl:InsertText("\n------------------------------------------------")
    end

    -- First reset
    debugEditControl:SetText("")

    -- Add header
    debugEditControl:InsertText("PersonalAssistant Debug Information - "..os.date())
    debugEditControl:InsertBreak()

    -- Active profile
    debugEditControl:InsertLine("ActiveProfile="..tostring(PA.activeProfile))
    debugEditControl:InsertLine("HasActiveProfile="..tostring(PAHF.hasActiveProfile()))

    -- Enabled addons
    debugEditControl:InsertLine("PA.Banking="..tostring(PA.Banking ~= nil))
    debugEditControl:InsertLine("PA.Junk="..tostring(PA.Junk ~= nil))
    debugEditControl:InsertLine("PA.Loot="..tostring(PA.Loot ~= nil))
    debugEditControl:InsertLine("PA.Mail="..tostring(PA.Mail ~= nil))
    debugEditControl:InsertLine("PA.Repair="..tostring(PA.Repair ~= nil))
    debugEditControl:InsertBreak()

    -- SavedVars
    debugEditControl:InsertLine(table.concat({"PABanking.SavedVars=", tostring(PA.Banking and istable(PA.Banking.SavedVars)), " - ", PA.SavedVars.Banking and PA.SavedVars.Banking.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PAJunk.SavedVars=", tostring(PA.Junk and istable(PA.Junk.SavedVars)), " - ", PA.SavedVars.Junk and PA.SavedVars.Junk.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PALoot.SavedVars=", tostring(PA.Loot and istable(PA.Loot.SavedVars)), " - ", PA.SavedVars.Loot and PA.SavedVars.Loot.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PAMail.SavedVars=", tostring(PA.Mail and istable(PA.Mail.SavedVars)), " - ", PA.SavedVars.Mail and PA.SavedVars.Mail.savedVarsVersion}))
    debugEditControl:InsertLine(table.concat({"PARepair.SavedVars=", tostring(PA.Repair and istable(PA.Repair.SavedVars)), " - ", PA.SavedVars.Repair and PA.SavedVars.Repair.savedVarsVersion}))
    debugEditControl:InsertBreak()

    -- Registered Events
    local registeredEventsSet = PA.EventManager.getAllReventsInSet()
    for key, value in pairs(registeredEventsSet) do
        debugEditControl:InsertLine(key.."="..tostring(value))
    end
    debugEditControl:InsertBreak()

    -- PARepair
    local PARepairSavedVars = PA.Repair.SavedVars
    debugEditControl:InsertLine("autoRepairEnabled="..tostring(PARepairSavedVars.autoRepairEnabled))
    debugEditControl:InsertLine(table.concat({"RepairEquipped.repairWithGold=", tostring(PARepairSavedVars.RepairEquipped.repairWithGold), " - ", tostring(PARepairSavedVars.RepairEquipped.repairWithGoldDurabilityThreshold)}))
    debugEditControl:InsertLine(table.concat({"RepairInventory.repairWithGold=", tostring(PARepairSavedVars.RepairInventory.repairWithGold), " - ", tostring(PARepairSavedVars.RepairInventory.repairWithGoldDurabilityThreshold)}))
    local PARMenuFunctions = PA.MenuFunctions.PARepair
    debugEditControl:InsertLine("PARMenuFunctions="..tostring(istable(PARMenuFunctions)))
    debugEditControl:InsertLine("getAutoRepairEnabledSetting="..tostring(PARMenuFunctions.getAutoRepairEnabledSetting()))
    debugEditControl:InsertLine("getRepairWithGoldSetting="..tostring(PARMenuFunctions.getRepairWithGoldSetting()))
    debugEditControl:InsertLine("getRepairInventoryWithGoldSetting="..tostring(PARMenuFunctions.getRepairInventoryWithGoldSetting()))
    debugEditControl:InsertBreak()

    local PAJMenuFunctions = PA.MenuFunctions.PAJunk
    debugEditControl:InsertLine("PAJMenuFunctions="..tostring(istable(PAJMenuFunctions)))
    debugEditControl:InsertLine("getAutoSellJunkSetting="..tostring(PAJMenuFunctions and PAJMenuFunctions.getAutoSellJunkSetting()))

    -- show the window
    window:SetHidden(false)
end

-- ---------------------------------------------------------------------------------------------------------------------

local debugOutputEditControl

local function printToDebugOutputWindow(text)
    debugOutputEditControl:InsertLine(GetTimeString().." | "..text)
end

local function showDebugOutputWindow()
    local window = PADebugOutputWindow

    local debugBgControl = window:GetNamedChild("DebugBg")
    if not debugOutputEditControl then debugOutputEditControl = debugBgControl:GetNamedChild("DebugEdit") end

    function debugOutputEditControl:InsertLine(text)
        debugOutputEditControl:InsertText("\n"..text)
    end
    function debugOutputEditControl:InsertBreak()
        debugOutputEditControl:InsertText("\n---------------------------------------------------------------------------")
    end

    -- First reset and header
    debugOutputEditControl:SetText("PersonalAssistant Debug Output - "..os.date())
    debugOutputEditControl:InsertBreak()

    window:SetHidden(false)
end

local function hideDebugOutputWindow()
    local window = PADebugOutputWindow
    window:SetHidden(true)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.DebugWindow = {
    printToDebugOutputWindow = printToDebugOutputWindow,
    showDebugInformationWindow = showDebugInformationWindow,
    showDebugOutputWindow = showDebugOutputWindow,
    hideDebugOutputWindow = hideDebugOutputWindow
}