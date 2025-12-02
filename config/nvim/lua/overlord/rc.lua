local map = vim.opt

-- Don't change the cursor when going from normal to insert mode
-- vim.opt.guicursor = ""

-- Numbers and relative numbers
map.nu = true
map.rnu = true

map.tabstop = 4
map.softtabstop = 4
map.shiftwidth = 4
map.expandtab = true
map.smartindent = true

-- System clipboard
map.clipboard = 'unnamedplus'

map.wrap = false
map.breakindent = true
map.showbreak = "↪ "

map.swapfile = false
map.backup = false

-- Undotree plugin options
map.undodir = os.getenv("HOME") .. "/.vim/undodir"
map.undofile = true

-- True colors
map.termguicolors = true

