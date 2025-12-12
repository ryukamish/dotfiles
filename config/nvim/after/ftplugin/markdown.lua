-- Markdown-specific settings
-- vim.bo.textwidth = 90
vim.bo.formatoptions = vim.bo.formatoptions .. "tcqn"

-- Better list handling in Markdown
vim.bo.formatoptions = vim.bo.formatoptions .. "n"
vim.bo.formatlistpat = [[^\s*\(\d\+\|\[-\*]\)\([.\)]\)\?\s\+]]

vim.opt_local.spell = true
vim.opt_local.spelllang = { "en_us" }
