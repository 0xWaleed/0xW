---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 10/22/22 6:40 PM
---

AddEventHandler('0xW:state:changed', function(items)
    SendNUIMessage({ message = 'state', state = items })
end)
