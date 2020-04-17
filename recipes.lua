#!/usr/bin/lua
local json = require("json")

local file = io.open("./recipes.json", "r")
io.input(file)

local buff = io.read("*all")

local function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

local function matchrecipe(recipes, inventory)
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
                break
            end
        end
    end
    return result
end




local output = json.decode(buff)
print("=======================================")

local inv = {}
do
    local item = {}
    item.name = "dragonHeart"
    item.size = 2
    table.insert(inv, item)
    item = {}
    item.name = "draconicCore"
    item.size = 122
    table.insert(inv, item)
    item = {}
    item.name = "draconiumBlock"
    item.size = 8
    table.insert(inv, item)
end

print("Items in Inventory:")
for slot, stack in ipairs(inv) do
    print(string.format("Slot %d: %s x %d", slot, stack.name, stack.size))
end
print(string.format("Num Items in Inventory: %d", tablelength(inv)))
print("=======================================")

local result = matchrecipe(output, inv)

print(string.format("Inventory Contents can make %s * %d", result.name, result.size))
