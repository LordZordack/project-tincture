-- entities/camera.lua
-- Smooth-follow camera with lerp-based tracking.

local Camera = {}
Camera.__index = Camera

--- Create a new camera.
-- @param x number Initial x position (center of view)
-- @param y number Initial y position (center of view)
-- @return Camera
function Camera.new(x, y)
    local self = setmetatable({}, Camera)

    self.x = x or 0
    self.y = y or 0
    self.smoothness = 5 -- higher = snappier follow (lerp factor multiplied by dt)

    return self
end

--- Update camera position to follow a target.
-- @param dt number Delta time
-- @param target_x number Target x position
-- @param target_y number Target y position
function Camera:update(dt, target_x, target_y)
    local lerp = 1 - math.exp(-self.smoothness * dt)
    self.x = self.x + (target_x - self.x) * lerp
    self.y = self.y + (target_y - self.y) * lerp
end

--- Apply camera transform. Call at the start of love.draw before drawing world objects.
function Camera:apply()
    local w, h = love.graphics.getDimensions()
    love.graphics.push()
    love.graphics.translate(
        math.floor(w / 2 - self.x),
        math.floor(h / 2 - self.y)
    )
end

--- Remove camera transform. Call at the end of world drawing, before drawing HUD.
function Camera:release()
    love.graphics.pop()
end

--- Convert screen coordinates to world coordinates.
-- @param sx number Screen x
-- @param sy number Screen y
-- @return number, number World x, y
function Camera:screen_to_world(sx, sy)
    local w, h = love.graphics.getDimensions()
    return sx - w / 2 + self.x, sy - h / 2 + self.y
end

return Camera
