ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    for nomejob, _ in pairs(KRS) do
        local societyName = 'society_' .. nomejob
        local societyLabel = nomejob:upper()
        TriggerEvent('esx_society:registerSociety', nomejob, societyLabel, societyName, societyName, societyName, { type = 'public' })
        print('Società registrata:', nomejob)
    end
end)

local inService = false

RegisterNetEvent("krs_duty:onduty")
AddEventHandler("krs_duty:onduty", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    local inservizio = job:gsub("off", "")
    
    if inservizio ~= job then
        xPlayer.setJob(inservizio, grade)
        xPlayer.showNotification("Sei entrato in servizio")
        inService = true
    else
        xPlayer.showNotification("Sei già in servizio")
    end
end)

RegisterNetEvent("krs_duty:offduty")
AddEventHandler("krs_duty:offduty", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.job.name
    local grade = xPlayer.job.grade
    local offJob = "off" .. job
    
    if offJob ~= job then
        xPlayer.setJob(offJob, grade)
        xPlayer.showNotification("Sei uscito di servizio")
        inService = false
    else
        xPlayer.showNotification("Non sei in servizio")
    end
end)
