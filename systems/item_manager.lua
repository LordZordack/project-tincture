-- systems/item_manager.lua
-- Manages all items in the current room: pickup, drop, swap, throw, and carry rendering.

local Item = require("entities.item")

local ItemManager = {}
ItemManager.__index = ItemManager

local PICKUP_RADIUS = 50 -- how close the player must be to pick up an item

--- Create a new item manager.
-- @param items table Array of Item instances in the room
-- @return ItemManager
function ItemManager.new(items)
    local self = setmetatable({}, ItemManager)
    self.items = items or {}
    return self
end

--- Add an item to the manager.
function ItemManager:add(item)
    table.insert(self.items, item)
end

--- Remove an item from the manager (e.g. broken item).
function ItemManager:remove(item)
    for i, it in ipairs(self.items) do
        if it == item then
            table.remove(self.items, i)
            return
        end
    end
end

--- Find the closest ground item within pickup range of a position.
-- @param x number World x
-- @param y number World y
-- @return Item|nil, number|nil  Closest item and distance
function ItemManager:find_nearest_ground_item(x, y)
    local best_item = nil
    local best_dist = PICKUP_RADIUS

    for _, item in ipairs(self.items) do
        if item:is_on_ground() then
            local dx = item.x - x
            local dy = item.y - y
            local dist = math.sqrt(dx * dx + dy * dy)
            if dist < best_dist then
                best_dist = dist
                best_item = item
            end
        end
    end

    return best_item, best_dist
end

--- Try to pick up a nearby item for the player.
-- @param player Player The player entity
-- @return boolean True if an item was picked up
function ItemManager:try_pickup(player)
    -- If player already has 3 items, can't pick up more
    if player:carry_count() >= 3 then
        return false
    end

    local item = self:find_nearest_ground_item(player.x, player.y)
    if not item then return false end

    -- Check weight against carry strength
    if item.weight > player.carry_strength then
        return false
    end

    -- Pick it up
    player:pick_up(item)
    return true
end

--- Drop the player's active item to the ground.
-- @param player Player The player entity
-- @return boolean True if an item was dropped
function ItemManager:try_drop(player)
    local item = player:drop_active()
    if not item then return false end

    -- Place item at player's position
    item.x = player.x + math.cos(player.angle) * 30
    item.y = player.y + math.sin(player.angle) * 30
    item:set_state(Item.STATES.GROUND)
    return true
end

--- Swap the player's active item (cycle through carried items).
-- @param player Player The player entity
function ItemManager:try_swap(player)
    player:swap_active()
end

--- Handle interact input: pickup if near item, drop if already carrying.
-- @param player Player The player entity
-- @param intent table Input intent
function ItemManager:handle_interact(player, intent)
    if not intent.interact then return end

    -- If near a ground item, try to pick it up
    local nearby = self:find_nearest_ground_item(player.x, player.y)
    if nearby then
        self:try_pickup(player)
    else
        -- Otherwise, drop active item
        self:try_drop(player)
    end
end

--- Handle swap input.
-- @param player Player The player entity
-- @param intent table Input intent
function ItemManager:handle_swap(player, intent)
    if intent.swap then
        self:try_swap(player)
    end
end

--- Update all items. Removes broken items.
-- @param dt number Delta time
function ItemManager:update(dt)
    local i = 1
    while i <= #self.items do
        local result = self.items[i]:update(dt)
        if result == "broke" then
            table.remove(self.items, i)
            -- don't increment i, next item slides into this position
        else
            i = i + 1
        end
    end
end

--- Draw all ground/thrown items.
function ItemManager:draw()
    for _, item in ipairs(self.items) do
        item:draw()
    end
end

--- Try to throw the player's active item.
-- @param player Player The player entity
-- @return boolean True if an item was thrown
function ItemManager:try_throw(player)
    local item = player:get_active_item()
    if not item then return false end

    -- Check if item can be thrown (weight-based)
    if not item.throwable then return false end

    -- Remove from player's carried items
    player:drop_active() -- removes from carried array

    -- Set starting position to in front of the player
    item.x = player.x + math.cos(player.angle) * player.active_item_distance
    item.y = player.y + math.sin(player.angle) * player.active_item_distance

    -- Launch as projectile in player's facing direction (inheriting velocity)
    local vx, vy = player:get_velocity()
    item:throw(player.angle, vx, vy)
    return true
end

--- Handle throw input.
-- @param player Player The player entity
-- @param intent table Input intent
function ItemManager:handle_throw(player, intent)
    if intent.throw then
        self:try_throw(player)
    end
end

return ItemManager
