local map = vim.keymap.set

map('n', '<space><space>', '<cmd>source %<cr>')

-- Open mini.files on the same file or directory
map('n', '<leader>e', function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local dir_name = vim.fn.fnamemodify(buf_name, ':p:h')
    if vim.fn.filereadable(buf_name) == 1 then
        require("mini.files").open(buf_name, true)
    elseif vim.fn.isdirectory(dir_name) == 1 then
        require('mini.files').open(dir_name, true)
    else
        require("mini.files").open(vim.uv.cwd(), true)
    end
end)

-- Move lines when selected with visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("x", "<leader>p", "\"_dP")

map("n", "<leader>bs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Making a script executable w/o leaving neovim
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

map("n", "J", "mzJ`z")                      -- Join lines without cursor jump
map("n", "<C-d>", "<C-d>zz")                -- Half-page down, stay centered
map("n", "<C-u>", "<C-u>zz")                -- Half-page up, stay centered
map("n", "<leader>j", "mzJ`z")              -- Alternative join (leader-based)

map("n", "<leader>s", [[:%s/\s\+$//e<CR>]]) -- Strip trailing whitespace

map("n", "n", "nzzzv")                      -- Next search result, center view
map("n", "N", "Nzzzv")                      -- Previous search result, center view

map("n", "<leader>bn", [[:tabnew<CR>]])     -- New tab
map("n", "<leader>bd", [[:tabclose<CR>]])   -- Close tab
map("n", "<leader>l", [[:+tabnext<CR>]])    -- Next tab
map("n", "<leader>h", [[:tabprevious<CR>]]) -- Previous tab

map("n", "<leader>bw", [[:se wrap!<CR>]])   -- Toggle line wrapping

