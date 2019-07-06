local PAC = PersonalAssistant.Constants
local PAIStrings = {
    -- =================================================================================================================
    -- Language specific texts that need to be translated --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_DESCRIPTION = "PAIntegration can ...", -- TODO

    -- Dolgubon's Lazy Writ Crafter --
    SI_PA_MENU_INTEGRATION_LWC_HEADER = "Dolgubon's Lazy Writ Crafter",
    SI_PA_MENU_INTEGRATION_LWC_PRECONDITION = "Note: In order to make use of below setting, you must enable PABanking first",

    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY = "Compatibility with Dolgubon's Lazy Writ Crafter",
    SI_PA_MENU_INTEGRATION_LWC_COMPATIBILITY_T = "When you have active Writ Crafting quests and 'Withdraw writ items' is enabled in Dolgubon's Lazy Writ Crafter, then for these items the 'Deposit to Bank' setting is ignored. This is to avoid having withdrawn items immediately re-deposited",

    -- FCO ItemSaver --
    SI_PA_MENU_INTEGRATION_FCOIS_HEADER = "FCO Item Saver",
    SI_PA_MENU_INTEGRATION_FCOIS_PRECONDITION = "Note: In order to make use of below settings, you must enable PABanking or PAJunk first (depending on the setting)",

    SI_PA_MENU_INTEGRATION_FCOIS_SELL_AUTOSELL_MARKED = "Auto-Sell marked items at Merchants/Fences?",


    -- =================================================================================================================
    -- == CHAT OUTPUTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration --


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --
    SI_PA_MENU_INTEGRATION_PAJ_REQUIRED = "Requires PAJunk to be enabled",

}

for key, value in pairs(PAIStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end


local PAIGenericStrings = {
    -- =================================================================================================================
    -- Language independent texts (do not need to be translated/copied to other languages --

    -- =================================================================================================================
    -- == MENU/PANEL TEXTS == --
    -- -----------------------------------------------------------------------------------------------------------------
    -- PAIntegration Menu --


    -- =================================================================================================================
    -- == OTHER STRINGS FOR MENU == --
    -- -----------------------------------------------------------------------------------------------------------------
}

for key, value in pairs(PAIGenericStrings) do
    ZO_CreateStringId(key, value)
    SafeAddVersion(key, 1)
end