RegisterNetEvent('ac_switchjob:switchJob')
AddEventHandler('ac_switchjob:switchJob', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT secondjob, secondjob_grade FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)

		if result[1] ~= nil and result[1].secondjob ~= nil and result[1].secondjob_grade ~= nil then
			MySQL.Async.execute('UPDATE users SET secondjob = @secondjob, secondjob_grade = @secondjob_grade WHERE identifier = @identifier', { 
				['@secondjob'] = xPlayer.job.name,
				['@secondjob_grade'] = xPlayer.job.grade,
				['@identifier'] = xPlayer.identifier,
			}, function(rows)
				if rows ~= 0 then

					if Config.Discord.Enable then
						sendToDiscord(string.format(Config.Discord.Message, xPlayer.name, xPlayer.job.name..' `'..xPlayer.job.grade..'`', result[1].secondjob.. ' `'..result[1].secondjob_grade..'`'))
					end

					xPlayer.setJob(result[1].secondjob, result[1].secondjob_grade)
					xPlayer = ESX.GetPlayerFromId(xPlayer.source)

					if Config.SwitchMessage ~= '' then
						TriggerClientEvent('ac_switchjob:sendNotification', xPlayer.source, string.format(Config.SwitchMessage, xPlayer.job.label..': '..xPlayer.job.grade_label))
					end

				end
			end)
		end
	end)
end)



if Config.Discord.Enable then
	function sendToDiscord(msg)
		local embed = {{ ['color'] = Config.Discord.Color, ['description'] = msg }}
		PerformHttpRequest(Config.Discord.Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.Discord.Name, embeds = embed, avatar_url = Config.Discord.Image}), { ['Content-Type'] = 'application/json' })
	end
end



MySQL.ready(function()
	MySQL.Async.execute('ALTER TABLE users ADD COLUMN IF NOT EXISTS secondjob VARCHAR(50) NOT NULL DEFAULT "unemployed"')
	MySQL.Async.execute('ALTER TABLE users ADD COLUMN IF NOT EXISTS secondjob_grade INT(11) NOT NULL DEFAULT 0')
end)