-- Source: ~/.config/hypr/utilities/webcam-overlay.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("utilities.webcam-overlay")
require("utilities.apps")

hl.window_rule({
	name = "Floating TUI windows",
	match = {
		class = "TUI.float",
	},
	float = true,
	size = { 800, 600 },
})

hl.window_rule({
	-- Ignore maximize requests from apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
})
