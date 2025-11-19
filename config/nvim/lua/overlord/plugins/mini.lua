return {
    {
        'echasnovski/mini.nvim',
        config = function()
            -- Statusline for neovim
            require('mini.statusline').setup({
                use_icons = true,
            })
            -- Autopairing brackets
            require('mini.pairs').setup()
            -- File explorer
            require('mini.files').setup({
                lazy = false,
                mappings = {
                    close = 'q',
                    go_in = '<CR>',
                    go_in_plus = 'L',
                    go_out = '<BS>',
                    go_out_plus = 'H',
                    reset = 'r',
                    reveal_cwd = '.',
                    show_help = '?',
                    synchronize = 's',
                },
                options = {
                    show_hidden = true,
                    permanent_delete = false,
                },
            })
        end
    }
}
