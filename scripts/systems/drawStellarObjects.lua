--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 12:33
-- To change this template use File | Settings | File Templates.
--
local funcs = {}


funcs.drawShip = function(x,y, color)
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.circle( "fill", x, y, 3 )
    love.graphics.setColor(1,1,1)
end

funcs.drawPlanet = function(x,y, size, color)
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.circle( "fill", x, y, size )
    love.graphics.setColor(1,1,1)
end

funcs.drawStar = function(x,y,size, color)
    love.graphics.setColor(color.r, color.g, color.b)
    love.graphics.circle( "fill", x, y, size )
    love.graphics.setColor(1,1,1)
end

funcs.drawAll = function()
    for _,v in pairs(F.ship) do
        funcs.drawShip(v.oX, v.oY, {r= 1, g = 0, b = 0})
    end
    for _,v in pairs(F.planet) do
        funcs.drawPlanet(v.oX, v.oY, v.size, v.color)
    end
    for _,v in pairs(F.star) do
        funcs.drawStar(v.oX, v.oY, v.size, v.color)
    end
end
return funcs