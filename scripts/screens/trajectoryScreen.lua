--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 11:14
-- To change this template use File | Settings | File Templates.
--
local screen = {}
screen.drawSidebar = function()

end
screen.drawMain =  function()
    if SELECTEDSHIP == nil then
        return
    end

end
screen.drawAll = function()
    screen.drawSidebar()
    screen.drawMain()
    scripts.systems.drawStellarObjects.drawAll()

end

screen.update = function(dt)
    scripts.systems.simulateOrbitals.moveTime(1,dt)
end

screen.onClick = function(x, y)

end
screen.onKeyDown = function(something)

end

return screen
