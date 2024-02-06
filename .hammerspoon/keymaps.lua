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
	e = "Microsoft Outlook",
	f = "Finder",
	g = "Google Chrome",
	m = "Spotify", -- Music
	o = "Obsidian", -- Life OS
	-- p = "1Password",
	-- r = RESERVED
	s = "Slack",
	t = "Alacritty", -- Terminal
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
			-- LP: I wonder if instead of hiding, we should cycle
			-- through windows.
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

-- Toggle my microphone mute for MS Teams.
-- This is a pretty naive approach. It loops over all the Teams applications
-- and sends the CMD+Shift+M shortcut to each of them. This shortcut does
-- nothing in the normal Teams window (the one with chats/channels), but for
-- a meeting window it toggles the microphone.
hs.hotkey.bind(hyper, "m", function()
	local teamsApps = hs.application.applicationsForBundleID("com.microsoft.teams2")
	for _, v in pairs(teamsApps) do
		local app = v
		hs.eventtap.keyStroke({ "cmd", "shift" }, "m", 200, app)
	end
end)
-- Leave an MS Teams call/meeting
hs.hotkey.bind(hyper, "l", function()
	local teamsApps = hs.application.applicationsForBundleID("com.microsoft.teams2")
	for _, v in pairs(teamsApps) do
		local app = v
		hs.eventtap.keyStroke({ "cmd", "shift" }, "h", 200, app)
	end
end)

-- Shortcut to toggle voice over!
--
-- Note that in order for this to work, I had to change the voice over modifier
-- to be just the caps lock key. Without this, I was able to turn voice over on
-- but could not turn it off because it thought I was using the voice over
-- modifier to send shortcuts to voice over. See:
-- https://support.apple.com/guide/voiceover/voiceover-modifier-unac048/10/mac/14.0
hs.hotkey.bind(hyper, "v", function()
	-- There's a setting under Settings > Keyboard > Keyboard Shortcuts > Function Keys
	-- that controls the default behavior of the function keys. Basically it dictates
	-- whether you need to hold the "fn" key to send F1, F2, etc.
	-- This setting seems to default to off, thus the "fn" is required here.
	hs.eventtap.keyStroke({ "cmd", "fn" }, "f5")
end)

-- From: https://github.com/mattorb/dotfiles/blob/3fc63f22005bf5298acbcdc8dfa5df89eb824693/hammerspoon/init.lua#L29-L45
-- Draw on screen. ctrl-alt-cmd+c/a/t.  (c)lear/(a)nnotate/(t)oggle
local drawonscreen = require("draw-on-screen")
-- This seems to work by registering a hot key to enter the draw-on-screen "mode"
-- That hotkey is Hyper+a
--
-- Once pressed, several aditional hotkeys are registered:
--  - Hyper+c (clear the screen)
--  - Hyper+t (toggle whether dragging the mouse draws on the screen)
--  - Hyper+a (exit draw-on-screen mode)
local hotkey = hs.hotkey.modal.new(hyper, "a")

function hotkey:entered()
	drawonscreen.start()
	drawonscreen.startAnnotating()
end

function hotkey:exited()
	drawonscreen.stopAnnotating()
	drawonscreen.hide()
end

hotkey:bind(hyper, "c", function()
	drawonscreen.clear()
end)
hotkey:bind(hyper, "a", function()
	hotkey:exit()
end)
hotkey:bind(hyper, "t", function()
	drawonscreen.toggleAnnotating()
end)
