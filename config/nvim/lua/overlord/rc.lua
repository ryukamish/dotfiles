local map = vim.opt

-- Numbers and relative numbers
map.nu = true
map.rnu = true

map.tabstop = 2
map.softtabstop = 2
map.shiftwidth = 2
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

-------------- Statusline ----------------
map.winbar = "%= %m %f "    -- Buffer name on the top for all buffers
