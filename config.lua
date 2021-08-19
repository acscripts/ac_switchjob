Config = {}


-- Command used to switch the job, without '/' symbol.
Config.CommandName = 'switchjob'

-- Cooldown to switchjob command, in seconds. To disable cooldown, use 0.
Config.Cooldown = 15

-- '%s' is automatically replaced by cooldown time remaining. Leave blank '' to disable.
Config.CooldownMessage = 'The job can be changed once every 15 seconds.\n%s seconds remaining.'

-- The notification style you want. You can use any commented preset (make sure to have the dependent script running) or change it to you favorite one.
function sendNotification(msg)

	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)													-- Default GTA V notification.
	DrawNotification(0, 1)

	-- exports['mythic_notify']:SendAlert('inform', msg)						-- https://github.com/wowpanda/mythic_notify
	-- exports['t-notify']:Alert({style = 'message', message = msg})			-- https://github.com/TasoOneAsia/t-notify
	-- exports['b1g_notify']:Notify('type', msg)								-- https://github.com/CarlosVergikosk/B1G_NOTIFY

end


if IsDuplicityVersion() then

	Config.Discord = {
		-- Change to false to disable Discord logging. If set to false, you can ignore the lines below.
		Enable = true,

		-- '%s' is automatically replaced in orded by player name, first job and second job.
		Message = '**%s** changed his job from **%s** to **%s**.',

		-- Discord webhook link.
		Webhook = '',

		-- Log message name.
		Name = 'ac_switchjob | LOG',

		-- Log message image.
		Image = 'https://i.imgur.com/PpJ0Ffh.png',

		-- Log embed color, in DECIMAL format. You can use this tool: https://www.rapidtables.com/convert/number/hex-to-decimal.html
		Color = 3092790
	}


	-- '%s' is automatically replaced by the new job. Leave blank '' to disable.
	Config.SwitchMessage = 'You are now employed as %s.'

end