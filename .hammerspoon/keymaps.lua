-- Inspired by https://github.com/olimorris/dotfiles/blob/6bb130df56ba428fa1f1dbdf4d3c2b2c7b760e10/.config/hammerspoon/keymaps.lua
local meh = { "shift", "alt", "ctrl" }
local hyper = { "cmd", "shift", "alt", "ctrl" }
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

local LaunchOrFocus = function(key, app_name, app_filename)
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

-- I had thought it would be cool to have q function that brings a window
-- to the font (e.g. if it is on the other monitor) without switching focus
-- to it. I often want this when I need to look at another window for reference.
-- At a brief look at the documentation, it isn't immediately obvious how to
-- accomplish this.
-- TODO: this is not working
local BringToFront = function(key, app_name, app_filename)
	hs.hotkey.bind(hyper, key, function()
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
			-- TODO LP
			-- if app_filename then
			-- 	return hs.application.launchOrFocus(app_filename)
			-- end

			app = hs.application.find(app_name)
			app.unhide()
			-- hs.application.launchOrFocus(app_name)
			-- app.setFrontmost(app)
			-- app.activate(app)
		end
	end)
end

for key, app_name in pairs(apps) do
	if type(app_name) == "table" then
		LaunchOrFocus(key, app_name[1], app_name[2])
		BringToFront(key, app_name[1], app_name[2])
	else
		LaunchOrFocus(key, app_name)
		BringToFront(key, app_name)
	end
end

-- https://stackoverflow.com/questions/54151343/how-to-move-an-application-between-monitors-in-hammerspoon
function moveWindowToDisplay(d)
	return function()
		local displays = hs.screen.allScreens()
		local win = hs.window.focusedWindow()
		win:moveToScreen(displays[d], false, true)
	end
end

hs.hotkey.bind(meh, "1", moveWindowToDisplay(1))
hs.hotkey.bind(meh, "2", moveWindowToDisplay(2))
