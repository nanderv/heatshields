--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 11:16
-- To change this template use File | Settings | File Templates.
--
local next = 0

NEXTSHIP = function()
        next = next + 1
        return next
end
return function(shipNumber, x, y, dx, dy, pl)
    return {isShip=true, orbitType="ship", oX = x, oY = y, dx = dx, dy = dy, shipNumber = shipNumber, mass = 0, ax=0, ay=0, planet = pl, burnDirection = 0, burnRate = 0, weight=0}
end

