ESX = exports["es_extended"]:getSharedObject()


local PlayerData = {}

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

function openDuty()
    SendNUIMessage({
        type = "openDuty"
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback('chiudi', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('onduty', function(data, cb)
    TriggerServerEvent('krs_duty:onduty')
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('offduty', function(data, cb)
    TriggerServerEvent('krs_duty:offduty')
    SetNuiFocus(false, false)
    cb('ok')
end)

Citizen.CreateThread(function()
    if not HasModelLoaded(KRS.NpcDutyName) then
        RequestModel(KRS.NpcDutyName)
        while not HasModelLoaded(KRS.NpcDutyName) do
            Citizen.Wait(5)
        end
    end

    npc = CreatePed(4, KRS.NpcDutyName, KRS.NpcDutyPos, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)

    local MenuDuty = {
        {
            icon = 'fa-solid fa-info',
            label = 'Entra / Esci',
            onSelect = function(data)
                openDuty()
                SetNuiFocus(true, true)
            end,
            canInteract = function(entity, distance, coords, name, bone)
                return not IsEntityDead(entity)
            end
        }
    }

    exports.ox_target:addLocalEntity(npc, MenuDuty)
end)
