--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 10:24
-- To change this template use File | Settings | File Templates.
--
local func = {}
local ship = love.graphics.newImage("sprites/ship.png")
func.drawBackground = function(x, y, scale)
    for i=0, 9 do
        for j = 0, 9 do
            love.graphics.line(x, y+ j*scale, x+i*scale, y + j*scale)
            love.graphics.line(x + i * scale , y, x+i*scale, y + j*scale)
        end
    end
end

local function drawQuad(sprite, quad)
    return function(x,y,scale, coords)
        love.graphics.draw( sprite, quad, x + coords.x*scale, y+ coords.y * scale, 0, scale/16, scale/16 )
    end
end
local drawPart = {}
drawPart.engine = drawQuad(ship, love.graphics.newQuad(0, 0, 16, 16, ship:getWidth(), ship:getHeight()))
drawPart.fuelTank = drawQuad(ship, love.graphics.newQuad(16, 0, 16, 16, ship:getWidth(), ship:getHeight()))
func.drawShip = function(shipNumber, x,y,scale)
    for k,v in pairs(F.ship_component) do
        if v.shipNumber == shipNumber then
            drawPart[v.componentType](x,y,scale,v.position)
        end
    end
end


return func