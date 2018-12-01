--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 14:14
-- To change this template use File | Settings | File Templates.
--
local screen = {}
function getShip(shipnumber)
    for _,v in pairs(F.ship) do
            if v.shipNumber == shipnumber then
                return v
            end
    end
end
screen.drawAll = function()
    if SHIPNUMBER then
        local ship = getShip(SHIPNUMBER)
        if ship.planet then
            scripts.screens.planetScreen.drawAll()
        else
            scripts.screens.trajectoryScreen.drawAll()
        end
    end
    scripts.ui.controls.drawUI.button(14, "Switch to Ship Control")

end

screen.update = function(dt)
    if SHIPNUMBER then
        local ship = getShip(SHIPNUMBER)
        if ship.planet then
            scripts.screens.planetScreen.update(dt)
        else
            scripts.screens.trajectoryScreen.update(dt)
        end
    end
end

screen.onMouseClick = function(x, y)
    if SHIPNUMBER then
        local ship = getShip(SHIPNUMBER)
        if ship.planet then
            scripts.screens.planetScreen.onMouseClick(x, y)
        else
            scripts.screens.trajectoryScreen.onMouseClick(x,y)
        end
    end
    scripts.ui.controls.doIfClick(14, x, y, function()     SCREEN = scripts.screens.shipControlScreen end)

end
screen.onKeyDown = function(something)
    if SHIPNUMBER then
        local ship = getShip(SHIPNUMBER)
        if ship.planet then
            scripts.screens.planetScreen.onKeyDown(something)
        else
            scripts.screens.trajectoryScreen.onKeyDown(something)
        end
    end
end

return screen
