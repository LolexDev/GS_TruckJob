function progressbar(message, time,dict,clip,scenario)
    lib.progressCircle({
        duration = time,
        position = 'bottom',
        label = message,
        useWhileDead = false,
        canCancel = false,
        disable = {
          move = true,
          combat = true,
          mouse = false,
          car = true,
        },
        anim = {
          dict = dict,
          clip = clip,
          scenario = scenario
        }
      })
end

function progressbar2(message, time,scenario)
  lib.progressCircle({
      duration = time,
      position = 'bottom',
      label = message,
      useWhileDead = false,
      canCancel = false,
      disable = {
        move = true,
        combat = true,
        mouse = false,
        car = true,
      },
      anim = {
        scenario = scenario
      }
    })
end

function progressbar3(message, time)
  lib.progressCircle({
      duration = time,
      position = 'bottom',
      label = message,
      useWhileDead = false,
      canCancel = false,
      disable = {
        move = true,
        combat = true,
        mouse = false,
        car = true,
      },
    })
end

function obavesti(naslov,deskripcija,type,pozicija,vreme)
    lib.notify({
        title = naslov,
        description = deskripcija,
        type = type,
        position = pozicija,
        duration = vreme,
    })
end

function SetWaypointToStation(index)
  local station = Config.DeliveryLocations[tostring(index)]
  if station then
    SetNewWaypoint(station.coords.x, station.coords.y)
  end
end