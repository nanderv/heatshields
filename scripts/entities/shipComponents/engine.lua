--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 10:38
-- To change this template use File | Settings | File Templates.
--
return function(x, y, shipNumber)
    return {componentType="engine", shipNumber = shipNumber, position={x=x, y=y}, mass = 5, enabled = true }
end

