-- Conditional debugger support for Local Lua Debugger (Tom Blind)
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local Player = require("entities.player")

-- Game state
local game = {
    player = nil,
}

-- Simple input reading (will be replaced by systems/input.lua in ticket 03)
local function read_input()
    local input = {}

    -- Movement (WASD) — raw input axes (forward/back/strafe)
    -- These are orientation-relative: forward = W, backward = S, strafe left = A, strafe right = D
    input.forward = 0
    input.strafe = 0
    if love.keyboard.isDown("w") then input.forward = input.forward + 1 end
    if love.keyboard.isDown("s") then input.forward = input.forward - 1 end
    if love.keyboard.isDown("a") then input.strafe = input.strafe + 1 end
    if love.keyboard.isDown("d") then input.strafe = input.strafe - 1 end

    -- Aim (mouse position in world space — no camera yet, so screen = world)
    input.aim_x, input.aim_y = love.mouse.getPosition()

    -- Dash (Space) — use pressed-this-frame flag
    input.dash = game._dash_pressed or false
    game._dash_pressed = false

    return input
end

-- LÖVE callbacks
function love.load()
    love.window.setTitle("Project Tincture")
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0.08, 0.08, 0.1)

    -- Spawn player at center of screen
    local w, h = love.graphics.getDimensions()
    game.player = Player.new(w / 2, h / 2)

    print("Game loaded successfully!")
end

function love.update(dt)
    local input = read_input()
    game.player:update(dt, input)
end

function love.draw()
    -- Draw player
    game.player:draw()

    -- HUD
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
