--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 11:14
-- To change this template use File | Settings | File Templates.
--

-- if selected ship is in trajectory mode, this screen is the screen to show.
local screen = {}
local myspeed = 0
screen.drawLeft = function()

end
local posOnScreenX, posOnScreenY = 600, 300
screen.drawRight =  function()
    if SHIPNUMBER == nil then
        return
    end

end
local dist = function(x,y,ox,oy)
    local dx = x - ox
    local dy = y - oy
    return math.sqrt(dx*dx + dy * dy)
end
screen.drawAll = function()
    scripts.screens.drawUIBackground()

    screen.drawLeft()
    screen.drawRight()
    local ship = getShip(SHIPNUMBER)
    scripts.systems.drawStellarObjects.drawAll(ship.oX- posOnScreenX, ship.oY- posOnScreenY)

    love.graphics.setColor(0,0.5,0)
    love.graphics.line(posOnScreenX, posOnScreenY, posOnScreenX + 40*math.cos(ship.burnDirection), posOnScreenY + 40*math.sin(ship.burnDirection))
    love.graphics.setColor(1,1,0)
    love.graphics.line(posOnScreenX, posOnScreenY, posOnScreenX + ship.dx, posOnScreenY + ship.dy)
    love.graphics.setColor(1,1,1)
    scripts.ui.controls.drawUI.slider(1, "Burn Speed", ship.burnRate)
    scripts.ui.controls.drawUI.button(2, "Cut Engines")
    local totalFuel, currentFuel = 0, 0
    for k,v in pairs(F.fuelTank) do
        totalFuel = totalFuel + v.max
        currentFuel = currentFuel + v.amount
    end
    scripts.ui.controls.drawUI.text(3, "FUEL : ".. math.floor(currentFuel) .." / " .. totalFuel )

    for _, v in pairs(F.planet) do
        if (dist(v.oX, v.oY, ship.oX, ship.oY) < 40) then
            scripts.ui.controls.drawUI.button(4, "Land", ship.burnRate)
        end
    end

end

screen.update = function(dt)
    scripts.systems.simulateOrbitals.moveTime(myspeed,dt)
end

screen.onMouseClick = function(x, y)
    local d = dist(x,y,posOnScreenX, posOnScreenY )
    if d < 100 then
        if d > 0 then
            getShip(SHIPNUMBER).burnDirection = math.atan2(y-posOnScreenY, x-posOnScreenX)
        end
    end
    local v = getShip(SHIPNUMBER)
    scripts.ui.controls.doIfClick(1, x, y, function()
        scripts.ui.controls.clickUI.slider(1, "burnRate", v, v.func, x-scripts.ui.controls.listPosX, y-scripts.ui.controls.listPosY)
    end)
    scripts.ui.controls.doIfClick(2, x, y, function()
        v.burnRate = 0
    end)
    for _, w in pairs(F.planet) do
        if (dist(v.oX, v.oY, w.oX, w.oY) < 40) then
            scripts.ui.controls.doIfClick(4, x, y, function()
                v.planet = w.planetNumber
                SCREEN = scripts.screens.landingScreen
            end)
        end
    end

end
screen.onKeyDown = function(something)
    if something == "1" then
        myspeed = 0.2
    end
    if something == "2" then
        myspeed = 0.4
    end
    if something == "3" then
        myspeed = 0.8
    end
    if something == "4" then
        myspeed = 1.6
    end
    if something == "5" then
        myspeed = 3.2
    end
    if something == "space" then
        myspeed = 0
    end
end

return screen
