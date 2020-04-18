local robot = require("robot")
local nav = require("component").navigation
local sides = require("sides")
 
 
local function goToCoords(x,y,z)
  local c_x,c_y,c_z = nav.getPosition()
  local vec = {}
  vec.x = x-c_x
  vec.y = y - c_y
  vec.z = z - c_z
  for key,coord in pairs(vec) do
    target_dir = nil
    if key == "x" then
      target_dir = sides.posx
    elseif key == "z" then
      target_dir = sides.posz
    end
    if not (target_dir == nil) then
      while not (nav.getFacing() == target_dir) do
        robot.turnRight()
      end
    end
    if coord > 0 then
      for i=1,coord do
        while not robot.forward() do
          print("move failed, retrying")
        end
      end
    elseif coord < 0 then
      for i=1,(coord * -1) do
        while not robot.back() do
          print("move failed, retrying")
        end
      end
    end
  end  
end
 
local function goToWaypoint(label)
  local points = nav.findWaypoints(100)
  local target = nil
  for _,way in ipairs(points) do
    if way.label == label then target = way end
  end
  if target == nil then return nil end
 
  local x,y,z = nav.getPosition()
  local pos = target.position
  goToCoords(x + pos[1],y, z + pos[3])
  return pos[1], pos[2], pos[3]
end
 
goToWaypoint("north_infusers")
goToWaypoint("west_infusers")
goToWaypoint("home")
