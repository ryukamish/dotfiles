return {
    -- TokyoNight Theme
    "folke/tokyonight.nvim",
    name = "tokyonight",
    lazy = false,
    priority = 1000,
    config = function()

        vim.cmd.colorscheme("tokyonight")
        -- Transparent backgrounds for main windows
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

        -- Transparent backgrounds for inactive windows/splits
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

        -- Transparent status lines
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })

        -- Transparent window separators
        vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
        vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })

        -- Transparent float borders
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

        -- Transparent line numbers
        vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

        -- Transparent Telescope
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeTitle", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "none" })

        -- Transparent Mini.files
        vim.api.nvim_set_hl(0, "MiniFilesNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "MiniFilesBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "MiniFilesBorderModified", { bg = "none" })
        vim.api.nvim_set_hl(0, "MiniFilesCursorLine", { bg = "none" })
        vim.api.nvim_set_hl(0, "MiniFilesDirectory", { bg = "none" })
        vim.api.nvim_set_hl(0, "MiniFilesFile", { bg = "none" })
        vim.api.nvim_set_hl(0, "MiniFilesTitle", { bg = "none" })
        vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { bg = "none" })

        -- Transparent Pmenu (completion menu)
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
        vim.api.nvim_set_hl(0, "PmenuSel", { bg = "none" })
        vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "none" })
        vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "none" })

        -- Transparent folds
        vim.api.nvim_set_hl(0, "Folded", { bg = "none" })
        vim.api.nvim_set_hl(0, "FoldColumn", { bg = "none" })

        -- Transparent end of buffer
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    end,
}
