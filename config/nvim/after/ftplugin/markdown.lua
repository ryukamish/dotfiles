-- Markdown-specific settings
vim.bo.textwidth = 80
vim.bo.formatoptions = vim.bo.formatoptions .. "tcqn"

-- Visual column marker
vim.wo.colorcolumn = "81"

-- Better list handling in Markdown
vim.bo.formatoptions = vim.bo.formatoptions .. "n"
vim.bo.formatlistpat = [[^\s*\(\d\+\|\[-\*]\)\([.\)]\)\?\s\+]]
