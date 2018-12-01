--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 12:15
-- To change this template use File | Settings | File Templates.
--

local funcs = {}
G = 0.016

local function dist(obj, obj2)
    local xd = obj.oX - obj2.oX
    local yd = obj.oY - obj2.oY
    return math.sqrt(xd * xd + yd * yd)
end
funcs.moveTime = function(speed, dt)
    local delta = speed*dt

    for _,v in pairs(F.orbital) do
        for _, w in  pairs(F.massSoure) do
            if (v ~= w) then
                print(v.oX, v.oY)

                local g = delta * G * w.mass / dist(v,w) * dist(v,w)
                local xG = g * (v.oX - w.oX) / dist(v,w)
                local yG = g * (v.oY - w.oY) / dist(v,w)
                v.dx = v.dx - xG
                v.dy = v.dy - yG
            end
        end
    end
    for _, v in pairs(F.orbital) do
        v.oX = v.oX + delta * v.dx
        v.oY = v.oY + delta * v.dy
        print(v.oX, v.oY)
    end
end
return funcs

