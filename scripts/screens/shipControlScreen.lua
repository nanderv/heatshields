--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 12:54
-- To change this template use File | Settings | File Templates.
--

-- Left side: draw ship

-- right side: draw context menu based on last click.
local RX, RY, RS = 20, 20, 64;

local drawUI = {}
drawUI.boolean = function(k, name, enabled)
    local str = "false"
    if enabled then str = "true" end
    love.graphics.print(name ..":" .. str, 500, 500+30*k )
end

local clickUI = {}

clickUI.boolean = function(k, property, obj)
    obj[property] = not obj[property]
end

local getControls = {}

getControls.engine = { {name = "enable", type="boolean", property="enabled"} }
getControls.fuelTank = { {name = "enable", type="boolean", property="enabled"}, {name="drawFuel", type="boolean", property="drawFuel"} }

local funcs = {}
local selected
funcs.drawLeft = function()
    scripts.systems.draw_ship.drawShip(SHIPNUMBER, RX, RY, RS)
end

funcs.drawRight = function()
    if selected then
        love.graphics.print("Selected" .. selected.componentType, 500, 500)
        for k, v in ipairs(getControls[selected.componentType]) do
            drawUI[v.type](k, v.name, selected[v.property])
        end

    else
        love.graphics.print("Nothing selected", 500, 500)
    end
end

funcs.onMouseClick = function(x, y, click)
    print(x,y, click)
    -- Select ship part
    local xx = math.floor((x - RX) / RS)
    local yy = math.floor((y - RY) / RS)
    print (xx, yy)
    for k,v in pairs(F.ship_component) do
        if v.shipNumber == SHIPNUMBER and xx == v.position.x and yy == v.position.y then
            selected = v
            pprint(v)
        end
    end


    if selected then

        for k, v in ipairs(getControls[selected.componentType]) do
            if(x > 500 and y > 500+k*30 and y < 525 + k*30) then
                clickUI[v.type](k, v.property, selected)
            end
        end
    end
end

funcs.drawAll = function()
    funcs.drawLeft()
    funcs.drawRight()
end
funcs.update = function(dt) end
return funcs

