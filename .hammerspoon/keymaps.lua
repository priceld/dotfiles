-- Inspired by https://github.com/olimorris/dotfiles/blob/6bb130df56ba428fa1f1dbdf4d3c2b2c7b760e10/.config/hammerspoon/keymaps.lua
local meh = { "shift", "alt", "ctrl" }

------------------------------- APP LAUNCH/TOGGLE ------------------------------
--[[
  The list of keys and apps which enable launching and toggling
  Some apps have a different process name to their name on disk. To address
  this, a table can be passed which contains the app name followed by the filename
]]
local apps = {
	b = "Brave Browser", -- Browser
	c = { "Code", "Visual Studio Code" },
	-- d = "Discord",
	e = "Microsoft Outlook",
	f = "Finder",
	g = "Google Chrome",
	m = "Spotify", -- Music
	-- n = "Bear", -- Notes
	o = "Obsidian", -- Life OS
	-- p = "1Password",
	-- r = RESERVED
	s = "Slack",
	t = "Alacritty", -- Terminal
	-- v = "VLC", -- Video
	-- w = "word",
	-- z = "Todoist",
}

local LaunchOrToggle = function(key, app_name, app_filename)
	hs.hotkey.bind(meh, key, function()
		local app = hs.application.find(app_name)
		print(app)
		-- Toggle - show
		local awin = nil
		if app then
			awin = app:mainWindow()
		end
		-- Toggle - hide
		if awin and app and app:isFrontmost() then
		-- LP: I don't think I want this toggle functionality
		-- app:hide()
		else
			-- Launch
			if app_filename then
				return hs.application.launchOrFocus(app_filename)
			end

			app = hs.application.find(app_name)

			hs.application.launchOrFocus(app_name)
			app.setFrontmost(app)
			app.activate(app)
		end
	end)
end

for key, app_name in pairs(apps) do
	if type(app_name) == "table" then
		LaunchOrToggle(key, app_name[1], app_name[2])
	else
		LaunchOrToggle(key, app_name)
	end
end
