return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-l>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
          color = {
            suggestion_color = '#0055FF',
            cterm = 244,
          },
          log_level = 'info',
          disable_keymaps = false,
        })
      end,
    },
  }
