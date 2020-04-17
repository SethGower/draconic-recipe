local p = require("pl.pretty")
local json = require("json")

local file = io.open("./recipes.json", "r")
io.input(file)

local buff = io.read("*all")

local function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end




local output = json.decode(buff)
print("JSON Output:")
p.dump(output)
print("=======================================")

local inv = {}
do
    local item = {}
    item.name = "dragonHeart"
    item.size = 1
    table.insert(inv, item)
    item = {}
    item.name = "draconicCore"
    item.size = 6
    table.insert(inv, item)
    item = {}
    item.name = "draconiumBlock"
    item.size = 4
    table.insert(inv, item)
end

print("Items in Inventory:")
for slot, stack in ipairs(inv) do
    print(string.format("Slot %d: %s x %d", slot, stack.name, stack.size))
end
print(string.format("Num Items in Inventory: %d", tablelength(inv)))
print("=======================================")

local total_ingredients
local result = nil
for key,val in pairs(output) do
    total_ingredients = {}
    for key1,val1 in pairs(val.infusers) do
        total_ingredients[key1] = val1
    end
    for key1, val1 in pairs(val.core) do
        total_ingredients[key1] = val1
    end

    if tablelength(total_ingredients) == tablelength(inv) then
        local found = true
        for _,val_inv in ipairs(inv) do
            local found1 = false
            for item, count in pairs(total_ingredients) do
                if item == val_inv.name then
                    found1 = true
                    break
                end
            end
            found = found1
        end
        if found then
            result = key
            break
        end
    end
end

print(string.format("Result is: %s", result))
