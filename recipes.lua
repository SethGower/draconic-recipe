local p = require("pl.pretty")
local json = require("json")

local file = io.open("./recipes.json", "r")
io.input(file)

local buff = io.read("*all")

local inv = {}
local item = {}
item.name = "awakenedIngot"
item.size = 5
table.insert(inv, item)
item = {}
item.name = "draconicCore"
item.size = 4
table.insert(inv, item)


print("Items in Inventory:")
for slot, stack in ipairs(inv) do
    print(string.format("Slot %d: %s x %d", slot, stack.name, stack.size))
end

local output = json.decode(buff)
local common = {}
local num_value = 0
for key,value in pairs(output) do
    print(string.format("New Recipe: %s", key))
    for ingred, amt in pairs(value) do
        num_value = num_value + 1
        print(string.format("%s * %d",ingred, amt))
        for _,stack in ipairs(inv) do
            if stack.name == ingred then
                table.insert(common, stack.name)
                break
            end
        end
    end
    local found
    if #common == num_value then
        found = true
        -- for _,ingredient in ipairs(common) do
        --     for ingred,_ in pairs(value) do
        --         print(ingred)
        --         found = ingred == ingredient
        --         if found then
        --             print(string.format("%s == %s: true", ingred, ingredient))
        --         else
        --             print(string.format("%s == %s: false", ingred, ingredient))
        --         end
        --     end
        -- end
    else
        found = false
    end
    print(found)
end



