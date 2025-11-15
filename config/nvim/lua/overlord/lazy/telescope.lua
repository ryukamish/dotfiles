-- ripgrep and fd are required for telescope to work properly
-- another plugin which is marked as dependency but
-- manually installing it didn't give any errors

return {
    "nvim-telescope/telescope.nvim",
    tag = "v0.1.9", -- tag version which gave a lot of errors when not checked with the github repo

    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    -- Configuration for telescope goes here
    config = function()
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { "%.git/", "node_modules/" },
                preview = {
                    treesitter = true, -- Enable treesitter for previews
                },
            },
            pickers = {
                find_files = {
                    find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" },
                },
            },
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope find git files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
}
