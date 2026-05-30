hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:swapescape", -- Swap the escape key with caps lock key
		kb_rules = "",
		follow_mouse = 1,
		-- Change speed of keyboard repeat
		repeat_rate = 30,
		repeat_delay = 400,
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
		touchpad = {
			natural_scroll = true,
		},
	},
})
