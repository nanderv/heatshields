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
function love.load()
    require 'scripts'
    local sn = NEXTSHIP()
    local ent = scripts.entities.shipComponents.engine(1,1,sn)
    core.entity.add(ent)
    local ent = scripts.entities.shipComponents.engine(2,1,sn)
    core.entity.add(ent)
    local ent = scripts.entities.shipComponents.engine(3,1,sn)
    core.entity.add(ent)

    local ent = scripts.entities.shipComponents.fuelTank(3,0,sn)
    core.entity.add(ent)
    local ent = scripts.entities.shipComponents.fuelTank(2,0,sn)
    core.entity.add(ent)
    local ent = scripts.entities.shipComponents.fuelTank(1,0,sn)
    core.entity.add(ent)
    core.entity.add(scripts.entities.ship(sn,300,300,0,10))
    scripts.systems.helpers.shipValues.updateShip(sn)
    core.entity.add(scripts.entities.star(500,500,500,{ r= 50, g= 50, b= 50}))

    core.entity.add(scripts.entities.planet(500,700,20, 0, 50, { r= 0, g= 50, b= 0}))
    SHIPNUMBER = sn
    SCREEN = scripts.screens.landingScreen
end

function love.update(dt)
    SCREEN.update(dt)
end

function love.draw()
    love.graphics.print(love.timer.getFPS(), 10, 10)
    love.graphics.print(collectgarbage('count'), 50, 10)
 --   scripts.systems.draw_ship.drawBackground(10,10,64)

    SCREEN.drawAll()
end

function love.mousepressed( x, y, button )
    SCREEN.onMouseClick(x,y, button)
end
function love.keypressed( key, scancode, isrepeat )
    SCREEN.onKeyDown(key)
end