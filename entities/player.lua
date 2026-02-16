-- entities/player.lua
-- Player entity: colored triangle with WASD movement, mouse-aim, turn delay, dash, and carry system.

local Item = require("entities.item")

local Player = {}
Player.__index = Player

--- Create a new player entity.
-- @param x number Starting x position
-- @param y number Starting y position
-- @return Player
function Player.new(x, y)
    local self = setmetatable({}, Player)

    -- Position
    self.x = x
    self.y = y

    -- Orientation (radians, 0 = right, increases counter-clockwise)
    self.angle = 0 -- current visual angle
    self.target_angle = 0 -- angle toward mouse cursor

    -- Movement
    self.base_speed = 200 -- base movement speed (px/s)
    self.forward_multiplier = 1.0 -- speed multiplier when moving in facing direction
    self.strafe_multiplier = 0.7 -- speed multiplier when moving perpendicular
    self.backward_multiplier = 0.5 -- speed multiplier when moving backward

    -- Turn delay
    self.turn_speed = 8.0 -- radians per second of max turn rate (higher = snappier)

    -- Dash
    self.dash_speed = 600 -- dash speed (px/s)
    self.dash_duration = 0.15 -- how long the dash lasts (seconds)
    self.dash_cooldown = 0.6 -- time between dashes (seconds)
    self.dash_timer = 0 -- remaining dash time
    self.dash_cooldown_timer = 0 -- remaining cooldown time
    self.dash_dir_x = 0 -- dash direction (normalized)
    self.dash_dir_y = 0
    self.is_dashing = false
    self.is_invincible = false -- true during dash

    -- Appearance
    self.size = 20 -- triangle "radius"
    self.color = { 0.2, 0.7, 1.0 } -- light blue

    -- Carry system
    self.carry_strength = 10 -- max weight per item that can be picked up
    self.carried = {} -- array of up to 3 carried items (index 1 = active)
    self.orbit_angle = 0 -- current angle for orbiting items animation
    self.orbit_speed = 2.0 -- radians/sec for orbit rotation
    self.orbit_radius = 35 -- distance from player center for orbiting items
    self.active_item_distance = 25 -- distance forward for active item

    return self
end

--- Shortest signed angle between two angles (result in [-pi, pi]).
local function angle_diff(from, to)
    local diff = (to - from) % (2 * math.pi)
    if diff > math.pi then
        diff = diff - 2 * math.pi
    end
    return diff
end

--- Compute the directional speed multiplier based on movement direction vs facing.
-- @param move_angle number Direction of movement (radians)
-- @param facing_angle number Direction the player faces (radians)
-- @return number Speed multiplier
function Player:_dir_speed_mult(move_angle, facing_angle)
    local diff = math.abs(angle_diff(facing_angle, move_angle))
    -- 0 = forward (1.0x), pi/2 = strafe (0.7x), pi = backward (0.5x)
    if diff < math.pi / 4 then
        return self.forward_multiplier
    elseif diff < 3 * math.pi / 4 then
        return self.strafe_multiplier
    else
        return self.backward_multiplier
    end
end

--- Update the player each frame.
-- @param dt number Delta time
-- @param input table Intent table from input system (or simple key reads for now)
function Player:update(dt, input)
    -- 1. Orientation: smooth turn toward mouse cursor
    self:_update_orientation(dt, input)

    -- 2. Dash timers
    self:_update_dash(dt, input)

    -- 3. Movement
    self:_update_movement(dt, input)

    -- 4. Update orbit animation
    self.orbit_angle = self.orbit_angle + self.orbit_speed * dt
end

function Player:_update_orientation(dt, input)
    if input.aim_x and input.aim_y then
        self.target_angle = math.atan2(input.aim_y - self.y, input.aim_x - self.x)
    end

    local diff = angle_diff(self.angle, self.target_angle)
    local max_turn = self.turn_speed * dt

    if math.abs(diff) <= max_turn then
        self.angle = self.target_angle
    else
        if diff > 0 then
            self.angle = self.angle + max_turn
        else
            self.angle = self.angle - max_turn
        end
    end
end

function Player:_update_dash(dt, input)
    -- Cooldown countdown
    if self.dash_cooldown_timer > 0 then
        self.dash_cooldown_timer = self.dash_cooldown_timer - dt
    end

    -- Active dash countdown
    if self.is_dashing then
        self.dash_timer = self.dash_timer - dt
        if self.dash_timer <= 0 then
            self.is_dashing = false
            self.is_invincible = false
        end
        return -- don't start a new dash while dashing
    end

    -- Start dash
    if input.dash and self.dash_cooldown_timer <= 0 then
        -- Dash in movement direction (orientation-relative), or facing direction if no movement
        local fwd = (input.forward or 0)
        local strafe = (input.strafe or 0)
        if fwd ~= 0 or strafe ~= 0 then
            -- Convert orientation-relative to world-space
            local cos_a = math.cos(self.angle)
            local sin_a = math.sin(self.angle)
            local dx = fwd * cos_a + strafe * sin_a
            local dy = fwd * sin_a - strafe * cos_a
            local len = math.sqrt(dx * dx + dy * dy)
            self.dash_dir_x = dx / len
            self.dash_dir_y = dy / len
        else
            self.dash_dir_x = math.cos(self.angle)
            self.dash_dir_y = math.sin(self.angle)
        end
        self.is_dashing = true
        self.is_invincible = true
        self.dash_timer = self.dash_duration
        self.dash_cooldown_timer = self.dash_cooldown
    end
end

function Player:_update_movement(dt, input)
    if self.is_dashing then
        -- During dash: move in dash direction at dash speed
        self.x = self.x + self.dash_dir_x * self.dash_speed * dt
        self.y = self.y + self.dash_dir_y * self.dash_speed * dt
        return
    end

    -- Orientation-relative movement
    local fwd = (input.forward or 0) -- +1 = forward (W), -1 = backward (S)
    local strafe = (input.strafe or 0) -- +1 = right (D), -1 = left (A)
    if fwd == 0 and strafe == 0 then return end

    -- Determine speed multiplier based on dominant input direction
    local speed_mult
    if math.abs(fwd) > math.abs(strafe) then
        speed_mult = fwd > 0 and self.forward_multiplier or self.backward_multiplier
    else
        speed_mult = self.strafe_multiplier
    end

    -- Convert orientation-relative input to world-space direction
    -- Forward direction = self.angle, strafe right = self.angle + pi/2
    local cos_a = math.cos(self.angle)
    local sin_a = math.sin(self.angle)

    local dx = fwd * cos_a + strafe * sin_a
    local dy = fwd * sin_a - strafe * cos_a

    -- Normalize to prevent diagonal speed boost
    local len = math.sqrt(dx * dx + dy * dy)
    if len > 0 then
        dx = dx / len
        dy = dy / len
    end

    local speed = self.base_speed * speed_mult * self:_weight_speed_factor()

    self.x = self.x + dx * speed * dt
    self.y = self.y + dy * speed * dt
end

--- Get total weight of all carried items.
function Player:total_carried_weight()
    local total = 0
    for _, item in ipairs(self.carried) do
        total = total + item.weight
    end
    return total
end

--- Speed factor based on carried weight (1.0 = no items, 0.5 = very heavy).
function Player:_weight_speed_factor()
    local weight = self:total_carried_weight()
    if weight <= 0 then return 1.0 end
    -- Each unit of weight reduces speed by ~3%, capped at 50% reduction
    return math.max(0.5, 1.0 - weight * 0.03)
end

--- How many items is the player carrying?
function Player:carry_count()
    return #self.carried
end

--- Pick up an item (adds to carried slots).
-- @param item Item The item to pick up
function Player:pick_up(item)
    if #self.carried >= 3 then return false end

    table.insert(self.carried, item)
    -- Assign state based on slot
    self:_update_carry_states()
    return true
end

--- Drop the active item (index 1). Returns the dropped item or nil.
function Player:drop_active()
    if #self.carried == 0 then return nil end
    local item = table.remove(self.carried, 1)
    self:_update_carry_states()
    return item
end

--- Swap: cycle carried items so the next one becomes active.
function Player:swap_active()
    if #self.carried <= 1 then return end
    -- Rotate: move first to end
    local first = table.remove(self.carried, 1)
    table.insert(self.carried, first)
    self:_update_carry_states()
end

--- Update item states to match their carry slot position.
function Player:_update_carry_states()
    for i, item in ipairs(self.carried) do
        if i == 1 then
            item:set_state(Item.STATES.CARRIED_ACTIVE)
        elseif i == 2 then
            item:set_state(Item.STATES.CARRIED_ORBIT1)
        elseif i == 3 then
            item:set_state(Item.STATES.CARRIED_ORBIT2)
        end
    end
end

--- Get the active (front) item, or nil.
function Player:get_active_item()
    return self.carried[1]
end

--- Draw the player as a triangle pointing in the facing direction.
function Player:draw()
    -- Draw orbiting items first (behind player)
    self:_draw_carried_items()

    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(self.angle)

    -- Dash flash: brighter during dash
    if self.is_dashing then
        love.graphics.setColor(1, 1, 1, 0.9)
    else
        love.graphics.setColor(self.color[1], self.color[2], self.color[3])
    end

    -- Triangle: tip at front, flat back
    local s = self.size
    local vertices = {
        s, 0, -- tip (forward)
        -s * 0.6, -s * 0.5, -- back-left
        -s * 0.6, s * 0.5, -- back-right
    }
    love.graphics.polygon("fill", vertices)

    -- Outline
    love.graphics.setColor(1, 1, 1, 0.4)
    love.graphics.polygon("line", vertices)

    love.graphics.pop()

    -- Dash cooldown indicator (small dot when on cooldown)
    if self.dash_cooldown_timer > 0 then
        love.graphics.setColor(0.5, 0.5, 0.5, 0.5)
        love.graphics.circle("fill", self.x, self.y - self.size - 8, 3)
    else
        love.graphics.setColor(1, 1, 1, 0.7)
        love.graphics.circle("fill", self.x, self.y - self.size - 8, 3)
    end
end

--- Draw carried items: active in front, orbit items around player with brother glow.
function Player:_draw_carried_items()
    for i, item in ipairs(self.carried) do
        if i == 1 then
            -- Active item: floats in front of the player
            local ix = self.x + math.cos(self.angle) * self.active_item_distance
            local iy = self.y + math.sin(self.angle) * self.active_item_distance
            item:draw_at(ix, iy)
        else
            -- Orbiting items: positioned at fixed angles offset from orbit_angle
            local orbit_offset = (i == 2) and 0 or math.pi -- opposite sides
            local a = self.orbit_angle + orbit_offset
            local ix = self.x + math.cos(a) * self.orbit_radius
            local iy = self.y + math.sin(a) * self.orbit_radius

            -- Brother glow (faint aura around orbiting items)
            local glow_color = (i == 2)
                and { 0.6, 0.8, 1.0, 0.15 } -- Enas: cool blue glow
                or { 1.0, 0.8, 0.6, 0.15 } -- Dyo: warm amber glow
            love.graphics.setColor(glow_color)
            love.graphics.circle("fill", ix, iy, item:get_render_size() + 8)

            item:draw_at(ix, iy)
        end
    end
end

return Player
