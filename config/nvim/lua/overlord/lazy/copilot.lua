return {
    "zbirenbaum/copilot.lua",
    config = function ()
        require("copilot").setup({
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    accept = "<CR>",
                },
            },
            layout = {
                position = "bottom", -- | top | left | right | bottom |
                ratio = 0.4
            },
            suggestion = {
                enabled = true,
                keymap = {
                    accept = "<M-l>",
                    accept_word = false,
                    accept_line = false,
                },
            },
        })
    end
}
