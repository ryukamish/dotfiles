return (
    {
        -- TokyoNight Theme
        "folke/tokyonight.nvim",
        -- "vague-theme/vague.nvim",
        -- 'catppuccin/nvim',
        name = "tokyonight",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("tokyonight")
            -- Transparent background
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            -- -- Transparent bottom bar
            vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
            vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
        end
    }
)
