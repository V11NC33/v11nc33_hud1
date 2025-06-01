local QBCore = exports['qb-core']:GetCoreObject()

-- QBCore.Commands.Add('nakit', 'Cebindeki Parayı Görüntüler', {}, false, function(source, _)
--     local Player = QBCore.Functions.GetPlayer(source)
--     local cashamount = Player.PlayerData.money.cash
--     TriggerClientEvent('hud:client:ShowAccounts', source, 'cash', cashamount)
-- end)

-- QBCore.Commands.Add('banka', 'Bankadaki Parayı Görüntüler', {}, false, function(source, _)
--     local Player = QBCore.Functions.GetPlayer(source)
--     local bankamount = Player.PlayerData.money.bank
--     TriggerClientEvent('hud:client:ShowAccounts', source, 'bank', bankamount)
-- end)

-- AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
--     if item == "harness" and count < 1 then
--         TriggerClientEvent('remove:harness', source)
--     end
-- end)

RegisterServerEvent("qb-hud:GiveMoneyServer", function(id, para)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local TargetId = id
    local PlayerPos = GetEntityCoords(GetPlayerPed(src))
    local Target = QBCore.Functions.GetPlayer(TargetId)
    local TargetPos = GetEntityCoords(GetPlayerPed(TargetId))
    local amount = para

    if Target ~= nil then
      if amount ~= nil then
        if amount > 0 then
          if Player.PlayerData.money.cash >= amount and amount > 0 then
            if #(PlayerPos - TargetPos) < 3 then
              if TargetId ~= source then
                Player.Functions.RemoveMoney('cash', amount, "Cash given to "..Player.PlayerData.citizenid)
                Target.Functions.AddMoney('cash', amount, "Nakit Para Aldı Parayı Veren:"..Player.PlayerData.charinfo.firstname .. " " ..Player.PlayerData.charinfo.lastname)
                TriggerClientEvent('QBCore:Notify', TargetId, Player.PlayerData.charinfo.firstname.." sana " .. amount .. "$ nakit para verdi!", 'success')
                TriggerClientEvent('QBCore:Notify', source, Target.PlayerData.charinfo.firstname.." isimli kişiye " .. amount .. "$ nakit para verdin!", 'success')
                TriggerEvent("DiscordBot:ToDiscord", "paratransfer", "Para verdi: "..amount.."$", source, TargetId)
              else
                TriggerClientEvent('chatMessage', source, "Sistem", "error", "Kendine para veremezsin!")
              end
            else
              TriggerClientEvent('chatMessage', source, "Sistem", "error", "Nakit vereceğin oyuncu yanında değil!")
            end
          else
            TriggerClientEvent('chatMessage', source, "Sistem", "error", "Yeteri kadar paran yok!")
          end
        else
          TriggerClientEvent('chatMessage', source, "Sistem", "error", "Miktar sıfırdan büyük olmalı!")
        end
      else
        TriggerClientEvent('chatMessage', source, "Sistem", "error", "Bir miktar yazman lazım!")
      end
    else
      TriggerClientEvent('chatMessage', source, "Sistem", "error", "Oyuncu online değil!")
    end
end)