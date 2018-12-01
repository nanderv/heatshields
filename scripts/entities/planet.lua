--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 11:16
-- To change this template use File | Settings | File Templates.
--
local pc = 0
return function(x,y,dx,dy, mass, color)
    pc = pc + 1
    return {isPlanet = true, oX = x, oY = y, dx = dx, dy= dy, mass = mass, size=math.sqrt(mass),  color=color, ax = 0, ay = 0, planetNumber = pc}
end