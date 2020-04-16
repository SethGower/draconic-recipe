local json = require("json")
local p = require("pl.pretty")


local file = io.open("./recipes.json", "r")
io.input(file)

local buff = io.read("*all")

local output = json.decode(buff)
p.dump(output)
print("fuck")

for key,value in pairs(output.recipes) do 
    print("New Recipe:")
    print("Item","Quantity")
    for key1,value1 in pairs(output[value]) do
        print(key1,value1)
    end
end


