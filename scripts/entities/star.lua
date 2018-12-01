--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 11:16
-- To change this template use File | Settings | File Templates.
--


return function(x, y, mass, color)
    return {isStar=true, oX = x, oY = y, mass = mass, size=mass/100, color=color}
end