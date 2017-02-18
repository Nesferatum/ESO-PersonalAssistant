--
-- Created by IntelliJ IDEA.
-- User: Klingo
-- Date: 13.02.2017
-- Time: 22:40
--

if not PAMenu_Functions then
    PAMenu_Functions = {
        func = {
            PALoot = {},
        },
        getFunc = {
            PAGeneral = {},
            PABanking = {},
            PALoot = {},
        },
        setFunc = {
            PAGeneral = {},
            PABanking = {},
            PALoot = {},
        },
        disabled = {
            PAGeneral = {},
            PABanking = {},
            PALoot = {},
        },
    }
end

-- =====================================================================================================================
-- =====================================================================================================================

-- PAGeneral

--------------------------------------------------------------------------
-- PABanking   activeProfile
---------------------------------
function PAMenu_Functions.getFunc.PAGeneral.activeProfile()
    local activeProfile = PA.savedVars.Profile.activeProfile
    if (activeProfile == nil) then
        return PAG_NO_PROFILE_SELECTED_ID
    else
        return activeProfile
    end
end

function PAMenu_Functions.setFunc.PAGeneral.activeProfile(profileNo)
    if (profileNo ~= nil and profileNo ~= PAG_NO_PROFILE_SELECTED_ID) then
        -- get the previously active prefoile first
        local prevProfile = PA.savedVars.Profile.activeProfile
        -- then save the new one
        PA.savedVars.Profile.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if (prevProfile == nil) then
            MenuHelper.reloadProfileList()
        end
    end
end

function PAMenu_Functions.disabled.PAGeneral.noProfileSelected()
    local activeProfile = PA.savedVars.Profile.activeProfile
    return (activeProfile == nil)
end

--------------------------------------------------------------------------
-- PABanking   activeProfileRename
---------------------------------
function PAMenu_Functions.getFunc.PAGeneral.activeProfileRename()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.General[PA.savedVars.Profile.activeProfile].name
end

function PAMenu_Functions.setFunc.PAGeneral.activeProfileRename(profileName)
    if (profileName ~= nil and profileName ~= "") then
        PA.savedVars.General[PA.savedVars.Profile.activeProfile].name = profileName
        MenuHelper.reloadProfileList()
    end
end

--------------------------------------------------------------------------
-- PABanking   welcomeMessage
---------------------------------
function PAMenu_Functions.getFunc.PAGeneral.welcomeMessage()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.General[PA.savedVars.Profile.activeProfile].welcome
end

function PAMenu_Functions.setFunc.PAGeneral.welcomeMessage(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.General[PA.savedVars.Profile.activeProfile].welcome = value
end

-- =====================================================================================================================
-- =====================================================================================================================

 -- PARepair

-- =====================================================================================================================
-- =====================================================================================================================


--------------------------------------------------------------------------
-- PABanking   enable
---------------------------------
function PAMenu_Functions.getFunc.PABanking.enabled()
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PABanking.enabled(value)
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled = value
end

--------------------------------------------------------------------------
-- PABanking   enabledGold
---------------------------------
function PAMenu_Functions.getFunc.PABanking.enabledGold()
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold
end

function PAMenu_Functions.setFunc.PABanking.enabledGold(value)
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold = value
end

function PAMenu_Functions.disabled.PABanking.enabledGold()
    return not PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PABanking   goldDepositInterval
---------------------------------
function PAMenu_Functions.getFunc.PABanking.goldDepositInterval()
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldDepositInterval
end

function PAMenu_Functions.setFunc.PABanking.goldDepositInterval(value)
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldDepositInterval = tonumber(value)
end

function PAMenu_Functions.disabled.PABanking.goldDepositInterval()
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   goldDepositPercentage
---------------------------------
function PAMenu_Functions.getFunc.PABanking.goldDepositPercentage()
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldDepositPercentage
end

function PAMenu_Functions.setFunc.PABanking.goldDepositPercentage(value)
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldDepositPercentage = value
end

function PAMenu_Functions.disabled.PABanking.goldDepositPercentage()
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   goldTransactionStep
---------------------------------
function PAMenu_Functions.getFunc.PABanking.goldTransactionStep()
   return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldTransactionStep
end

function PAMenu_Functions.setFunc.PABanking.goldTransactionStep(value)
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldTransactionStep = value
end

function PAMenu_Functions.disabled.PABanking.goldTransactionStep()
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   goldMinToKeep
---------------------------------
function PAMenu_Functions.getFunc.PABanking.goldMinToKeep()
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldMinToKeep
    -- return tostring(PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldMinToKeep)
end

function PAMenu_Functions.setFunc.PABanking.goldMinToKeep(value)
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].goldMinToKeep = tonumber(value)
end

function PAMenu_Functions.disabled.PABanking.goldMinToKeep()
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   withdrawToMinGold
---------------------------------
function PAMenu_Functions.getFunc.PABanking.withdrawToMinGold()
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].withdrawToMinGold
end

function PAMenu_Functions.setFunc.PABanking.withdrawToMinGold(value)
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].withdrawToMinGold = value
end

function PAMenu_Functions.disabled.PABanking.withdrawToMinGold()
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledGold)
end

--------------------------------------------------------------------------
-- PABanking   enabledItems
---------------------------------
function PAMenu_Functions.getFunc.PABanking.enabledItems()
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems
end

function PAMenu_Functions.setFunc.PABanking.enabledItems(value)
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems = value
end

function PAMenu_Functions.disabled.PABanking.enabledItems()
    return not PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PABanking   depositTimerInterval
---------------------------------
function PAMenu_Functions.getFunc.PABanking.depositTimerInterval()
    return PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].depositTimerInterval
end

function PAMenu_Functions.setFunc.PABanking.depositTimerInterval(value)
    PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].depositTimerInterval = value
end

function PAMenu_Functions.disabled.PABanking.depositTimerInterval()
    return not (PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Banking[PA.savedVars.Profile.activeProfile].enabledItems)
end


-- =====================================================================================================================
-- =====================================================================================================================


--------------------------------------------------------------------------
-- PALoot   enable
---------------------------------
function PAMenu_Functions.getFunc.PALoot.enabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled
end

function PAMenu_Functions.setFunc.PALoot.enabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled = value
end

--------------------------------------------------------------------------
-- PALoot   lootGoldEnabled
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootGoldEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldEnabled
end

function PAMenu_Functions.setFunc.PALoot.lootGoldEnabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldEnabled = value
end

function PAMenu_Functions.disabled.PALoot.lootGoldEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootGoldChatMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootGoldChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldChatMode
end

function PAMenu_Functions.setFunc.PALoot.lootGoldChatMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldChatMode = value
end

function PAMenu_Functions.disabled.PALoot.lootGoldChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootGoldEnabled)
end

--------------------------------------------------------------------------
-- PALoot   lootItemsEnabled
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootItemsEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled
end

function PAMenu_Functions.setFunc.PALoot.lootItemsEnabled(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled = value
end

function PAMenu_Functions.disabled.PALoot.lootItemsEnabled()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootItemsChatMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootItemsChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsChatMode
end

function PAMenu_Functions.setFunc.PALoot.lootItemsChatMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsChatMode = value
end

function PAMenu_Functions.disabled.PALoot.lootItemsChatMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu harvestableBaitLootMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.harvestableBaitLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].harvestableBaitLootMode
end

function PAMenu_Functions.setFunc.PALoot.harvestableBaitLootMode(value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].harvestableBaitLootMode = value
end

function PAMenu_Functions.disabled.PALoot.harvestableBaitLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu harvestableItemTypesLootMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.harvestableItemTypesLootMode(itemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].HarvestableItemTypes[itemType]
end

function PAMenu_Functions.setFunc.PALoot.harvestableItemTypesLootMode(itemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].HarvestableItemTypes[itemType] = value
end

function PAMenu_Functions.disabled.PALoot.harvestableItemTypesLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu autoLootAllHarvestableButton
---------------------------------
function PAMenu_Functions.func.PALoot.autoLootAllHarvestableButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PALHarvestableItemTypes) do
        PA.savedVars.Loot[activeProfile].HarvestableItemTypes[itemType] = PAC_ITEMTYPE_LOOT
    end
end

function PAMenu_Functions.disabled.PALoot.autoLootAllHarvestableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu ignoreAllHarvestableButton
---------------------------------
function PAMenu_Functions.func.PALoot.ignoreAllHarvestableButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PALHarvestableItemTypes) do
        PA.savedVars.Loot[activeProfile].HarvestableItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

function PAMenu_Functions.disabled.PALoot.ignoreAllHarvestableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu lootableItemTypesLootMode
---------------------------------
function PAMenu_Functions.getFunc.PALoot.lootableItemTypesLootMode(itemType)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    return PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].LootableItemTypes[itemType]
end

function PAMenu_Functions.setFunc.PALoot.lootableItemTypesLootMode(itemType, value)
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return end
    PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].LootableItemTypes[itemType] = value
end

function PAMenu_Functions.disabled.PALoot.lootableItemTypesLootMode()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu autoLootAllLootableButton
---------------------------------
function PAMenu_Functions.func.PALoot.autoLootAllLootableButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PALLootableItemTypes) do
        PA.savedVars.Loot[activeProfile].LootableItemTypes[itemType] = PAC_ITEMTYPE_LOOT
    end
end

function PAMenu_Functions.disabled.PALoot.autoLootAllLootableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu ignoreAllLootableButton
---------------------------------
function PAMenu_Functions.func.PALoot.ignoreAllLootableButton()
    local activeProfile = PA.savedVars.Profile.activeProfile
    for _, itemType in pairs(PALLootableItemTypes) do
        PA.savedVars.Loot[activeProfile].LootableItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

function PAMenu_Functions.disabled.PALoot.ignoreAllLootableButton()
    if (PAMenu_Functions.disabled.PAGeneral.noProfileSelected()) then return true end
    return not (PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].enabled and PA.savedVars.Loot[PA.savedVars.Profile.activeProfile].lootItemsEnabled)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PAJunk



-- =====================================================================================================================
-- =====================================================================================================================