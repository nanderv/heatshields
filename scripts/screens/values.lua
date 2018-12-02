--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2018
-- Time: 21:03
-- To change this template use File | Settings | File Templates.
--

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
    local str = ""
    local c = 0
    love.graphics.print(str, 50, 50+30*c)
    for K, v in ipairs(CARGOES) do
        love.graphics.print(v, 70+ K*60, 50+30*c)
    end



    for k, v  in pairs(F.planet) do
        c = c + 1
        local pl = GETPLANET(v.planetNumber)
        love.graphics.print(pl, 40, 50+30*c)

        for k, w in ipairs(v.values) do
            love.graphics.print(w, 70+ k*60, 50+30*c)
        end
        love.graphics.setColor(v.color.r, v.color.g, v.color.b)
        love.graphics.circle("fill", 20, 60+30*c, 10 )
        love.graphics.setColor(1,1,1)
    end

end
local getControls
local drawUI
local onClick

funcs.drawRight = function()
    getControls = getControls or  scripts.ui.controls.getControls
    drawUI = drawUI or scripts.ui.controls.drawUI
    onClick = onClick or scripts.ui.controls.onClick

    love.graphics.print("Current prices indicated. May fluctuate over time.", 1000, 15)
end
funcs.onMouseClick = function(x, y, click)
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

