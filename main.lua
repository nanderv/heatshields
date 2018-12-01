love.graphics.setDefaultFilter( "nearest", "nearest", 1 )

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
    pprint(F.ship)
    core.entity.add(scripts.entities.star(500,500,500,{ r= 50, g= 50, b= 50}))
    SHIPNUMBER = sn
    screen = scripts.screens.shipControlScreen
end

function love.update(dt)
    screen.update(dt)
end

function love.draw()
    love.graphics.print(love.timer.getFPS(), 10, 10)
    love.graphics.print(collectgarbage('count'), 50, 10)
 --   scripts.systems.draw_ship.drawBackground(10,10,64)

    screen.drawAll()
end

function love.mousepressed( x, y, button )
    screen.onMouseClick(x,y, button)
end
function love.keypressed( key, scancode, isrepeat )
    core.runEvent({key=key, scancode=scancode,isrepeat=isrepeat,type="key"})
end