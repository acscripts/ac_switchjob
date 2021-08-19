local timer = 0
local allowCommand = true

RegisterCommand(Config.CommandName, function()
	if timer == 0 and allowCommand then
		TriggerServerEvent('ac_switchjob:switchJob')
		timer = Config.Cooldown
		if timer > 0 then
			allowCommand = false
			switchJobTimer()
		end
	else
		if Config.CooldownMessage ~= '' then
			sendNotification(string.format(Config.CooldownMessage, timer))
		end
	end
end)

function switchJobTimer()
	while timer > 0 do
		if timer > 1 then
			timer = timer - 1
		elseif timer == 1 then
			allowCommand = true
			timer = 0
		end
		Citizen.Wait(1000)
	end
end

RegisterNetEvent('ac_switchjob:sendNotification')
AddEventHandler('ac_switchjob:sendNotification', function(msg)
	sendNotification(msg)
end)