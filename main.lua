-- Conditional debugger support for Local Lua Debugger (Tom Blind)
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- Game state
local game = {
    -- Add your game state variables here
}

-- LÖVE callbacks
function love.load()
    -- This function is called once at the start of the game
    love.window.setTitle("Hack-and-Slash Shooter")

    -- Set up graphics defaults
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)

    print("Game loaded successfully!")
end

function love.update(dt)
    -- This function is called every frame
    -- dt is the time since last frame (delta time) in seconds

    -- Update game logic here
end

function love.draw()
    -- This function is called every frame to render graphics

    -- Draw a simple placeholder
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Hack-and-Slash Shooter", 10, 10)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 30)
end

function love.keypressed(key, scancode, isrepeat)
    -- Handle key presses
    if key == "escape" then
        love.event.quit()
    end
end
