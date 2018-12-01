--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 11:16
-- To change this template use File | Settings | File Templates.
--

return function(x,y,dx,dy, mass, color)
    return {isPlanet = true, oX = x, oY = y, dx = dx, dy= dy, mass = mass, color=color, ax = 0, ay = 0}
end