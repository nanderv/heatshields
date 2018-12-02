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
local slide = 1
local slides = {
    function() print("SLIDE 1") end,
    function() print("SLIDE 2") end,
    function() print("SLIDE 3") end,
    function() print("SLIDE 4") end

}
screen.drawAll = function()
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
    if slide <= #slides then
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
