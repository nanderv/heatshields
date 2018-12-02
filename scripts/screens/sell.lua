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
local action = "SELL"


local function canPlace(shipNumber, action, xx, yy)
    if xx >= 0 and yy >= 0 and xx <= SHIPWIDTH and yy <= SHIPHEIGHT then
        local found
        for k, v in pairs(F.ship_component) do
            if v.shipNumber == shipNumber and xx == v.position.x and yy == v.position.y then
                if v.componentType == "cargo" then
                    found = v
                end
            end
        end
        return  (found and found.cargo)
    end
end

funcs.drawLeft = function()
    scripts.systems.draw_ship.drawShip(SHIPNUMBER, RX, RY, RS)
    local x, y = love.mouse.getPosition()
    local xx = math.floor((x - RX) / RS)
    local yy = math.floor((y - RY) / RS)
    if canPlace(SHIPNUMBER, action, xx, yy) then
        love.graphics.setColor(0, 0, 1, 0.5)
        love.graphics.rectangle("fill", RX + xx * RS, RY + yy * RS, RS, RS)
        love.graphics.setColor(1, 1, 1, 1)
    end

    for k, v in pairs(F.ship_component) do
        if v.shipNumber == SHIPNUMBER then
            if v.componentType == "cargo" and v.cargo then
                love.graphics.setColor(0, 0, 1, 0.2)
                love.graphics.rectangle("fill", RX + v.position.x * RS, RY + v.position.y * RS, RS, RS)
                love.graphics.setColor(1, 1, 1, 1)
            end
        end
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
local uiElems = function()
    return { {
        name = "Sell ",
        type = "button",
        func = function()

            action = "SELL"
        end
    } }
end
funcs.drawRight = function()
    -- left right up down buttons

    drawUI = drawUI or scripts.ui.controls.drawUI
    onClick = onClick or scripts.ui.controls.onClickCustom

    love.graphics.print("Select which location to sell from.", 1000, 15)


    drawUI['text'](2, "Infor per product: ", nil)
    for k,v in ipairs(getPlanet(getShip(SHIPNUMBER).planet).values) do
            drawUI['text'](2+k, GETCARGO(k) .. " : ".. (v-60), nil)
        end

end

local kreators = {}
kreators.engine = function(shipNumber, xx, yy, item)
end
funcs.onMouseClick = function(x, y, click)
    print(x, y, click)
    -- Select ship part
    local xx = math.floor((x - RX) / RS)
    local yy = math.floor((y - RY) / RS)

    onClick = onClick or scripts.ui.controls.onClickCustom
    onClick(uiElems(), x, y)
    print(xx, yy, action)
    if canPlace(SHIPNUMBER, action, xx, yy) and action then
        print("ACT", action)
        local carg
        for k, v in pairs(F.ship_component) do
            if v.shipNumber == SHIPNUMBER and xx == v.position.x and yy == v.position.y then
                if v.componentType == "cargo" then

                    MONEY = MONEY + math.max(0,getPlanet(getShip(SHIPNUMBER).planet).values[v.cargo]- 60)
                    carg = v.cargo
                    v.cargo = nil
                end
            end
        end
        getPlanet(getShip(SHIPNUMBER).planet).values[carg] = getPlanet(getShip(SHIPNUMBER).planet).values[carg] - 50
    end

    scripts.ui.controls.doIfClick(14, x, y, function() SCREEN = scripts.screens.shipScreen end)
end

funcs.drawAll = function()
    scripts.screens.drawUIBackground()
    funcs.drawLeft()
    funcs.drawRight()
    scripts.ui.controls.drawUI.button(14, "Switch to Ship View")
end
funcs.update = function(dt) end
return funcs
