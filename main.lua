if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local grid_width = 16 * 10
local grid_height = 9 * 10
local grid_scale = 10
local grid_wobbliness = 0.15
local cavern_count = 5

local grid_coordinates = {}
local grid_visible = {}
local caverns = {}

local cameraY = 0
local gold = 1000

function love.load()
    love.window.setMode(1280, 720)

    for x = 0, grid_width - 1 do
        for y = 0, grid_height - 1 do
            index = 1 + x + y * grid_width
            grid_coordinates[index] = {
                x + love.math.random() * grid_wobbliness,
                y + love.math.random() * grid_wobbliness,
                0.1 + love.math.random() * 0.05, -- r
                0.1 + love.math.random() * 0.05, -- g
                0.0 + love.math.random() * 0.05  -- b
            }
        end
    end

    for x = 0, grid_width - 1 do
        for y = 0, grid_height - 1 do
            index = 1 + x + y * grid_width
            grid_visible[index] = true
            if love.math.random() < 0.05 then
                grid_visible[index] = false
            end
        end
    end

    for c = 1, cavern_count do
        caverns[c] = {
            love.math.random() * 1000,
            love.math.random() * 1000,
            love.math.random() * 100,
        }
    end
end

function love.draw()
    love.graphics.clear(0.1, 0.05, 0)

    local height = love.graphics.getHeight()
    local width = love.graphics.getWidth()

    love.graphics.setColor(0.35, 0.35, 1)

    love.graphics.polygon("fill",
        0, 0,
        width, 0,
        width, height * (0.5 + cameraY * 0.1), 0,
        height * (0.5 + cameraY * 0.1))

    love.graphics.setColor(0.7, 0.7, 0)
    for c = 1, #caverns - 1 do
        local cavern = caverns[c]
        love.graphics.ellipse("fill", cavern[1], cavern[2], cavern[3], cavern[3], 10)
    end

    for x = 0, grid_width - 2 do
        for y = 0, grid_height - 2 do
            local index = 1 + x + y * grid_width
            if not grid_visible[index] then
                goto continue
            end
            local vert1 = 1 + (x + 0) + (y + 0) * grid_width
            local vert2 = 1 + (x + 0) + (y + 1) * grid_width
            local vert3 = 1 + (x + 1) + (y + 1) * grid_width
            local vert4 = 1 + (x + 1) + (y + 0) * grid_width


            local coord1 = grid_coordinates[vert1]
            local coord2 = grid_coordinates[vert2]
            local coord3 = grid_coordinates[vert3]
            local coord4 = grid_coordinates[vert4]

            love.graphics.setColor(coord1[3], coord1[4], coord1[5])
            love.graphics.polygon("fill",
                10 + coord1[1] * grid_scale, 10 + coord1[2] * grid_scale,
                10 + coord2[1] * grid_scale, 10 + coord2[2] * grid_scale,
                10 + coord3[1] * grid_scale, 10 + coord3[2] * grid_scale
            )

            love.graphics.setColor(coord2[3], coord2[4], coord2[5])
            love.graphics.polygon("fill",
                10 + coord1[1] * grid_scale, 10 + coord1[2] * grid_scale,
                10 + coord3[1] * grid_scale, 10 + coord3[2] * grid_scale,
                10 + coord4[1] * grid_scale, 10 + coord4[2] * grid_scale
            )

            ::continue::
        end
    end

    love.graphics.setColor(1, 1, 0)
    love.graphics.print("Gold: " .. tostring(gold), 20, 20)
end

function love.update(dt)
    cameraY = cameraY - dt * 0.1
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end
