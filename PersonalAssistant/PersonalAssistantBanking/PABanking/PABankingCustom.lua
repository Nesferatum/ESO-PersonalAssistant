-- Local instances of Global tables --
local PA = PersonalAssistant
local PAB = PA.Banking
local PAC = PA.Constants
local PAHF = PA.HelperFunctions
local PAEM = PA.EventManager

-- ---------------------------------------------------------------------------------------------------------------------

local function depositOrWithdrawCustomItems()

    PAB.debugln("PA.Banking.depositOrWithdrawCustomItems")

    if PAB.SavedVars.Custom.customItemsEnabled then

        -- check if bankTransfer is already blocked
        if PAB.isBankTransferBlocked then return end
        PAB.isBankTransferBlocked = true

        -- prepare and fill the table with all custom items that needs to be transferred
        local customItems = {}
        local itemIdTable = PAB.SavedVars.Custom.ItemIds
        for itemId, moveConfig in pairs(itemIdTable) do
            local operator = moveConfig.operator
            d("operator ("..tostring(operator)..") ~= PAC.OPERATOR.NONE ("..tostring(PAC.OPERATOR.NONE)..")")
            if operator ~= PAC.OPERATOR.NONE then
                d("add entry")
                customItems[itemId] = {
                    operator = operator,
                    targetBagStack = moveConfig.bagAmount
                }
            else
                d("skip entry")
            end
        end

        -- then get the matching data from the backpack and bank
        local itemIdComparator = PAHF.getItemIdComparator(customItems)
        local backpackBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, BAG_BACKPACK)
        local bankBagCache = SHARED_INVENTORY:GenerateFullSlotData(itemIdComparator, BAG_BANK, BAG_SUBSCRIBER_BANK)

        PAB.debugln("#backpackBagCache = "..tostring(#backpackBagCache))
        PAB.debugln("#bankBagCache = "..tostring(#bankBagCache))

        -- trigger the individual itemTransactions
        PAB.doIndividualItemTransactions(customItems, backpackBagCache, bankBagCache)
    else
        -- else, continue with the next function in queue
        PAEM.executeNextFunctionInQueue(PAB.AddonName)
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.depositOrWithdrawCustomItems = depositOrWithdrawCustomItems