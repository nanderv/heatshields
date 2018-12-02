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

funcs.drawRight = function()
    getControls = getControls or  scripts.ui.controls.getControls
    drawUI = drawUI or scripts.ui.controls.drawUI
    onClick = onClick or scripts.ui.controls.onClick
    if selected then
        for k, v in ipairs(getControls[selected.componentType]) do
            drawUI[v.type](k, v.name, selected[v.property], v.func, selected)
        end

    else
    end
end
funcs.onMouseClick = function(x, y, click)
    -- Select ship part
    local xx = math.floor((x - RX) / RS)
    local yy = math.floor((y - RY) / RS)
    for k,v in pairs(F.ship_component) do
        if v.shipNumber == SHIPNUMBER and xx == v.position.x and yy == v.position.y then
            selected = v
        end
    end

    onClick = onClick or scripts.ui.controls.onClick
    if selected then
        pprint(selected)
        onClick(selected, x, y)
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

