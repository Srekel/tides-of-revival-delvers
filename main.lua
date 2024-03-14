if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end


function love.load()
    love.window.setMode(1280, 720)
end

function love.draw()
    love.graphics.clear(0.1, 0.05, 0)

    height = love.graphics.getHeight()
    width = love.graphics.getWidth()

    love.graphics.setColor(0.35, 0.35, 1)

    love.graphics.polygon("fill",
        0, 0,
        width, 0,
        width, height * (0.5 + cameraY * 0.1), 0,
        height * (0.5 + cameraY * 0.1))


    love.graphics.setColor(1, 1, 0)
    love.graphics.print("Gold: " .. tostring(gold), 20, 20)
end

cameraY = -2
gold = 1000

function love.update(dt)
    -- cameraY = cameraY - dt * 0.1
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end
