---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 6/24/23 12:11 PM
---


function add_weapon_to_player(ped, weaponName)
    local hash = GetHashKey(weaponName)
    GiveWeaponToPed(ped, hash, 100, true, true)
end

function add_weapon(weaponName)
    local ped = PlayerPedId()
    add_weapon_to_player(weaponName, ped)
end

function add_weapons(weapons)
    local ped = PlayerPedId()
    for _, weapon in pairs(weapons) do
        add_weapon_to_player(weapon, ped)
    end
end

function enable_pvp()
    SetCanAttackFriendly(PlayerPedId(), true, true)
    NetworkSetFriendlyFireOption(false)
end

function disable_pvp()
    SetCanAttackFriendly(PlayerPedId(), false, false)
    NetworkSetFriendlyFireOption(false)
end
