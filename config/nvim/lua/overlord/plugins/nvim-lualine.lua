return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    local nvim_api = vim.api.nvim_set_hl
    -- Transparent statusline
    nvim_api(0, "StatusLine",   { bg = "NONE", ctermbg = "NONE", fg = fg, bold = true })
    -- Transparent statusline (inactive windows)
    nvim_api(0, "StatusLineNC", { bg = "NONE", ctermbg = "NONE", fg = fg, bold = true })

    -- Remove the default states at the bottom of the buffer
    vim.opt.showmode = false
    require('lualine').setup {
      options = {
        component_separators = '',
        section_separators = '',
        -- One statusline for all the buffers
        globalstatus = true,
      },
    }
  end,
}
