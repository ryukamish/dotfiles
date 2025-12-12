return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    -- Remove the default states at the bottom of the buffer
    vim.opt.showmode = false
    require('lualine').setup {
      options = {
        -- Seperate the components and sections with nothing
        component_separators = '',
        section_separators = '',
        -- One statusline for all the buffers
        globalstatus = true,
        -- Disabling status line for certain buffers
        disabled_filetypes = { "dashboard", "alpha", "starter" },
      },
      sections = {
        -- Section on left
        lualine_a = {
          {
            "mode",
            -- For only the first letter for mode
            fmt = function(str) return str:sub(1,1) end,
            padding = { left = 1, right = 1 },
          },
        },
        -- Section on the right
        lualine_x = {
          {
            "filetype",
            colored = true,
            icon_only = false,
            padding = { left = 1, right = 1 }
          }
        },
        -- Section on right
        lualine_y = {},
        lualine_z = {
          {
            "location",
            padding = { left = 1, right = 1 },
          },
        },
      }
    }
  end,
}
