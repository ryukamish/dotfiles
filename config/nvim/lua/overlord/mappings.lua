-- Set leaderkey to spacebar
vim.g.mapleader = " "

-- Save files with CTRL + S keymap
vim.keymap.set("n", "<C-S>", ":w<CR>")

-- Launch netrw with this keymap
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Exit neovim with this keymap
vim.keymap.set("n", "<leader>qq", vim.cmd.qa)

-- Move lines when selected with visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "\"_dP")

-- Universal clipboard support,
-- meaning yanking in nvim also copies it to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Selecting a word and replacing all matching with another
vim.keymap.set("n", "<leader>bs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Making a script executable w/o leaving neovim
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "J", "mzJ`z")  -- Join lines without cursor jump
vim.keymap.set("n", "<C-d>", "<C-d>zz")  -- Half-page down, stay centered
vim.keymap.set("n", "<C-u>", "<C-u>zz")  -- Half-page up, stay centered
vim.keymap.set("n", "<leader>j", "mzJ`z")  -- Alternative join (leader-based)

vim.keymap.set("n", "<leader>s", [[:%s/\s\+$//e<CR>]])  -- Strip trailing whitespace

vim.keymap.set("n", "n", "nzzzv")  -- Next search result, center view
vim.keymap.set("n", "N", "Nzzzv")  -- Previous search result, center view

vim.keymap.set("n", "<leader>bn", [[:tabnew<CR>]])  -- New tab
vim.keymap.set("n", "<leader>bd", [[:tabclose<CR>]])  -- Close tab
vim.keymap.set("n", "<leader>l", [[:+tabnext<CR>]])  -- Next tab
vim.keymap.set("n", "<leader>h", [[:tabprevious<CR>]])  -- Previous tab
