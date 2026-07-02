-- Source: ~/.config/hypr/utilities/multimedia.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("config.hypr.utilities.multimedia")

-- Varibables for programs
local terminal = "kitty"
local fileManager = "XDG_CURRENT_DESKTOP=KDE dolphin"
local music_player = "XDG_CURRENT_DESKTOP=KDE strawberry"
local menu = "~/.local/bin/rofi-menu"
local app_menu = "rofi -show drun"
local browser = "~/.local/bin/browser"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Start applications
hl.bind(mainMod .. " + RETURN", hl.dsp("exec", terminal), { drag = true })
hl.bind(mainMod .. " + Q", hl.dsp("killactive", ""), { drag = true })
hl.bind(mainMod .. " + CTRL + Q", hl.dsp("exec", "hyprctl kill"), { drag = true })
hl.bind(mainMod .. " + CTRL + SHIFT + Q", hl.dsp("exec", "~/.local/bin/hypr-close-all-windows"), { drag = true })
hl.bind(mainMod .. " + E", hl.dsp.Launch_file_manager("exec", fileManager), { drag = true })
hl.bind(mainMod .. " + B", hl.dsp.Launch_default_browser("exec", browser), { drag = true })
hl.bind("ALT + SPACE", hl.dsp.Launch_list_of_installed_apps("exec", app_menu), { drag = true })
hl.bind("CTRL + ALT + SPACE", hl.dsp.Launch_list_of_options("exec", menu), { drag = true })
hl.bind(mainMod .. " + P", hl.dsp.Power_menu("exec", "~/.local/bin/rofi-powermenu"), { drag = true })
hl.bind(mainMod .. " + ALT + L", hl.dsp.Lockscreen_with_hyprlock("exec", "hyprlock"), { drag = true })

hl.bind(mainMod .. " + SHIFT + CTRL + ALT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + X", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.Full_screen("fullscreen", 0), { drag = true })
hl.bind("SUPER + CTRL + F", hl.dsp.Tiled_full_screen("fullscreenstate", "0 2"), { drag = true })
hl.bind("SUPER + SHIFT + F", hl.dsp.Full_width("fullscreen", 1), { drag = true })
hl.bind("SUPER + SHIFT + X", hl.dsp.Toggle_window_floating_tiling("togglefloating", ""), { drag = true })
hl.bind(mainMod .. " + R", hl.dsp.Restart_waybar("exec", "~/.local/bin/restart-app waybar"), { drag = true })
hl.bind(mainMod .. " + N", hl.dsp.Toggle_nightlight("exec", "~/.local/bin/nightlight-toggle hyprland"), { drag = true })
hl.bind(mainMod .. " + I", hl.dsp.Toggle_Hypridle("exec", "~/.local/bin/toggle-idle"), { drag = true })
hl.bind("Print", hl.dsp.Take_a_screenshot_of_region("exec", "~/.local/bin/screenshot"), { drag = true })
hl.bind("CTRL + Print", hl.dsp.Take_a_screenshot_of_window("exec", "~/.local/bin/screenshot window"), { drag = true })
hl.bind("SHIFT + Print", hl.dsp.Take_a_screenshot_of_output("exec", "~/.local/bin/screenshot output"), { drag = true })
hl.bind("ALT + Print", hl.dsp.Take_a_screenrecording("exec", "~/.local/bin/rofi-screenrecord"), { drag = true })
hl.bind("CTRL + ALT + Print", hl.dsp.Stop_recording("exec", "~/.local/bin/screenrecord"), { drag = true })
hl.bind(mainMod .. " + PERIOD", hl.dsp.Emoji_picker("exec", "rofimoji"), { drag = true })
hl.bind(
	mainMod .. " + V",
	hl.dsp.Clipboard_history("exec", "cliphist list | rofi -dmenu | cliphist decode | wl-copy"),
	{ drag = true }
)
hl.bind(mainMod .. " + CTRL + C", hl.dsp.Color_picker("exec", "hyprpicker | wl-copy"), { drag = true })
hl.bind(
	mainMod .. " + T",
	hl.dsp.Tmux_sessionizer("exec", terminal .. " -e ~/.local/bin/tmux-sessionizer"),
	{ drag = true }
)
hl.bind(mainMod .. " + W", hl.dsp.Change_wallpaper("exec", "~/.local/bin/hyprwall"), { drag = true })
hl.bind(mainMod .. " + O", hl.dsp.Launch_Obsidian("exec", "obsidian"), { drag = true })

-- Brightness and volume contorl
-- TODO: manual review on line 52 — no mapping for dispatcher "Increase brightness"
-- hl.bind("XF86MonBrightnessUp", hl.dsp.Increase_brightness("exec", "~/.local/bin/brightness-control up"), { drag = true })
-- TODO: manual review on line 53 — no mapping for dispatcher "Decrease brightness"
-- hl.bind("XF86MonBrightnessDown", hl.dsp.Decrease_brightness("exec", "~/.local/bin/brightness-control down"), { drag = true })

-- TODO: manual review on line 55 — no mapping for dispatcher "Increase volume"
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.Increase_volume("exec", "~/.local/bin/volume-control up"), { drag = true })
-- TODO: manual review on line 56 — no mapping for dispatcher "Decrease volume"
-- hl.bind("XF86AudioLowerVolume", hl.dsp.Decrease_volume("exec", "~/.local/bin/volume-control down"), { drag = true })
-- TODO: manual review on line 57 — no mapping for dispatcher "Mute volume"
-- hl.bind("XF86AudioMute", hl.dsp.Mute_volume("exec", "~/.local/bin/volume-control mute"), { drag = true })
-- TODO: manual review on line 58 — no mapping for dispatcher "Switch audio"
-- hl.bind(mainMod .. " + XF86AudioMute", hl.dsp.Switch_audio("exec", "~/.local/bin/switch-audio"), { drag = true })

-- External monitor management
-- Lid close → disable laptop screen
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, disable"'), { locked = true })

-- TODO: manual review on line 64 — no mapping for dispatcher "Disable internal monitor"
-- hl.bind(mainMod .. " + BACKSLASH", hl.dsp.Disable_internal_monitor("exec", "hyprctl keyword monitor \"eDP-1", "disable\""), { drag = true })
-- TODO: manual review on line 65 — no mapping for dispatcher "Enable internal monitor"
-- hl.bind(mainMod .. " + SHIFT + BACKSLASH", hl.dsp.Enable_internal_monitor("exec", "hyprctl keyword monitor \"eDP-1", "highres", "auto", "1.25\""), { drag = true })

-- Lid open  → re-enable laptop screen
hl.bind(
	"switch:off:Lid Switch",
	hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, highres, auto, 1.25"'),
	{ locked = true }
)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Let's get scrollin
-- Scrolling support for hyprland like niri-wm
-- TODO: manual review on line 78 — no mapping for dispatcher "Switch between dwindle and scrolling layout"
-- hl.bind(mainMod .. " + SLASH", hl.dsp.Switch_between_dwindle_and_scrolling_layout("exec", "~/.config/hypr/scripts/toggle-layout.sh"), { drag = true })
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + mouse_up", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.layout("move -col"))

-- Switch workspaces with mainMod + [0-9]
-- hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
-- hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
-- hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
-- hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
-- hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
-- hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
-- hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
-- hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
-- hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
-- hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
-- hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
-- hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
-- hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
-- hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
-- hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
-- hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
-- hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
-- hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
-- hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Change workspace with mainMod + [0-9]
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Move windows with mainMod + SHIFT + [0-9]
for i = 1, 9 do
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Cycle through applications on active workspace
-- TODO: manual review on line 109 — no mapping for dispatcher "Cycle to next window"
-- hl.bind(mainMod .. " + TAB", hl.dsp.Cycle_to_next_window("cyclenext"), { drag = true })

-- Resize active window
-- TODO: manual review on line 112 — no mapping for dispatcher "Expand window left"
-- hl.bind("SUPER + code:20", hl.dsp.Expand_window_left("resizeactive", "-100 0"), { drag = true })
-- TODO: manual review on line 113 — no mapping for dispatcher "Shrink window left"
-- hl.bind("SUPER + code:21", hl.dsp.Shrink_window_left("resizeactive", "100 0"), { drag = true })
-- TODO: manual review on line 114 — no mapping for dispatcher "Shrink window up"
-- hl.bind("SUPER + SHIFT + code:20", hl.dsp.Shrink_window_up("resizeactive", "0 -100"), { drag = true })
-- TODO: manual review on line 115 — no mapping for dispatcher "Expand window down"
-- hl.bind("SUPER + SHIFT + code:21", hl.dsp.Expand_window_down("resizeactive", "0 100"), { drag = true })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())
