-- entities/item.lua
-- Item data model. Every interactable object in the game world is an Item.

local Item = {}
Item.__index = Item

-- Valid item states
Item.STATES = {
    GROUND         = "ground",
    CARRIED_ACTIVE = "carried_active",
    CARRIED_ORBIT1 = "carried_orbit1",
    CARRIED_ORBIT2 = "carried_orbit2",
    EQUIPPED       = "equipped",
    THROWN         = "thrown",
}

-- Valid equip slots
Item.SLOTS = {
    HEAD      = "head",
    BODY      = "body",
    LEGS      = "legs",
    ACCESSORY = "accessory",
}

-- Rarity tiers and their display colors
Item.RARITY = {
    COMMON    = { name = "Common", color = { 0.6, 0.6, 0.6 } },
    UNCOMMON  = { name = "Uncommon", color = { 0.3, 0.8, 0.3 } },
    RARE      = { name = "Rare", color = { 0.3, 0.5, 1.0 } },
    EPIC      = { name = "Epic", color = { 0.7, 0.3, 0.9 } },
    LEGENDARY = { name = "Legendary", color = { 1.0, 0.8, 0.2 } },
}

--- Create a new item from a definition table.
-- @param def table Item definition with any of the following keys:
--   name (string), weight (number), damage (number), protection (number),
--   durability (number), max_durability (number), value (number),
--   rarity (string), throwable (bool), consumable (bool|table),
--   equip_slot (string|nil), color (table), x (number), y (number)
-- @return Item
function Item.new(def)
    def = def or {}
    local self = setmetatable({}, Item)

    -- Identity
    self.name = def.name or "Unknown Item"

    -- Qualities
    self.weight         = def.weight or 1
    self.damage         = def.damage or 0
    self.protection     = def.protection or 0
    self.durability     = def.durability or 100
    self.max_durability = def.max_durability or self.durability
    self.value          = def.value or 0
    self.rarity         = def.rarity or "COMMON"
    self.throwable      = def.throwable ~= nil and def.throwable or (self.weight <= 5)
    self.consumable     = def.consumable or false -- false, or table {type, effect, ...}
    self.equip_slot     = def.equip_slot or nil -- nil = not equippable

    -- Position (world space, for ground/thrown states)
    self.x = def.x or 0
    self.y = def.y or 0

    -- State
    self.state = def.state or Item.STATES.GROUND

    -- Thrown state (velocity for projectile movement)
    self.vel_x = 0
    self.vel_y = 0
    self.thrown_distance = 0
    self.throw_base_speed = 500 -- base throw speed (lighter = closer to this)
    self.throw_impact_durability = 15 -- durability lost on impact

    -- Appearance
    self.color = def.color or self:_rarity_color()

    return self
end

--- Get the rarity color for this item.
function Item:_rarity_color()
    local r = Item.RARITY[self.rarity]
    if r then return { r.color[1], r.color[2], r.color[3] } end
    return { 0.6, 0.6, 0.6 }
end

--- Visual size based on weight. Heavier items are larger.
-- @return number Radius in pixels
function Item:get_render_size()
    return math.max(4, math.min(20, 4 + self.weight * 1.5))
end

--- Change the item's state.
-- @param new_state string One of Item.STATES
function Item:set_state(new_state)
    self.state = new_state
end

--- Check if the item is on the ground.
function Item:is_on_ground()
    return self.state == Item.STATES.GROUND
end

--- Check if the item is being carried.
function Item:is_carried()
    return self.state == Item.STATES.CARRIED_ACTIVE
        or self.state == Item.STATES.CARRIED_ORBIT1
        or self.state == Item.STATES.CARRIED_ORBIT2
end

--- Check if the item is equipped.
function Item:is_equipped()
    return self.state == Item.STATES.EQUIPPED
end

--- Check if the item is a thrown projectile.
function Item:is_thrown()
    return self.state == Item.STATES.THROWN
end

--- Check if the item can be equipped to a body slot.
function Item:is_equippable()
    return self.equip_slot ~= nil
end

--- Apply durability damage. Returns true if item broke.
-- @param amount number Durability to subtract
-- @return boolean True if item broke (durability <= 0)
function Item:damage_durability(amount)
    self.durability = self.durability - amount
    if self.durability <= 0 then
        self.durability = 0
        return true -- broke
    end
    return false
end

--- Launch the item as a thrown projectile.
-- @param angle number Direction to throw (radians)
-- @param ivx number Inherited velocity x (default 0)
-- @param ivy number Inherited velocity y (default 0)
function Item:throw(angle, ivx, ivy)
    self:set_state(Item.STATES.THROWN)
    -- Heavier items fly slower and shorter
    local speed = self.throw_base_speed / (1 + self.weight * 0.3)
    self.vel_x = math.cos(angle) * speed + (ivx or 0)
    self.vel_y = math.sin(angle) * speed + (ivy or 0)
    self.thrown_distance = 0
    self.max_throw_distance = 200 + (10 - math.min(self.weight, 9)) * 30 -- lighter = farther
end

--- Update item (for thrown projectiles).
-- @param dt number Delta time
-- @return string|nil  "landed" if it just landed, "broke" if it broke on impact
function Item:update(dt)
    if self.state == Item.STATES.THROWN then
        self.x = self.x + self.vel_x * dt
        self.y = self.y + self.vel_y * dt
        local speed = math.sqrt(self.vel_x * self.vel_x + self.vel_y * self.vel_y)
        self.thrown_distance = self.thrown_distance + speed * dt
        if self.thrown_distance >= self.max_throw_distance then
            self.vel_x = 0
            self.vel_y = 0
            self.thrown_distance = 0
            -- Impact: check durability
            local broke = self:damage_durability(self.throw_impact_durability)
            if broke then
                return "broke"
            else
                self:set_state(Item.STATES.GROUND)
                return "landed"
            end
        end
    end
    return nil
end

--- Draw the item (when on the ground or thrown).
function Item:draw()
    if self.state ~= Item.STATES.GROUND and self.state ~= Item.STATES.THROWN then
        return -- carried/equipped items are drawn by their owner
    end

    local size = self:get_render_size()

    -- Item shape: small diamond/square rotated 45°
    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(math.pi / 4)

    -- Fill
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], 0.9)
    love.graphics.rectangle("fill", -size / 2, -size / 2, size, size)

    -- Outline
    love.graphics.setColor(1, 1, 1, 0.3)
    love.graphics.rectangle("line", -size / 2, -size / 2, size, size)

    love.graphics.pop()

    -- Ground glow (subtle pulse to indicate interactability)
    if self.state == Item.STATES.GROUND then
        local pulse = 0.15 + 0.1 * math.sin(love.timer.getTime() * 3)
        love.graphics.setColor(self.color[1], self.color[2], self.color[3], pulse)
        love.graphics.circle("fill", self.x, self.y, size + 4)
    end
end

--- Draw the item at a specific position (for carried/orbit rendering by the holder).
-- @param x number World x
-- @param y number World y
-- @param scale number Optional scale multiplier (default 1)
function Item:draw_at(x, y, scale)
    scale = scale or 1
    local size = self:get_render_size() * scale

    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(math.pi / 4)

    love.graphics.setColor(self.color[1], self.color[2], self.color[3], 0.9)
    love.graphics.rectangle("fill", -size / 2, -size / 2, size, size)

    love.graphics.setColor(1, 1, 1, 0.3)
    love.graphics.rectangle("line", -size / 2, -size / 2, size, size)

    love.graphics.pop()
end

return Item
