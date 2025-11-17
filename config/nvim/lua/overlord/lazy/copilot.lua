return {
    "zbirenbaum/copilot.lua",
    config = function()
        require("copilot").setup({
            -- Disabling the panel for reducing lag
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    accept = "<C-CR>",
                    refresh = "gr",
                },
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = "<C-l>",
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
                ["."] = false,
            },
        })
    end
}
