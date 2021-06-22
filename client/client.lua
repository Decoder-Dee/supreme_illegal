
local NPC = {
    {model = "ig_g", x = 1397.19,  y = 3604.86,  z = 37.94, h = 0.0},
    {model = "csb_mweather", x = 1400.2,  y = 3603.3,  z = 37.94, h = 0.0},
    {model = "csb_mweather", x = 1397.85,  y = 3602.41,  z = 37.94, h = 0.0},
}


ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
    for _, v in pairs(NPC) do
        RequestModel(GetHashKey(v.model))
        while not HasModelLoaded(GetHashKey(v.model)) do
            Wait(1)
        end
        local npc = CreatePed(4, v.model, v.x, v.y, v.z, v.h,  false, true)
        SetPedFleeAttributes(npc, 0, 0)
        SetPedDropsWeaponsWhenDead(npc, false)
        SetPedDiesWhenInjured(npc, false)
        SetEntityInvincible(npc , true)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        if v.seller then 
            RequestAnimDict("missfbi_s4mop")
            while not HasAnimDictLoaded("missfbi_s4mop") do
                Wait(1)
            end
            TaskPlayAnim(npc, "missfbi_s4mop" ,"guard_idle_a" ,8.0, 1, -1, 49, 0, false, false, false)
        else
            GiveWeaponToPed(npc, GetHashKey("WEAPON_ASSAULTRIFLE"), 2800, true, true)
        end
    end
end)
    
RegisterNetEvent('supreme_illegal:OpenMenu', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Illegal Gun Shop",
            txt = ""
        },
        {
            id = 2,
            header = "Crowbar",
            txt = "$115",
            params = {
                event = "supreme_illegal:WeaponBuyNow",
                args = {
                    weaponName = 'WEAPON_CROWBAR',
					ammo = 1,
                                        price = 115,
                    
                }
            }
        },
        {
            id = 3,
            header = "Dagger",
            txt = "$200",
            params = {
                event = "supreme_illegal:WeaponBuyNow",
                args = {
                    weaponName = 'WEAPON_DAGGER',
					ammo = 1,
                                        price = 200,
                    
                }
            }
        },
        {
            id = 4,
            header = "Molotov's",
            txt = "$1700",
            params = {
                event = "supreme_illegal:WeaponBuyNow",
                args = {
                    weaponName = 'WEAPON_MOLOTOV',
					ammo = 1,
                                        price = 1700,
                    
                }
            }
        },
        {
            id = 5,
            header = "Pistol .50",
            txt = "$12800",
            params = {
                event = "supreme_illegal:WeaponBuyNow",
                args = {
                    weaponName = 'WEAPON_PISTOL50',
					ammo = 42,
                                        price = 12800,
                    
                }
            }
        },
        {
            id = 6,
            header = "Double Action Revolver",
            txt = "$16200",
            params = {
                event = "supreme_illegal:WeaponBuyNow",
                args = {
                    weaponName = 'WEAPON_DOUBLEACTION',
					ammo = 42,
                                        price = 16200,
                    
                }
            }
        },
        {
            id = 7,
            header = "Sawn Off Shotgun",
            txt = "$22500",
            params = {
                event = "supreme_illegal:WeaponBuyNow",
                args = {
                    weaponName = 'WEAPON_SAWNOFFSHOTGUN',
					ammo = 42,
                                        price = 22500,
                    
                }
            }
        },
        {
            id = 8,
            header = "Mini SMG",
            txt = "$25000",
            params = {
                event = "supreme_illegal:WeaponBuyNow",
                args = {
                    weaponName = 'WEAPON_MINISMG',
					ammo = 42,
                                        price = 25000,
                    
                }
            }
        },
        {
            id = 9,
            header = "Gusenberg Sweeper",
            txt = "$50000",
            params = {
                event = "supreme_illegal:WeaponBuyNow",
                args = {
                    weaponName = 'WEAPON_GUSENBERG',
					ammo = 42,
                                        price = 50000,
                    
                }
            }
        },
    })
end)

    local peds = {
        `ig_g`,
    }

exports['bt-target']:AddTargetModel(peds, {
        options = {
       	{
        event = "supreme_illegal:OpenMenu",
        icon = "fas fa-shopping-cart",
        label = "Buy Items",
        },        	
    },
        job = {"all"},
        distance = 4.5
    })


RegisterNetEvent('supreme_illegal:WeaponBuyNow')
AddEventHandler('supreme_illegal:WeaponBuyNow', function(data)
    local weaponName = data.weaponName
    local ammo = data.ammo
    local price = data.price
    TriggerServerEvent('supreme_illegal:WeaponBuy', weaponName, ammo, price)
end)  
