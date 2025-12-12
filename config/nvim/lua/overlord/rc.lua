local map = vim.opt

map.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Numbers and relative numbers
map.nu = true
map.rnu = true

map.tabstop = 4
map.softtabstop = 4
map.shiftwidth = 4
map.expandtab = true
map.smartindent = true

-- Visual column marker
vim.wo.colorcolumn = "91"

-- System clipboard
map.clipboard = 'unnamedplus'

map.wrap = false
map.breakindent = true
map.showbreak = "↪"

map.swapfile = false
map.backup = false

-- Undotree plugin options
map.undodir = os.getenv("HOME") .. "/.vim/undodir"
map.undofile = true

-- True colors
map.termguicolors = true

-------------- Statusline ----------------
map.winbar = "%= %m %f "    -- Buffer name on the top for all buffers

-- TabLine on top
function _G.nvim_tabline()
  local s = ""
  local current_tab = vim.fn.tabpagenr()
  for i = 1, vim.fn.tabpagenr("$") do
    local hl = i == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#"
    local bufnr = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
    local fname = vim.fn.bufname(bufnr)
    local name = fname ~= "" and vim.fn.fnamemodify(fname, ":t") or "[No Name]"
    local mod = vim.fn.getbufvar(bufnr, "&modified") == 1 and " ●" or ""
    local indicator = (i == current_tab) and "*" or " "   -- vertical bar on left of active tab
    s = s .. hl .. indicator .. name .. mod .. "  "
  end
  return s .. "%#TabLineFill#"
end
map.tabline = "%!v:lua.nvim_tabline()"
