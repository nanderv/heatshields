--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 12:54
-- To change this template use File | Settings | File Templates.
--

-- Left side: draw ship

-- right side: draw context menu based on last click.
local RX, RY, RS = 20, 80, 64;

local funcs = {}
local selected
funcs.drawLeft = function()
    scripts.systems.draw_ship.drawShip(SHIPNUMBER, RX, RY, RS)
end
local getControls
local drawUI
local onClick
local burns
local burntimer = 0

local destroy = function(direction)
    return function()
        local components = {}
        for k,v in pairs(F.ship_component) do
            if v.shipNumber == SHIPNUMBER then
                components[v.position.x..":".. v.position.y] = v
            end
        end
        burns = {}

        if direction=="left" then
            for i=0,SHIPHEIGHT do
                local found = false
                for j=0, SHIPWIDTH do
                    if not found and components[j..":"..i] then
                        burns[#burns + 1] = components[j..":"..i]
                        found = true
                    end
                end
            end
        end
        if direction=="right" then
            for i=0,SHIPHEIGHT do
                local found = false
                for k=0, SHIPWIDTH do
                    local j = 9-k

                    if not found and components[j..":"..i] then
                        burns[#burns + 1] = components[j..":"..i]
                        found = true
                    end
                end
            end
        end
        if direction=="up" then
            for i=0,SHIPWIDTH do
                local found = false
                for j=0, SHIPHEIGHT do
                    if not found and components[i..":"..j] then
                        burns[#burns + 1] = components[i..":"..j]
                        found = true
                    end
                end
            end
        end
        if direction=="down" then
            for i=0, SHIPWIDTH do
                local found = false
                for k=0, SHIPHEIGHT do
                    local j = 9-k
                    if not found and components[i..":"..j] then
                        burns[#burns + 1] = components[i..":"..j]
                        found = true
                    end
                end
            end
        end
        burntimer = 2
    end
end
local uiElems = {
    {name = "left",   type="button", func=destroy("left")},
    {name = "right", type="button", func=destroy("right")},
    {name = "up",     type="button", func=destroy("up")},
    {name = "down", type="button", func=destroy("down")}
}

funcs.drawRight = function()
    -- left right up down buttons

    drawUI = drawUI or scripts.ui.controls.drawUI
    onClick = onClick or scripts.ui.controls.onClickCustom

    love.graphics.print("Which direction do you want to face while landing?", 1000, 15)
    for k, v in ipairs(uiElems) do
        drawUI[v.type](k, v.name, nil)
    end
end
funcs.onMouseClick = function(x, y, click)
    -- Select ship part
    local xx = math.floor((x - RX) / RS)
    local yy = math.floor((y - RY) / RS)

    onClick = onClick or scripts.ui.controls.onClickCustom
    onClick(uiElems, x, y)

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

