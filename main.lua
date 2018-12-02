love.graphics.setDefaultFilter( "nearest", "nearest", 1 )
VARS = {}
VARS.engineMaxConsumption = 10
VARS.forcePerConsume = 20
SHIPHEIGHT = 9
SHIPWIDTH = 9
pprint = require 'lib.pprint'
require 'lib.helpers.core_funcs'
require 'lib.ECFS'
require 'lib.load_all_scripts'

BUY = {
    engine = 100,
    fuelTank = 200,
    cargo = 250,
}
SELL = {
    engine = 80,
    fuelTank = 160
}
MONEY=1000


CARGOES = {"Oil", "Uranium", "Food", "Medicine", "Hydrogen", "Machines", "Water", "Gold"}
local planets = {'Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn' }
function GETCARGO(cargoNumber)
    return CARGOES[cargoNumber] or "<Nothing>"
end
function GETPLANET(planetNumber)
    return planets[planetNumber] or ""
end
RENDERTOP = function()
    love.graphics.print("Money: ".. MONEY .. " - ShipNumber: " .. SHIPNUMBER .. " - ".. GETPLANET(getShip(SHIPNUMBER).planet), 300, 5)
end
function love.load()

    local aud  = love.audio.newSource("sprites/2018-dec-ludum.ogg", "queue")
    aud:setLooping(true)
    --aud:play()
    require 'scripts'
    local sn = NEXTSHIP()
    local ent = scripts.entities.shipComponents.engine(1,9,sn)
    core.entity.add(ent)
    local ent = scripts.entities.shipComponents.engine(2,9,sn)
    core.entity.add(ent)
    local ent = scripts.entities.shipComponents.engine(3,9,sn)
    core.entity.add(ent)

    local ent = scripts.entities.shipComponents.fuelTank(3,8,sn)
    core.entity.add(ent)
    local ent = scripts.entities.shipComponents.fuelTank(2,8,sn)
    core.entity.add(ent)
    local ent = scripts.entities.shipComponents.fuelTank(1,8,sn)
    core.entity.add(ent)

    local ent = scripts.entities.shipComponents.cargo(3,7,sn)
    core.entity.add(ent)
    local ent = scripts.entities.shipComponents.cargo(2,7,sn)
    core.entity.add(ent)
    local ent = scripts.entities.shipComponents.cargo(1,7,sn)
    core.entity.add(ent)

    core.entity.add(scripts.entities.ship(sn,300,300,0,10, 1))
    scripts.systems.helpers.shipValues.updateShip(sn)
    core.entity.add(scripts.entities.star(0,0,500,{ r= 50, g= 50, b= 50}))

    core.entity.add(scripts.entities.planet(100,200,30, 0, 50, { r= 0, g= 50, b= 0}))
    core.entity.add(scripts.entities.planet(100,100,10, 0, 50, { r= 0, g= 0, b= 1}))
    core.entity.add(scripts.entities.planet(100,400,50, 0, 50, { r= 1, g= 0, b= 0}))

    SHIPNUMBER = sn
    SCREEN = scripts.screens.buy
end

function love.update(dt)
    SCREEN.update(dt)
end

function love.draw()
    love.graphics.print(love.timer.getFPS(), 10, 10)
    love.graphics.print(collectgarbage('count'), 50, 10)
 --   scripts.systems.draw_ship.drawBackground(10,10,64)

    SCREEN.drawAll()
    RENDERTOP()
end

function love.mousepressed( x, y, button )
    SCREEN.onMouseClick(x,y, button)
end
function love.keypressed( key, scancode, isrepeat )
    SCREEN.onKeyDown(key)
end