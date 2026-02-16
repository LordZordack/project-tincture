-- systems/room.lua
-- Rectangular walled room with collision.

local Room = {}
Room.__index = Room

--- Create a new room.
-- @param width number Room width in pixels
-- @param height number Room height in pixels
-- @return Room
function Room.new(width, height)
    local self = setmetatable({}, Room)

    self.width = width or 2000
    self.height = height or 1500
    self.wall_thickness = 20

    -- Colors
    self.floor_color = { 0.1, 0.1, 0.12 }
    self.wall_color = { 0.3, 0.25, 0.2 }

    return self
end

--- Clamp an entity's position to stay within the room walls.
-- @param x number Entity x position
-- @param y number Entity y position
-- @param radius number Entity collision radius
-- @return number, number Clamped x, y
function Room:clamp(x, y, radius)
    local min_x = self.wall_thickness + radius
    local min_y = self.wall_thickness + radius
    local max_x = self.width - self.wall_thickness - radius
    local max_y = self.height - self.wall_thickness - radius

    x = math.max(min_x, math.min(max_x, x))
    y = math.max(min_y, math.min(max_y, y))

    return x, y
end

--- Get the center of the room.
-- @return number, number Center x, y
function Room:center()
    return self.width / 2, self.height / 2
end

--- Draw the room (floor and walls).
function Room:draw()
    -- Floor
    love.graphics.setColor(self.floor_color)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)

    -- Walls (4 rectangles around the perimeter)
    love.graphics.setColor(self.wall_color)
    local t = self.wall_thickness
    -- Top wall
    love.graphics.rectangle("fill", 0, 0, self.width, t)
    -- Bottom wall
    love.graphics.rectangle("fill", 0, self.height - t, self.width, t)
    -- Left wall
    love.graphics.rectangle("fill", 0, 0, t, self.height)
    -- Right wall
    love.graphics.rectangle("fill", self.width - t, 0, t, self.height)

    -- Subtle wall edge lines for depth
    love.graphics.setColor(0.4, 0.35, 0.3, 0.5)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle("line", t, t, self.width - 2 * t, self.height - 2 * t)
end

return Room
