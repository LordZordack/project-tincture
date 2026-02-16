-- Conditional debugger support for Local Lua Debugger (Tom Blind)
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local Player = require("entities.player")
local Camera = require("entities.camera")
local Room   = require("systems.room")

-- Game state
local game = {
    player = nil,
    camera = nil,
    room   = nil,
}

-- Simple input reading (will be replaced by systems/input.lua in ticket 03)
local function read_input()
    local input = {}

    -- Movement (WASD) — orientation-relative axes
    input.forward = 0
    input.strafe = 0
    if love.keyboard.isDown("w") then input.forward = input.forward + 1 end
    if love.keyboard.isDown("s") then input.forward = input.forward - 1 end
    if love.keyboard.isDown("a") then input.strafe = input.strafe + 1 end
    if love.keyboard.isDown("d") then input.strafe = input.strafe - 1 end

    -- Aim (mouse in world space via camera conversion)
    local mx, my = love.mouse.getPosition()
    input.aim_x, input.aim_y = game.camera:screen_to_world(mx, my)

    -- Dash (Space) — pressed-this-frame flag
    input.dash = game._dash_pressed or false
    game._dash_pressed = false

    return input
end

-- LÖVE callbacks
function love.load()
    love.window.setTitle("Project Tincture")
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0.05, 0.05, 0.07)

    -- Create room (2000x1500 test arena)
    game.room = Room.new(2000, 1500)

    -- Spawn player at room center
    local cx, cy = game.room:center()
    game.player = Player.new(cx, cy)

    -- Camera starts at player position
    game.camera = Camera.new(cx, cy)

    print("Game loaded successfully!")
end

function love.update(dt)
    local input = read_input()

    -- Update player
    game.player:update(dt, input)

    -- Clamp player to room walls
    game.player.x, game.player.y = game.room:clamp(
        game.player.x, game.player.y, game.player.size
    )

    -- Camera follows player
    game.camera:update(dt, game.player.x, game.player.y)
end

function love.draw()
    -- World space (camera-transformed)
    game.camera:apply()
    game.room:draw()
    game.player:draw()
    game.camera:release()

    -- HUD (screen space)
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
    love.graphics.print("WASD: Move | Mouse: Aim | Space: Dash", 10, 30)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        game._dash_pressed = true
    end
end
