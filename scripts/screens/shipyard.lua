--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 14:07
-- To change this template use File | Settings | File Templates.
--

-- if a ship is on a planet, this screen allows the player to select cargo etc.
local RX, RY, RS = 20, 80, 64;

local funcs = {}
local action


local function canPlace(shipNumber, action, xx, yy)
    if xx >= 0 and yy >= 0 and xx <= SHIPWIDTH and yy <= SHIPHEIGHT then
        if action == "delete" then
            local found
            for k,v in pairs(F.ship_component) do
                if v.shipNumber == shipNumber and xx == v.position.x and yy == v.position.y then
                    found = v
                end
            end
            return found
        elseif action ~= nil then
            local found
            local notfound = false
            for k,v in pairs(F.ship_component) do
                local x2 = xx - v.position.x
                local y2 = yy - v.position.y
                if v.shipNumber == shipNumber and xx == v.position.x and yy == v.position.y then
                    notfound = true
                end
                if v.shipNumber == shipNumber and x2 * y2 == 0 and (x2*x2 == 1 or y2*y2 == 1) then
                    found = v
                end
            end
            return found  and not notfound
        end

    end
end
funcs.drawLeft = function()
    scripts.systems.draw_ship.drawShip(SHIPNUMBER, RX, RY, RS)
    local x, y = love.mouse.getPosition()
    local xx = math.floor((x - RX) / RS)
    local yy = math.floor((y - RY) / RS)
    if canPlace(SHIPNUMBER, action, xx, yy) then
        love.graphics.setColor(0,0,1,0.5)
        love.graphics.rectangle("fill", RX+xx*RS, RY + yy* RS, RS, RS)
        love.graphics.setColor(1,1,1,1)
    end
end
local getControls
local drawUI
local onClick
local getPlanet = function(planetNumber)
    for _, v in pairs(F.planet) do
        if v.planetNumber == planetNumber then
            return v
        end
    end
end
local uiElems = {
    {name = "Add Engine", type="button", func=function()
       action="engine"
    end},
    {name = "Add FuelTank", type="button", func=function()
        action="fuelTank"
    end},
    {name = "Add Cargo", type="button", func=function()
        action="cargo"
    end},
    {name = "Delete thing", type="button", func=function()
        action = "delete"
    end}
}

funcs.drawRight = function()
    -- left right up down buttons

    drawUI = drawUI or scripts.ui.controls.drawUI
    onClick = onClick or scripts.ui.controls.onClickCustom

    love.graphics.print("Select an action.", 1000, 15)
    for k, v in ipairs(uiElems) do
        drawUI[v.type](k, v.name, nil)
    end
end

local kreators = {}
kreators.engine = function(shipNumber, xx, yy)
    return scripts.entities.shipComponents.engine(xx,yy,shipNumber)
end
kreators.fuelTank = function(shipNumber, xx, yy)
    return scripts.entities.shipComponents.fuelTank(xx,yy,shipNumber)
end
kreators.cargo = function(shipNumber, xx, yy)
    return scripts.entities.shipComponents.cargo(xx,yy,shipNumber)
end
funcs.onMouseClick = function(x, y, click)
    print(x,y, click)
    -- Select ship part
    local xx = math.floor((x - RX) / RS)
    local yy = math.floor((y - RY) / RS)

    onClick = onClick or scripts.ui.controls.onClickCustom
    onClick(uiElems, x, y)
    print(xx,yy)
    if canPlace(SHIPNUMBER, action, xx, yy) then
        if action == "delete" then
            print("DELETING")
            local found
            for k,v in pairs(F.ship_component) do
                if v.shipNumber == SHIPNUMBER and xx == v.position.x and yy == v.position.y then
                    found = v
                end
            end
            if found then
                pprint(found)
                core.entity.remove(found)
            end
        else
            core.entity.add(kreators[action](SHIPNUMBER, xx, yy))
            print("Adding entity ".. action)
        end

    end
    scripts.ui.controls.doIfClick(14, x, y, function()     SCREEN = scripts.screens.shipScreen end)

end

funcs.drawAll = function()
    scripts.screens.drawUIBackground()
    funcs.drawLeft()
    funcs.drawRight()
    scripts.ui.controls.drawUI.button(14, "Switch to Ship View")

end
funcs.update = function(dt) end
return funcs
