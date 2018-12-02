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
        local found
        for k, v in pairs(F.ship_component) do
            if v.shipNumber == shipNumber and xx == v.position.x and yy == v.position.y then
                if v.componentType == "cargo" then
                    found = v
                end
            end
        end
        return  (found and not found.cargo)
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
            if v.componentType == "cargo" and not v.cargo then
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

    local pl = getPlanet(getShip(SHIPNUMBER).planet)
    local ls = {}
    for k, v in ipairs(CARGOES) do
        ls[k] = {
            name = "Buy " .. v .. "(" .. pl.values[k] .. ")",
            type = "button",
            func = function()
                action = k
            end
        }
    end
    return ls
end
funcs.drawRight = function()
    -- left right up down buttons

    drawUI = drawUI or scripts.ui.controls.drawUI
    onClick = onClick or scripts.ui.controls.onClickCustom

    love.graphics.print("Select an action.", 1000, 15)
    for k, v in ipairs(uiElems()) do
        drawUI[v.type](k, v.name, nil)
    end
end

local kreators = {}
kreators.engine = function(shipNumber, xx, yy, item)
end
funcs.onMouseClick = function(x, y, click)
    -- Select ship part
    local xx = math.floor((x - RX) / RS)
    local yy = math.floor((y - RY) / RS)

    onClick = onClick or scripts.ui.controls.onClickCustom
    onClick(uiElems(), x, y)
    if canPlace(SHIPNUMBER, action, xx, yy) and action then
        for k, v in pairs(F.ship_component) do
            if v.shipNumber == SHIPNUMBER and xx == v.position.x and yy == v.position.y then
                if v.componentType == "cargo" then
                    local val =  getPlanet(getShip(SHIPNUMBER).planet).values[action]
                    if val > MONEY then return end

                    v.cargo = action
                    MONEY = MONEY - getPlanet(getShip(SHIPNUMBER).planet).values[action]
                end
            end
        end
        getPlanet(getShip(SHIPNUMBER).planet).values[action] = getPlanet(getShip(SHIPNUMBER).planet).values[action] + 50
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
