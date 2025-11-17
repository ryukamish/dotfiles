-- Set leaderkey to spacebar
vim.g.mapleader = " "

local map = vim.keymap.set
-- Save files with CTRL + S keymap
map("n", "<C-S>", ":w<CR>")

-- Launch netrw with this keymap
-- map("n", "<leader>e", vim.cmd.Ex)
map("n", "e", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Exit neovim with this keymap
map("n", "<leader>qq", vim.cmd.qa)

-- Move lines when selected with visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("x", "<leader>p", "\"_dP")

-- Universal clipboard support,
-- meaning yanking in nvim also copies it to system clipboard
map({ "n", "v", "x" }, "<leader>y", [["+y]])
map({ "n", "v", "x" }, "<leader>Y", [["+Y]])

-- Selecting a word and replacing all matching with another
map("n", "<leader>bs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Making a script executable w/o leaving neovim
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

map("n", "J", "mzJ`z")  -- Join lines without cursor jump
map("n", "<C-d>", "<C-d>zz")  -- Half-page down, stay centered
map("n", "<C-u>", "<C-u>zz")  -- Half-page up, stay centered
map("n", "<leader>j", "mzJ`z")  -- Alternative join (leader-based)

map("n", "<leader>s", [[:%s/\s\+$//e<CR>]])  -- Strip trailing whitespace

map("n", "n", "nzzzv")  -- Next search result, center view
map("n", "N", "Nzzzv")  -- Previous search result, center view

map("n", "<leader>bn", [[:tabnew<CR>]])  -- New tab
map("n", "<leader>bd", [[:tabclose<CR>]])  -- Close tab
map("n", "<leader>l", [[:+tabnext<CR>]])  -- Next tab
map("n", "<leader>h", [[:tabprevious<CR>]])  -- Previous tab

map("n", "<leader>bw", [[:se wrap!<CR>]])  -- Toggle line wrapping

-- Terminal inside Neovim
map("n", "<leader>t", function ()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 12)
end)

-- Exit terminal mode with ESC
map('t', '<ESC>', [[<C-\><C-n>]], { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber= false
    end,
})
