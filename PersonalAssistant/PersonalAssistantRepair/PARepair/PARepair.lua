-- Local instances of Global tables --
local PA = PersonalAssistant
local PAR = PA.Repair
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _repairItemList

-- ---------------------------------------------------------------------------------------------------------------------

-- repair all items that are below the given threshold for the bag
local function RepairItems(bagId, threshold)
    -- TODO: add another SavedVars check?
    local bagCache = SHARED_INVENTORY:GetOrCreateBagCache(bagId)

    if bagCache then
        local repairCost = 0
        local repairedItemCount = 0
        local notRepairedItemCount = 0
        local notRepairedItemsCost = 0
        local currentMoney = GetCurrentMoney()
        _repairItemList = {}

        local PARepairSavedVars = PAR.SavedVars -- TODO: remove if no saved vars check added

        -- loop through all items of the corresponding bagId
        for slotIndex, data in pairs(bagCache) do
            -- check first if the item has durability (and therefore is repairable)
            if DoesItemHaveDurability(bagId, slotIndex) then
                -- then compare it with the threshold
                local itemCondition = GetItemCondition(bagId, slotIndex)
                if itemCondition <= threshold then
                    local stackSize = GetSlotStackSize(bagId, slotIndex)
                    -- get the repair cost for that item and repair if possible
                    local itemRepairCost = GetItemRepairCost(bagId, slotIndex)
                    if itemRepairCost > 0 then
                        if itemRepairCost > currentMoney then
                            -- even though not enough money available, continue as maybe a cheaper item still can be repaired
                            notRepairedItemCount = notRepairedItemCount + stackSize
                            notRepairedItemsCost = notRepairedItemsCost + itemRepairCost
                            -- add the item to the list as NOT repaired
                            table.insert(_repairItemList, {
                                itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS),
                                repairCost = itemRepairCost,
                                itemCondition = itemCondition,
                                repaired = false
                            })
                        else
                            -- sum up the total repair costs
                            repairCost = repairCost + itemRepairCost;
                            repairedItemCount = repairedItemCount + stackSize
                            RepairItem(bagId, slotIndex)
                            -- currentMoney has to be manually calculated, as the "GetCurrentMoney()"
                            -- does not yet reflect the just made repairs
                            currentMoney = currentMoney - itemRepairCost
                            -- add the item to the list as repaired
                            table.insert(_repairItemList, {
                                itemLink = GetItemLink(bagId, slotIndex, LINK_STYLE_BRACKETS),
                                repairCost = itemRepairCost,
                                itemCondition = itemCondition,
                                repaired = true
                            })
                        end
                    end
                end
            end
        end

        -- show output to chat
        if notRepairedItemCount > 0 then
            local missingGold = notRepairedItemsCost - currentMoney
            PAR.println(SI_PA_CHAT_REPAIR_SUMMARY_PARTIAL, repairCost, missingGold)
        elseif repairedItemCount > 0 then
            PAR.println(SI_PA_CHAT_REPAIR_SUMMARY_FULL, repairCost)
        end
    end
end


local function OnShopOpen()
    if PAHF.hasActiveProfile() then
        -- check if store can repair
        if CanStoreRepair() then
            local PARepairSavedVars = PAR.SavedVars
            -- check if addon is enabled
            if PARepairSavedVars.autoRepairEnabled then
                -- early check if there is something to repair
                if GetRepairAllCost() > 0 then
                    -- check if equipped items shall be repaired
                    if PARepairSavedVars.RepairEquipped.repairWithGold then
                        RepairItems(BAG_WORN, PARepairSavedVars.RepairEquipped.repairWithGoldDurabilityThreshold)
                    end
                    -- check if backpack items shall be repaired
                    if PARepairSavedVars.RepairInventory.repairWithGold then
                        RepairItems(BAG_BACKPACK, PARepairSavedVars.RepairInventory.repairWithGoldDurabilityThreshold)
                    end
                end
            end
        end
    end
end

-- Export
PA.Repair = PA.Repair or {}
PA.Repair.OnShopOpen = OnShopOpen