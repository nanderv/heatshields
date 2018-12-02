--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 02/12/2018
-- Time: 22:44
-- To change this template use File | Settings | File Templates.
--



--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 14:14
-- To change this template use File | Settings | File Templates.
--
local screen = {}
function getShip(shipnumber)
    for _,v in pairs(F.ship) do
        if v.shipNumber == shipnumber then
            return v
        end
    end
end
local font = love.graphics.newFont("sprites/blanka.otf", 64)
local font3 = love.graphics.newFont("sprites/SpaceMono-Bold.ttf", 24)
local font2 = love.graphics.newFont("sprites/SpaceMono-Bold.ttf", 12)
local img = love.graphics.newImage("sprites/firstScreen.png")
local slide = 1
local slides = {
    function()
        love.graphics.setFont(font)
        love.graphics.print("Heat Shield", 200, 100)
        love.graphics.setFont(font3)
        love.graphics.print("A Game By Nander", 200, 200)
        love.graphics.setFont(font2)

    end,
    function()
        love.graphics.setFont(font3)
        love.graphics.print("You are controlling a spaceship, on a trade mission between planets.\n It's your goal to get rich.\n However, there's a big shortage on heat shields.\n Therefore, every time you land, you lose a layer of your ship.", 180, 200)
        love.graphics.setFont(font2)
    end,
    function()
        love.graphics.setFont(font3)
        love.graphics.print("For more information, see the ludum dare site page.\n There's quite a few mechanics..\n\n The game starts on the planet mercury.\nYou've just picked up your first ship there.\nTry to get some cargo loaded.", 180, 200)
        love.graphics.setFont(font2)
    end

}
screen.drawAll = function()
    love.graphics.draw(img, 0, 0)
    if slides[slide] then
        slides[slide]()
    end
    if slide <= #slides+1 then
        scripts.ui.controls.drawUI.button(15, "next")
    end
    if slide > 1 then
    scripts.ui.controls.drawUI.button(16, "previous")
    end
end

screen.update = function(dt)

end

screen.onMouseClick = function(x, y)
    if slide < #slides then
        scripts.ui.controls.doIfClick(15, x, y, function()   slide = slide + 1 end)
    else
        scripts.ui.controls.doIfClick(15, x, y, function()   SCREEN = scripts.screens.shipScreen end)
    end
    if slide > 1 then
        scripts.ui.controls.doIfClick(16, x, y, function()     slide = slide - 1 end)
    end
end
screen.onKeyDown = function(something)

end

return screen
