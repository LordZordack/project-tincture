-- Conditional debugger support for Local Lua Debugger (Tom Blind)
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local Player      = require("entities.player")
local Camera      = require("entities.camera")
local Room        = require("systems.room")
local Input       = require("systems.input")
local Item        = require("entities.item")
local ItemManager = require("systems.item_manager")
local Combat      = require("systems.combat")

-- Game state
local game = {
    player       = nil,
    camera       = nil,
    room         = nil,
    input        = nil,
    item_manager = nil,
    combat       = nil,
}

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

    -- Input system (needs camera for screen-to-world conversion)
    game.input = Input.new(game.camera)

    -- Spawn test items around the room
    local test_items = {
        Item.new({ name = "Iron Sword", weight = 3, damage = 8, rarity = "UNCOMMON", x = cx - 100, y = cy - 80 }),
        Item.new({ name = "Health Potion", weight = 1, damage = 0, rarity = "COMMON", x = cx + 120, y = cy - 50,
            consumable = { type = "healing", amount = 30 } }),
        Item.new({ name = "Battle Axe", weight = 7, damage = 15, rarity = "RARE", x = cx + 200, y = cy + 100 }),
        Item.new({ name = "Crown", weight = 2, damage = 1, rarity = "EPIC", x = cx - 150, y = cy + 120,
            equip_slot = "head", protection = 3 }),
        Item.new({ name = "Ancient Blade", weight = 5, damage = 20, rarity = "LEGENDARY", x = cx, y = cy + 200 }),
        Item.new({ name = "Glass Vial", weight = 1, damage = 2, rarity = "COMMON", x = cx + 50, y = cy - 120,
            durability = 10, color = { 0.8, 0.9, 1.0 } }),
    }
    game.item_manager = ItemManager.new(test_items)

    -- Combat system
    game.combat = Combat.new()

    print("Game loaded successfully!")
end

function love.update(dt)
    local intent = game.input:read()

    -- Item interactions (pickup, drop, swap, throw)
    game.item_manager:handle_interact(game.player, intent)
    game.item_manager:handle_swap(game.player, intent)
    game.item_manager:handle_throw(game.player, intent)

    -- Combat (melee attack)
    game.combat:handle_input(game.player, intent, game.item_manager, game.item_manager.items)

    -- Update player
    game.player:update(dt, intent)

    -- Clamp player to room walls
    game.player.x, game.player.y = game.room:clamp(
        game.player.x, game.player.y, game.player.size
    )

    -- Update items (thrown projectiles)
    game.item_manager:update(dt)

    -- Camera follows player
    game.camera:update(dt, game.player.x, game.player.y)
end

function love.draw()
    -- World space (camera-transformed)
    game.camera:apply()
    game.room:draw()
    game.item_manager:draw()
    game.player:draw()
    game.camera:release()

    -- HUD (screen space)
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
    love.graphics.print("WASD: Move | Mouse: Aim | Space: Dash", 10, 30)
    love.graphics.print("E: Pick up / Drop | Tab: Swap | Q: Throw", 10, 50)
    love.graphics.print("LMB: Attack | RMB: Block", 10, 110)

    -- Carry info
    local count = game.player:carry_count()
    local weight = game.player:total_carried_weight()
    love.graphics.print(string.format("Carrying: %d/3  Weight: %.0f", count, weight), 10, 70)
    local active = game.player:get_active_item()
    if active then
        love.graphics.print("Active: " .. active.name, 10, 90)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    -- Forward to input system for pressed-this-frame tracking
    game.input:on_keypressed(key)
end

function love.mousepressed(x, y, button)
    -- Forward to input system for pressed-this-frame tracking
    game.input:on_mousepressed(button)
end
