-- require("config.hypr.utilities.multimedia")

-- Varibables for programs
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "~/.local/bin/rofi-menu"
local app_menu = "rofi -show drun"
local browser = "~/.local/bin/browser"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Start applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.exec_cmd("exec hyprctl kill"))
hl.bind(mainMod .. " + CTRL + SHIFT + Q", hl.dsp.exec_cmd("~/.local/bin/hypr-close-all-windows"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(app_menu))
hl.bind("CTRL + ALT + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.local/bin/rofi-powermenu"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + SHIFT + CTRL + ALT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + X", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.local/bin/restart-app waybar"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("~/.local/bin/nightlight-toggle hyprland"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("~/.local/bin/toggle-idle"))
hl.bind("Print", hl.dsp.exec_cmd("~/.local/bin/screenshot"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("~/.local/bin/screenshot window"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.local/bin/screenshot output"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("~/.local/bin/rofi-screenrecord"))
hl.bind("CTRL + ALT + Print", hl.dsp.exec_cmd("~/.local/bin/screenrecord"))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd("rofimoji"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd("hyprpicker | wl-copy"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal .. " -e ~/.local/bin/tmux-sessionizer"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.local/bin/hyprwall"))

-- Brightness and volume contorl
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.local/bin/brightness-control up"), { drag = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.local/bin/brightness-control down"), { drag = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.local/bin/volume-control up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.local/bin/volume-control down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.local/bin/volume-control mute"))
hl.bind(mainMod .. " + XF86AudioMute", hl.dsp.exec_cmd("~/.local/bin/switch-audio"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Let's get scrollin
-- Scrolling support for hyprland like niri-wm
hl.bind(mainMod .. " + SLASH", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-layout.sh"))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.layout("move -col"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Cycle through applications on active workspace
hl.bind(mainMod .. " + TAB", hl.dsp.window.cycle_next())

-- Resize active window
hl.bind(mainMod .. " + code:20", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind(mainMod .. " + code:21", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + code:20", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind(mainMod .. " + SHIFT + code:21", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())
