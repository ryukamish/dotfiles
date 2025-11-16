return {
    "zbirenbaum/copilot.lua",
    config = function ()
        require("copilot").setup({
            -- Disabling the panel for reducing lag
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
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = "<C-CR>",
                    accept_word = false,
                    accept_line = false,
                },
            },
            -- Disable on non code files
            filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = true,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
            },
        })
    end
}
