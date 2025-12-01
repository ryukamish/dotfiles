return {
  'folke/tokyonight.nvim',
  name = 'tokyonight',
  config = function()
    vim.cmd.colorscheme('tokyonight')

    local nvim_api = vim.api.nvim_set_hl
    -- Transparent backgrounds for main windows
    nvim_api(0, "Normal", { bg = "none" })
    nvim_api(0, "NormalFloat", { bg = "none" })

    -- Transparent backgrounds for inactive windows/splits
    nvim_api(0, "NormalNC", { bg = "none" })

    -- Transparent float borders
    nvim_api(0, "FloatBorder", { bg = "none" })

    -- Transparent line numbers
    nvim_api(0, "LineNr", { bg = "none" })
    nvim_api(0, "SignColumn", { bg = "none" })
  end,
}
