--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 10:38
-- To change this template use File | Settings | File Templates.
--
return function(x, y, shipNumber)
    return {componentType="fuelTank", shipNumber = shipNumber, position={x=x, y=y}, amount = 0, max = 100, mass = 5, enabled = true, drawFuel = true }
end

