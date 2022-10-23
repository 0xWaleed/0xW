---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 10/20/22 8:33 PM
---

local g_state = dsyncro.new()

g_state:onKeySet(function(instance, key, value)
    TriggerEvent('0xW:state:changed', g_state:rawItems())
end)

g_state.mutator.health = function(value)
    if value >= 100 then
        return value - 100
    end
    return 0
end

function register_entity_damage_handler(callback)
    AddEventHandler('gameEventTriggered', function(name, data)
        if name ~= 'CEventNetworkEntityDamage' then
            return
        end
        local victim     = data[1]
        local attacker   = data[2]
        local unknown    = data[3]
        local isDead     = data[4] == 1
        local weaponHash = data[5]
        callback(victim, attacker, unknown, isDead, weaponHash)
    end)
end

function register_entity_damage_handler_for_current_client(callback)
    register_entity_damage_handler(function(victim, ...)
        if PlayerPedId() ~= victim then
            return
        end
        return callback(victim, ...)
    end)
end

register_entity_damage_handler_for_current_client(function(victim, attacker, _, isDead, weaponHash)
    local health   = GetEntityHealth(victim)
    local armour   = GetPedArmour(victim)

    g_state.health = health
    g_state.armour = armour
    g_state.isDead = isDead
end)

g_state.serverId = GetPlayerServerId(PlayerId())

AddEventHandler('playerSpawned', function()
    local pedId    = PlayerPedId()
    local health   = GetEntityHealth(pedId)
    local armour   = GetPedArmour(pedId)

    g_state.isDead = false
    g_state.health = health
    g_state.armour = armour
end)
