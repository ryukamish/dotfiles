return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,     -- load earlier for autocmds
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true },
  },
}
