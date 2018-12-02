--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 01/12/2018
-- Time: 14:26
-- To change this template use File | Settings | File Templates.
--

local listPosX = 1000
local listPosY = 50
local drawUI = {}
drawUI.boolean = function(k, name, enabled)
    local str = "false"
    if enabled then str = "true" end
    love.graphics.print(name ..":" .. str, listPosX, listPosY+30*k )
end
drawUI.button = function(k, name)
    love.graphics.setColor(0.3,0.3,0.3)
    love.graphics.rectangle("fill", listPosX, listPosY+30*k, 200, 15)
    love.graphics.setColor(1,1,1)
    love.graphics.print(name, listPosX, listPosY+30*k )
end
drawUI.text = function(k, name)
    love.graphics.print(name, listPosX, listPosY+30*k )
end

drawUI.textFunc = function(k, _, _, func, obj)
    love.graphics.print(func(obj), listPosX, listPosY+30*k )
end
drawUI.slider = function(k, name, value)
    love.graphics.setColor(1,0.5,0.5,1)
    love.graphics.rectangle("fill", listPosX, listPosY+30*k, 200, 5)
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("fill", listPosX, listPosY+30*k, 200*value, 5)

    love.graphics.print(name, listPosX, listPosY+30*k+5)

end
local clickUI = {}
clickUI.button = function(k, name, obj, func)
    func(obj)
end
clickUI.boolean = function(k, property, obj)
    obj[property] = not obj[property]
end
clickUI.slider = function(k, property, obj, _, x)
    obj[property] = x / 200
end
clickUI.text = function(k, property, obj, _, x)
end
clickUI.textFunc = function(k, property, obj, _, x)
end
local getControls = {}
local doIfClick = function(k, x, y, exec)
    if(x > listPosX and y > listPosY+k*30 and y < listPosY+ 15 + k*30) then
        exec()
    end
end
getControls.engine = { {name = "enable", type="boolean", property="enabled"} }
getControls.fuelTank = { {name = "enable", type="boolean", property="enabled"}, {name="Fuel links", type="boolean", property="links"} }
getControls.cargo = {{type="textFunc", func=function(obj) return "CARGO: "..GETCARGO(obj.cargo) end}}

local function onClickCustom(list, x, y )
    for k, v in ipairs(list) do
        doIfClick(k, x, y, function() clickUI[v.type](k, v.property, selected, v.func, x-listPosX, y-listPosY) end)
    end
end

local function onClick(selected, x, y )
    for k, v in ipairs(getControls[selected.componentType]) do
        doIfClick(k, x, y, function() clickUI[v.type](k, v.property, selected, v.func, x-listPosX, y-listPosY) end)
    end
end
return {drawUI = drawUI, onClickCustom=onClickCustom, clickUI = clickUI, getControls=getControls, onClick = onClick, doIfClick = doIfClick, listPosX = listPosX, listPosY = listPosY}