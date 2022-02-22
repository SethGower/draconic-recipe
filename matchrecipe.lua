local function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function matchrecipe(recipes, inv)
    local inventory = {}
    for slot, item in ipairs(inv) do
      if not (item.name == "Empty") then
      table.insert(inventory, item) 
      end
    end
    local total_ingredients
    local result = {}
    for key,val in pairs(recipes) do
        total_ingredients = {}
        for key1,val1 in pairs(val.infusers) do
            total_ingredients[key1] = val1
        end
        for key1, val1 in pairs(val.core) do
            total_ingredients[key1] = val1
        end
    
        if tablelength(total_ingredients) == tablelength(inventory) then
            local found = true
            local quantity = 10000
            for _,val_inventory in ipairs(inventory) do
                local found1 = false
                for item, count in pairs(total_ingredients) do
                    if item == val_inventory.name and count <= val_inventory.size then
                        local quant = val_inventory.size // count
                        if quant < quantity then quantity = quant end
                        found1 = true
                        break
                    end
                end
                found = found1
            end
            if found then
                result.name = key
                result.size = quantity
                result.recipe = val
                break
            end
        end
    end
    return result
end


local retVal = {}
retVal.matchrecipe = matchrecipe
return retVal
