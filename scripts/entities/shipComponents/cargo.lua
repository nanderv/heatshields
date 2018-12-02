--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 10:38
-- To change this template use File | Settings | File Templates.
--
return function(x, y, shipNumber)
    return {componentType="cargo", shipNumber = shipNumber, position={x=x, y=y}, cargo=nil, mass = 5, enabled = true, links = true }
end

