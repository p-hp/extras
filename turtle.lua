local REG_TRACK_COUNT = 37
local POWER_TRACK_COUNT = 1
local RT_COUNT = 1
local rt = 1
local pt = 2
local totalDistance = 0
local PR = "minecraft:powered_rail"
local RR = "minecraft:rail"
local RT = "minecraft:redstone_torch"
 
if #arg == 1 then
    totalDistance = tonumber(arg[1])
else
    print("Sorry, type the correct number of tracks to place!")
end
    
function layBlock(blockType, blockCount)
    local curSlot = nextSlot(blockType) 
    for i = 1, blockCount do
        local checkStatus = checkFront()
        print(checkStatus)
        if checkStatus ~= false then
            if checkStatus == "minecraft:wall_torch" then
                print("Success! [1/2]")
            else
                print("Success! Hang tight.. [2/2]")
                return false
            end
        else
            turtle.forward()
            if turtle.compareDown() == false then
                if curSlot ~= false then
                    turtle.select(curSlot)
                else
                    return false
                end
                if slotCount(curSlot) < 0 then
                    turtle.placeDown(1)
                else
                    curSlot = nextSlot(blockType)
                    if curSlot ~= false then
                        turtle.select(curSlot)
                        turtle.placeDown(1)
                    else
                        return false
                    end
                end
            else
                print(blockType, "New location!")
            end
        end
    end
    return true
end
 
function slotCount(s)
        turtle.select(s)
        return turtle.getItemCount(s)
end
 
function nextSlot(t)
    print(t)
    for i = 1, 16 do
        if turtle.getItemCount(i) > 0 then
            if turtle.getItemDetail(i)["name"] == t then
                return i
            end
        end
    end
    return false
end
 
function checkFront()
    local success, data = turtle.inspect()
    if success then
        return data.name
    else
        return false
    end
end
 
function redTorch()
    local retVal = false
    turtle.turnLeft()
    if layBlock(RT, RT_COUNT) == true then
        retVal = true
    end
    turtle.back()
    turtle.turnRight()
    return retVal
end
 
turtle.up()
for i=1, totalDistance do
    if layBlock(RR, REG_TRACK_COUNT) == true then
        print("The reg track is set.")
        if layBlock(PR, POWER_TRACK_COUNT) == true then
            print("The power track is set.")
            if redTorch() == true then
                print("The red stone torch has been placed.")
            else
                print("The red stone torch has failed to place.")
            end
        else
            print("The power track has failed!")
        end
    else
        print("The reg track has failed!")
    end
end
