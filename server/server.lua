ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('supreme_illegal:WeaponBuy')
AddEventHandler('supreme_illegal:WeaponBuy', function(weaponName, ammo, price)
    local xPlayer  = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= price then
        xPlayer.addWeapon(weaponName, ammo)
        xPlayer.removeMoney(price)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You paid ' .. price, })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Not enough money', })
    end
end)