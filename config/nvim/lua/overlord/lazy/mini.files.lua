return {

    'echasnovski/mini.files',
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    lazy = false,
    version = false,
    opts = {
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            close = 'q',
            go_in = '<CR>',
            go_out = 'H',
            reset = 'r',
            show_help = '?',
            synchronize = 's',
            trim_left = '<',
            trim_right = '>',
        },
        options = {
            -- Whether to show hidden files.
            show_hidden = true,
            permanent_delete = false,
        },
        -- Whether to use default file icons provided by `mini.icons` plugin.
        use_default_file_icons = true,

        custom_keymaps = {
            open_tmux_pane = '<M-t>',
        },
    },

    keys = {
        {
            '<leader>e',
            function()
                require('mini.files').open()
            end,
            desc = 'Open Mini Files',
        }
    }
}
