-- systems/input.lua
-- Centralized input mapping system with rebindable keys.
-- Returns structured intent data each frame.

local Input = {}
Input.__index = Input

--- Default key bindings.
-- Each action maps to a key name (love.keyboard key constants) or mouse button.
local DEFAULT_BINDINGS = {
    -- Movement
    forward      = { type = "key", key = "w" },
    backward     = { type = "key", key = "s" },
    strafe_left  = { type = "key", key = "a" },
    strafe_right = { type = "key", key = "d" },

    -- Actions
    attack    = { type = "mouse", button = 1 }, -- left click
    block     = { type = "mouse", button = 2 }, -- right click
    throw     = { type = "key", key = "q" },
    consume   = { type = "key", key = "f" },
    swap      = { type = "key", key = "tab" },
    dash      = { type = "key", key = "space" },
    interact  = { type = "key", key = "e" },
    inventory = { type = "key", key = "i" },
}

--- Create a new input system.
-- @param camera Camera reference for screen-to-world conversion
-- @return Input
function Input.new(camera)
    local self = setmetatable({}, Input)

    self.camera = camera
    self.bindings = {}

    -- Deep copy default bindings
    for action, binding in pairs(DEFAULT_BINDINGS) do
        self.bindings[action] = { type = binding.type, key = binding.key, button = binding.button }
    end

    -- Pressed-this-frame tracking (for actions that should fire once, not repeat while held)
    self._pressed = {}
    self._mouse_pressed = {}

    return self
end

--- Rebind an action to a new key.
-- @param action string Action name (e.g. "forward", "attack")
-- @param key string New key name
function Input:rebind_key(action, key)
    if self.bindings[action] then
        self.bindings[action] = { type = "key", key = key }
    end
end

--- Rebind an action to a mouse button.
-- @param action string Action name
-- @param button number Mouse button (1=left, 2=right, 3=middle)
function Input:rebind_mouse(action, button)
    if self.bindings[action] then
        self.bindings[action] = { type = "mouse", button = button }
    end
end

--- Call from love.keypressed to track pressed-this-frame events.
-- @param key string Key that was pressed
function Input:on_keypressed(key)
    self._pressed[key] = true
end

--- Call from love.mousepressed to track pressed-this-frame events.
-- @param button number Mouse button
function Input:on_mousepressed(button)
    self._mouse_pressed[button] = true
end

--- Check if a binding is currently held down.
-- @param action string Action name
-- @return boolean
function Input:_is_held(action)
    local b = self.bindings[action]
    if not b then return false end
    if b.type == "key" then
        return love.keyboard.isDown(b.key)
    elseif b.type == "mouse" then
        return love.mouse.isDown(b.button)
    end
    return false
end

--- Check if a binding was pressed this frame.
-- @param action string Action name
-- @return boolean
function Input:_was_pressed(action)
    local b = self.bindings[action]
    if not b then return false end
    if b.type == "key" then
        return self._pressed[b.key] or false
    elseif b.type == "mouse" then
        return self._mouse_pressed[b.button] or false
    end
    return false
end

--- Read all inputs and return a structured intent table.
-- Call once per frame in love.update.
-- @return table Intent table
function Input:read()
    local intent = {}

    -- Movement (orientation-relative axes)
    intent.forward = 0
    intent.strafe = 0
    if self:_is_held("forward") then intent.forward = intent.forward + 1 end
    if self:_is_held("backward") then intent.forward = intent.forward - 1 end
    if self:_is_held("strafe_left") then intent.strafe = intent.strafe + 1 end
    if self:_is_held("strafe_right") then intent.strafe = intent.strafe - 1 end

    -- Aim (mouse in world space)
    local mx, my = love.mouse.getPosition()
    intent.aim_x, intent.aim_y = self.camera:screen_to_world(mx, my)

    -- Actions: pressed-this-frame (fire once)
    intent.dash      = self:_was_pressed("dash")
    intent.attack    = self:_was_pressed("attack")
    intent.throw     = self:_was_pressed("throw")
    intent.consume   = self:_was_pressed("consume")
    intent.swap      = self:_was_pressed("swap")
    intent.interact  = self:_was_pressed("interact")
    intent.inventory = self:_was_pressed("inventory")

    -- Block: held (active while holding)
    intent.block = self:_is_held("block")

    -- Clear pressed-this-frame state
    self._pressed = {}
    self._mouse_pressed = {}

    return intent
end

--- Get the current binding for an action (for display in settings UI).
-- @param action string Action name
-- @return table Binding { type, key/button }
function Input:get_binding(action)
    return self.bindings[action]
end

--- Get a human-readable string for a binding.
-- @param action string Action name
-- @return string Display string
function Input:get_binding_display(action)
    local b = self.bindings[action]
    if not b then return "unbound" end
    if b.type == "key" then
        return b.key:upper()
    elseif b.type == "mouse" then
        local names = { [1] = "LMB", [2] = "RMB", [3] = "MMB" }
        return names[b.button] or ("Mouse " .. b.button)
    end
    return "?"
end

return Input
