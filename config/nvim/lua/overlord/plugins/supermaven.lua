return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        ignore_filetypes = { cpp = true },
        color = {
          suggestion_color = '#0055FF',
          cterm = 244,
        },
        log_level = 'info',
      })
    end,
  },
}
