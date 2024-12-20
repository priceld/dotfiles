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
	b = "com.brave.Browser", -- Browser
	-- TODO: com.brave.Browser.beta -- Brave Beta
	c = { "Code", "Visual Studio Code" },
	e = "Microsoft Outlook",
	f = "Finder",
	-- g = "Google Chrome",
	m = "Spotify", -- [M]usic
	n = "com.microsoft.teams2", -- Teams ([N]ooooooooooo)
	o = "Obsidian", --
	p = "1Password",
	-- r = RESERVED
	s = "Slack",
	t = "Alacritty", -- [T]erminal
	u = "com.brave.Browser.beta", -- Brave Beta (for testing [U]ltra)
	-- TODO:
	-- ? = "special search mode" -- brings up a prompt to search active apps? the log the name to the console
}

--[[
--TODO: I would really like to improve my window management workflow. One thing
--that I think may be useful would be to have a shortcut for bringing an app up
--on the main screen, but allow the user to pick which app using the mappings
--above.
--So the flow would be like: type <shorcut> + <app>
--This would allow for a lot of flexibility without needing a million shortcuts
  ]]
local LaunchOrFocus = function(key, app_name, app_filename)
	local nextWindow = 1
	hs.hotkey.bind(meh, key, function()
		local app = hs.application.find(app_name)
		-- Toggle - show
		local awin = nil
		if app then
			awin = app:mainWindow()
		end
		if awin and app and app:isFrontmost() then
			-- If the app is already the formost application, then subsequent presses
			-- of the hotkey should cycle through the windows.
			-- NOTE: the result of `allWindows` changes based on what window is
			-- in front. So the act of raising a window, will change the result of
			-- the next call to `allWindows`. For this reason, we cannot simply
			-- increment `nextWindow` to get the next window. We can do that until we
			-- reach the end of the list, at which point the list will be the reverse
			-- of when we started and the next window to open will always be the last
			-- window in the list.
			local allWindows = app:allWindows()
			nextWindow = math.min(nextWindow + 1, #allWindows)
			awin = allWindows[nextWindow]
			if awin then
				awin:focus()
			end
		else
			-- Reset next window when bringing an app to the forefront
			nextWindow = 1
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
-- hs.window.raise() brings a window to the front but doesn't focus it.
local BringToFrontWithoutFocus = function(key, app_name, app_filename)
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
		-- Do nothing, this kinda defeats the purpose of this function
		else
			if not awin then
				return
			end

			awin:raise()
			-- TODO: cycle through windows
		end
	end)
end

for key, app_name in pairs(apps) do
	if type(app_name) == "table" then
		LaunchOrFocus(key, app_name[1], app_name[2])
		BringToFrontWithoutFocus(key, app_name[1], app_name[2])
	else
		LaunchOrFocus(key, app_name)
		BringToFrontWithoutFocus(key, app_name)
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
	for _, app in pairs(teamsApps) do
		hs.eventtap.keyStroke({ "cmd", "shift" }, "m", 200, app)
	end
end)
-- Leave an MS Teams call/meeting
hs.hotkey.bind(hyper, "l", function()
	local teamsApps = hs.application.applicationsForBundleID("com.microsoft.teams2")
	for _, app in pairs(teamsApps) do
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
