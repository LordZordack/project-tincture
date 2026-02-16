-- systems/combat.lua
-- Handles melee combat: attack input, hitboxes, damage, and cooldowns.

local Combat = {}
Combat.__index = Combat

--- Create a new combat system.
-- @return Combat
function Combat.new()
    local self = setmetatable({}, Combat)
    return self
end

--- Handle attack input.
-- @param player Player The player entity
-- @param intent table Input intent
-- @param item_manager ItemManager The item manager (to get active item)
-- @param targets table List of damageable entities (optional, for now using item_manager.items)
function Combat:handle_input(player, intent, item_manager, targets)
    if intent.attack then
        self:try_attack(player, item_manager, targets)
    end
end

--- Attempt to perform an attack.
function Combat:try_attack(player, item_manager, targets)
    local weapon = player:get_active_item()

    -- Calculate attack stats based on weapon (or unarmed)
    local weight = weapon and weapon.weight or 1
    local damage = weapon and weapon.damage or 1

    -- Heavier = slower swing, longer cooldown
    local duration = 0.2 + weight * 0.05
    local cooldown = 0.3 + weight * 0.1

    -- Try to start attack animation
    if player:attack(duration, cooldown) then
        -- Perform hit check immediately (instant hit for now, or could wait for mid-swing)
        -- For better feel, maybe hit check at 50% of swing?
        -- For simplicity in this ticking, we'll do it immediately but maybe delay the damage application?
        -- Let's do immediate for responsiveness.

        self:check_hits(player, weapon, targets or item_manager.items)
    end
end

--- Check for hits in the player's attack arc.
function Combat:check_hits(player, weapon, targets)
    local arc_angle = player.attack_arc_angle
    local range = 60 + (weapon and weapon:get_render_size() or 10)
    local damage = weapon and (weapon.damage + weapon.weight) or 2

    local px, py = player.x, player.y
    local facing = player.angle

    -- Check main weapon swing
    self:_check_arc_hit(px, py, facing, range, damage, arc_angle, targets)
end

--- Check if any target is within a circular sector (arc).
function Combat:_check_arc_hit(origin_x, origin_y, angle, range, damage, arc, targets)
    local half_arc = arc / 2

    for _, target in ipairs(targets) do
        -- Skip self/carried items (targets should be valid world entities)
        if target.is_on_ground and (target:is_on_ground() or target:is_thrown()) then
            -- Calculate angle and distance to target
            local dx = target.x - origin_x
            local dy = target.y - origin_y
            local dist_sq = dx * dx + dy * dy

            if dist_sq < range * range then
                local target_angle = math.atan2(dy, dx)
                local diff = math.abs(self:_angle_diff(angle, target_angle))

                if diff <= half_arc then
                    -- HIT!
                    if target.damage_durability then
                        local broke = target:damage_durability(damage)
                        if broke then
                            print("Smashed " .. target.name .. "!")
                        else
                            print("Hit " .. target.name .. " for " .. damage .. " damage!")
                        end

                        -- Simple knockback
                        local k = 100 * damage / (target.weight or 1) -- stronger push
                        target.x = target.x + math.cos(angle) * k * 0.1
                        target.y = target.y + math.sin(angle) * k * 0.1
                    end
                end
            end
        end
    end
end

function Combat:_angle_diff(a, b)
    local diff = (b - a) % (2 * math.pi)
    if diff > math.pi then diff = diff - 2 * math.pi end
    return diff
end

return Combat
