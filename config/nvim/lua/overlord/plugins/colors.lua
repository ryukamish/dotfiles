return {
  "folke/tokyonight.nvim",
  config = function()
    vim.cmd.colorscheme('tokyonight')

    local nvim_api = vim.api.nvim_set_hl
    -- Transparent backgrounds for main windows
    nvim_api(0, "Normal", { bg = "none" })
    nvim_api(0, "NormalFloat", { bg = "none" })

    -- Transparent backgrounds for inactive windows/splits
    nvim_api(0, "NormalNC", { bg = "none" })

    -- Transparent status lines
    nvim_api(0, "StatusLine", { bg = "none" })
    nvim_api(0, "StatusLineNC", { bg = "none" })

    -- Transparent window separators
    nvim_api(0, "VertSplit", { bg = "none" })
    nvim_api(0, "WinSeparator", { bg = "none" })

    -- Transparent float borders
    nvim_api(0, "FloatBorder", { bg = "none" })

    -- Transparent line numbers
    nvim_api(0, "LineNr", { bg = "none" })
    nvim_api(0, "SignColumn", { bg = "none" })

    -- Transparent Telescope
    nvim_api(0, "TelescopeNormal", { bg = "none" })
    nvim_api(0, "TelescopeBorder", { bg = "none" })
    nvim_api(0, "TelescopePromptNormal", { bg = "none" })
    nvim_api(0, "TelescopePromptBorder", { bg = "none" })
    nvim_api(0, "TelescopeResultsNormal", { bg = "none" })
    nvim_api(0, "TelescopeResultsBorder", { bg = "none" })
    nvim_api(0, "TelescopePreviewNormal", { bg = "none" })
    nvim_api(0, "TelescopePreviewBorder", { bg = "none" })
    nvim_api(0, "TelescopeTitle", { bg = "none" })
    nvim_api(0, "TelescopePromptTitle", { bg = "none" })
    nvim_api(0, "TelescopeResultsTitle", { bg = "none" })
    nvim_api(0, "TelescopePreviewTitle", { bg = "none" })

    -- Transparent Mini.files
    nvim_api(0, "MiniFilesNormal", { bg = "none" })
    nvim_api(0, "MiniFilesBorder", { bg = "none" })
    nvim_api(0, "MiniFilesBorderModified", { bg = "none" })
    nvim_api(0, "MiniFilesCursorLine", { bg = "none" })
    nvim_api(0, "MiniFilesDirectory", { bg = "none" })
    nvim_api(0, "MiniFilesFile", { bg = "none" })
    nvim_api(0, "MiniFilesTitle", { bg = "none" })
    nvim_api(0, "MiniFilesTitleFocused", { bg = "none" })

    -- Transparent Pmenu (completion menu)
    nvim_api(0, "Pmenu", { bg = "none" })
    nvim_api(0, "PmenuSel", { bg = "none" })
    nvim_api(0, "PmenuSbar", { bg = "none" })
    nvim_api(0, "PmenuThumb", { bg = "none" })

    -- Transparent folds
    nvim_api(0, "Folded", { bg = "none" })
    nvim_api(0, "FoldColumn", { bg = "none" })

    -- Transparent end of buffer
    nvim_api(0, "EndOfBuffer", { bg = "none" })

  end,
}
