--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 11:31
-- To change this template use File | Settings | File Templates.
--
local funcs = {}

funcs.getWeight = function(shipNumber)
    local weight = 0
    for k,v in pairs(F.ship_component) do
        if v.shipNumber == shipNumber then
            weight = weight + v.mass or 0
            pprint(v)
        end
    end
    print(weight)
    return weight

end
funcs.getMaxForce = function(shipNumber)

end
funcs.getMaxAcc = function(shipNumber)

end
funcs.getFirstEngineShutoffAfter = function(shipNumber)

end

funcs.updateShip = function(shipNumber)
    for k,v in pairs(F.ship) do
        if v.shipNumber == shipNumber then
            v.mass = funcs.getWeight(shipNumber)
        end
    end
end
return funcs