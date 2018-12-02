--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 11:16
-- To change this template use File | Settings | File Templates.
--
local pc = 0
return function(x,y,dx,dy, mass, color)
    pc = pc + 1
    local values = {}
    local runs = {}
    local dirs = {}
    local speeds = {}
    for i=1, #CARGOES do
        values[i] = math.random(100,900)
        runs[i] = 0
        dirs[i] = 1
        speeds[i] = 1
    end
    return {isPlanet = true, oX = x, oY = y, dx = dx, dy= dy, mass = mass, size=math.sqrt(mass),  color=color, ax = 0, ay = 0, planetNumber = pc, values = values, runs = runs, directions = dirs, speeds = speeds}
end