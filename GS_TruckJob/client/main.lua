--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
--─██████████████─████████████████───██████████████─██████──██████─██████████████────██████████████─██████████████─████████████████───██████████─██████████████─██████████████─██████████████─
--─██░░░░░░░░░░██─██░░░░░░░░░░░░██───██░░░░░░░░░░██─██░░██──██░░██─██░░░░░░░░░░██────██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░██───██░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─
--─██░░██████████─██░░████████░░██───██░░██████░░██─██░░██──██░░██─██░░██████████────██░░██████████─██░░██████████─██░░████████░░██───████░░████─██░░██████░░██─██████░░██████─██░░██████████─
--─██░░██─────────██░░██────██░░██───██░░██──██░░██─██░░██──██░░██─██░░██────────────██░░██─────────██░░██─────────██░░██────██░░██─────██░░██───██░░██──██░░██─────██░░██─────██░░██─────────
--─██░░██─────────██░░████████░░██───██░░██──██░░██─██░░██──██░░██─██░░██████████────██░░██████████─██░░██─────────██░░████████░░██─────██░░██───██░░██████░░██─────██░░██─────██░░██████████─
--─██░░██──██████─██░░░░░░░░░░░░██───██░░██──██░░██─██░░██──██░░██─██░░░░░░░░░░██────██░░░░░░░░░░██─██░░██─────────██░░░░░░░░░░░░██─────██░░██───██░░░░░░░░░░██─────██░░██─────██░░░░░░░░░░██─
--─██░░██──██░░██─██░░██████░░████───██░░██──██░░██─██░░██──██░░██─██░░██████████────██████████░░██─██░░██─────────██░░██████░░████─────██░░██───██░░██████████─────██░░██─────██████████░░██─
--─██░░██──██░░██─██░░██──██░░██─────██░░██──██░░██─██░░░░██░░░░██─██░░██────────────────────██░░██─██░░██─────────██░░██──██░░██───────██░░██───██░░██─────────────██░░██─────────────██░░██─
--─██░░██████░░██─██░░██──██░░██████─██░░██████░░██─████░░░░░░████─██░░██████████────██████████░░██─██░░██████████─██░░██──██░░██████─████░░████─██░░██─────────────██░░██─────██████████░░██─
--─██░░░░░░░░░░██─██░░██──██░░░░░░██─██░░░░░░░░░░██───████░░████───██░░░░░░░░░░██────██░░░░░░░░░░██─██░░░░░░░░░░██─██░░██──██░░░░░░██─██░░░░░░██─██░░██─────────────██░░██─────██░░░░░░░░░░██─
--─██████████████─██████──██████████─██████████████─────██████─────██████████████────██████████████─██████████████─██████──██████████─██████████─██████─────────────██████─────██████████████─
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

_tr = TranslateCap
local started = false
local tookVehicle = false
local currentLocation = 1
local earned = 0

Citizen.CreateThread(function ()
    for i, v in pairs(Config.Blipovi) do
        local blip = AddBlipForCoord(v.Kordinate.x, v.Kordinate.y, v.Kordinate.z)

        SetBlipSprite(blip, v.Ikonica)

        if v.Boja ~= nil then
            SetBlipColour(blip, v.Boja)
        end

        SetBlipDisplay(blip, v.Pokazuj)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Ime)  -- Stavi ime blipu
        EndTextCommandSetBlipName(blip)


        local display = v.Pokazuj

        SetBlipDisplay(blip, display)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config.Peds) do
      RequestModel(GetHashKey(v.hash))
      while not HasModelLoaded(GetHashKey(v.hash)) do
        Wait(500)
      end
      Ped = CreatePed(4, v.hash, vector3(v.coords.x, v.coords.y, v.coords.z - 1) , v.coords.w, false, true)
      FreezeEntityPosition(Ped, true) 
      SetEntityInvincible(Ped, true)
      SetBlockingOfNonTemporaryEvents(Ped, true)
        exports.qtarget:AddBoxZone('boss', vector3(v.coords.x, v.coords.y, v.coords.z - 1), v.coords.w, 1.0, {
            name= 'boss',
            heading= v.coords.w,
            debugPoly= Config.Debug,
            minZ= v.coords.z -1,
            maxZ= v.coords.z +2,
            }, {
              options = {
                {
                  action = function()
                    TriggerEvent('GS_TruckJob:jm')
                  end,
                  icon = v.icon,
                  label = _tr('bosstext'), 
                },
              },
              distance = 2.0
          })
      end
end)

RegisterNetEvent('GS_TruckJob:jm', function ()
    lib.registerContext({
        id = 'jobmenu',
        title = _tr('dutytitle'),
        options = {
          {
            title = _tr('leaveduty'),
            description = '',
            icon = 'fa-solid fa-xmark',
            onSelect = function ()
                if not tookVehicle then
                    started = false
                    obavesti(_tr('company'),_tr('paycheck')..earned..'$','inform','top',3000)
                    TriggerServerEvent('GS_TruckJob:gp',earned)
                else
                    obavesti(_tr('company'),_tr('notparked'),'warning','top',3000)
                end
            end,
            disabled = not started
          },
          {
            title = _tr('joindutytitle'),
            description = '',
            icon = 'fa-solid fa-check',
            onSelect = function ()
              started = true
              TriggerEvent('GS_TruckJob:iv')
              tookVehicle = true
            end,
            disabled = started,
          },
        }
      })
      lib.showContext('jobmenu')
end)

RegisterNetEvent('GS_TruckJob:iv', function()
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
        Wait(100)
    end
    DoScreenFadeIn(800)
    for k,v in pairs(Config.Garage) do 
        ESX.Game.SpawnVehicle(v.vehicleModel, vector3(v.coordstospawn.x, v.coordstospawn.y, v.coordstospawn.z), v.coordstospawn.w, function(vehicle)
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        end)
    end
    currentLocation = 1
    SetWaypointToStation(currentLocation)
end)

local textUI = {}

CreateThread(function()
    while true do
        local sleep = 1500
        for k, v in pairs(Config.Garage) do
            local distanca = #(GetEntityCoords(PlayerPedId()) - vector3(v.coordstopark.x, v.coordstopark.y, v.coordstopark.z))
            if distanca < 5.0 and IsPedInAnyVehicle(PlayerPedId(), false) then
                if not textUI[k] and tookVehicle and IsPedInAnyVehicle(PlayerPedId(),true) then
                    lib.showTextUI("[E] - ".._tr('parkveh'))
                    textUI[k] = true
                end
                sleep = 0
                if IsControlJustReleased(0, 38) then
                    lib.hideTextUI()
                    TriggerEvent('GS_TruckJob:pv')
                end
            else
                if textUI[k] then
                    lib.hideTextUI()
                    textUI[k] = nil
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1500
        for k, v in pairs(Config.DeliveryLocations) do
            local distanca = #(GetEntityCoords(PlayerPedId()) - vector3(v.coords.x, v.coords.y, v.coords.z))
            if distanca < 5.0 and started and tookVehicle and not v.delivered then
                if not textUI[k] then
                    lib.showTextUI("[E] - ".._tr('deliver'))
                    textUI[k] = true
                end
                sleep = 0
                if IsControlJustReleased(0, 38) then
                    if not IsPedInAnyVehicle(PlayerPedId(),true) then
                        lib.hideTextUI()
                        Deliver(v.reward)
                        v.delivered = true
                        if v.last then
                            obavesti(_tr('company'),_tr('returntocompany'),'inform','top',4000)
                        end
                    else
                        obavesti(_tr('company'),_tr('leaveveh'),'inform','top',3000)
                    end
                end
            else
                if textUI[k] then
                    lib.hideTextUI()
                    textUI[k] = nil
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent("GS_TruckJob:pv", function ()
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
        Wait(100)
    end
    DoScreenFadeIn(800)
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    if IsPedInAnyVehicle(PlayerPedId(), false) and GetEntityModel(veh) == GetHashKey(Config.Garage.vehicleModel) then
        ESX.Game.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(),true))
        obavesti(_tr('company'),_tr('vehparked'),'success','top',2000)
        tookVehicle = false
    else
        
    end
end)

function Deliver(gs1)
    earned = earned + gs1
    obavesti(_tr('company'),_tr('earned')..earned..'$','inform','top',3000)
    local newStationIndex = currentLocation + 1
    currentLocation = newStationIndex
    SetWaypointToStation(currentLocation)
end

RegisterCommand('dadni', function ()
    earned = earned + 100
end)