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

funcs.drawLeft = function()
    scripts.systems.draw_ship.drawShip(SHIPNUMBER, RX, RY, RS)
end
local getControls
local drawUI
local onClick
local burns
local burntimer = 0
local getPlanet = function(planetNumber)
    for _, v in pairs(F.planet) do
        if v.planetNumber == planetNumber then
            return v
        end
    end
end
local uiElems = function()
    local fuelNeeded = 0
    for k, v in pairs(F.ship_component) do
        if v.shipNumber == SHIPNUMBER then
            if v.componentType == "fuelTank" then
                fuelNeeded = fuelNeeded - v.amount + v.max
            end
        end
    end

    return

    {{name = "Launch", type="button", func=function()
            local pl = getPlanet(getShip(SHIPNUMBER).planet)
            local s = getShip(SHIPNUMBER)
            pprint(pl)
            s.oX = pl.oX
            s.oY = pl.oY
            s.dx = pl.dx
            s.dy = pl.dy
            pprint(s)

            s.planet=nil
        end},
        {name = "Edit Ship", type="button", func=function()
            SCREEN = scripts.screens.shipyard
        end },
        {name = "Buy", type="button", func=function()
            SCREEN = scripts.screens.buy
        end },
        {name = "Sell", type="button", func=function()
            SCREEN = scripts.screens.sell
        end },
        {name = "Check Values at other Planets", type="button", func=function()
            SCREEN = scripts.screens.values
        end },
        {name = "Refuel ( "..math.floor(fuelNeeded).. ")", type="button", func=function()
            print("REFUELING")
            if MONEY < fuelNeeded then return end
            MONEY = MONEY - math.floor(fuelNeeded)
            for k, v in pairs(F.ship_component) do
                if v.shipNumber == SHIPNUMBER then
                    if v.componentType == "fuelTank" then
                        v.amount = v.max
                    end
                end
            end
        end}
    }
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
funcs.onMouseClick = function(x, y, click)
    print(x,y, click)
    -- Select ship part
    local xx = math.floor((x - RX) / RS)
    local yy = math.floor((y - RY) / RS)

    onClick = onClick or scripts.ui.controls.onClickCustom
    onClick(uiElems(), x, y)

end

funcs.drawAll = function()
    scripts.screens.drawUIBackground()
    funcs.drawLeft()
    funcs.drawRight()
    if(burntimer > 0) then
        for _,v in ipairs(burns) do
            love.graphics.setColor(1,0,0,0.7)
            love.graphics.rectangle( "fill",RX + v.position.x* RS, RY+v.position.y * RS, RS, RS  )
            love.graphics.setColor(1,1,1,1)
        end

    elseif burns ~= nil then
        for _, v in pairs(burns) do
            core.entity.remove(v)
        end
        SCREEN = scripts.screens.shipScreen

        burns = nil
    end
end
funcs.update = function(dt) burntimer = burntimer - dt end
return funcs
