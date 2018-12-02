--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 15:37
-- To change this template use File | Settings | File Templates.
--

local function recurseThrough(components, handled, current, eg)
    local x,y = current.position.x, current.position.y
    local nb = {{x+1, y}, {x,y+1}, {x,y-1}, {x-1,y} }
    for _, v in ipairs(nb) do
        local c  = components[v[1].. ":"..v[2]]
        if c and not handled[v[1].. ":"..v[2]] then
            if c.componentType =="engine" and c.enabled then
                eg.engines[#eg.engines+1] = c
                handled[v[1]..":"..v[2]] = v[1]..":"..v[2]
                recurseThrough(components, handled, c, eg)
            end
            if c.componentType =="fuelTank" and c.links then
                eg.fuelTanks[#eg.fuelTanks+1] = c
                handled[v[1]..":"..v[2]] = v[1]..":"..v[2]
                recurseThrough(components, handled, c, eg)
            end
        end
    end


end
return function(shipNumber, dt)
    -- step 1: get more effective datastructure for ship

    local ship = getShip(shipNumber)
    local components = {}
    for k,v in pairs(F.ship_component) do
        if v.shipNumber == shipNumber then
            components[v.position.x..":".. v.position.y] = v
        end
    end

    local eg = {}

    eg.engines = {}
    eg.fuelTanks = {}
    for k, v in pairs(components) do
        if  v.componentType == "engine" then
            eg.engines[#eg.engines +1]= v
        end
        if  v.componentType == "fuelTank" then
            eg.fuelTanks[#eg.fuelTanks+1] = v
        end
    end

    -- eg is one engine-group, so can be handled separately.
    -- first thing: calculate fuel needed for full burn
    local fuelNeeded = #(eg.engines) * VARS.engineMaxConsumption * ship.burnRate * dt
    local fuelAvailable = 0

    for _, v in ipairs(eg.fuelTanks) do
        if v.enabled then
            fuelAvailable = fuelAvailable + v.amount
        end
    end
    local consume = math.min(fuelAvailable, fuelNeeded)
    local velo = consume*VARS.forcePerConsume / scripts.systems.helpers.shipValues.getWeight(shipNumber)

    ship.dx = ship.dx + velo *math.cos(ship.burnDirection)
    ship.dy = ship.dy + velo *math.sin(ship.burnDirection)
    local counter = 20
    while counter > 0 do
        counter = counter - 1
        local rnd = consume
        for _, tank in ipairs(eg.fuelTanks) do
            local remove = math.min(rnd/#eg.fuelTanks, tank.amount)
            tank.amount = tank.amount - remove
            consume = consume - remove
        end
    end
end

