-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RENDIÇÃO - APERTAR M
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function NaoMostrarMensagemPassageiro(Jogador)
    local MeuCarro = GetVehiclePedIsIn(Jogador, false)
    for i = -2, GetVehicleMaxNumberOfPassengers(MeuCarro) do
        if(GetPedInVehicleSeat(MeuCarro, i) == Jogador) then return i end
    end
    return - 2
end

Citizen.CreateThread(function()
  local handsup = false
  
  while true do
      Citizen.Wait(0)
      if IsControlJustPressed(1, 244) then
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and NaoMostrarMensagemPassageiro(GetPlayerPed(-1)) == -1 then
            exports.pNotify:SendNotification({
                text = "Você não pode se render em um veículo",
                type = "info",timeout = 3000,progressBar = false, layout = "centerLeft",queue = "left",
                animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}
            })
        else
            local player = GetPlayerPed( -1 )
            loadAnimDict( "random@arrests" )
            loadAnimDict( "random@arrests@busted" )
            if not handsup then
                TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (3000)
                TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
                handsup = true
            else
                handsup = false
                TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (4000)
                TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (500)
                TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
                Wait (1000)
                TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
            end
        end
    end
end
end)

function loadAnimDict( dict )
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
      Citizen.Wait(100)
  end
end
