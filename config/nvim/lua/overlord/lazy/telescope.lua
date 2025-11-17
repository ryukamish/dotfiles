-- ripgrep and fd are required for telescope to work properly
-- another plugin which is marked as dependency but
-- manually installing it didn't give any errors

return {
    "nvim-telescope/telescope.nvim",
    tag = "v0.1.9", -- tag version which gave a lot of errors when not checked with the github repo

    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        }
    },
    -- Configuration for telescope goes here
    config = function()
        require('telescope').setup({
            defaults = {
                file_ignore_patterns = { "%.git/", "node_modules/" },
                color_devicons = true,
                sorting_strategy = "ascending",
                preview = {
                    treesitter = false, -- Enable treesitter for previews
                },
                borderchars = {
                    "─", -- top
                    "│", -- right
                    "─", -- bottom
                    "│", -- left
                    "┌", -- top-left
                    "┐", -- top-right
                    "┘", -- bottom-right
                    "└", -- bottom-left
                },
                path_displays = { "smart" },
                layout_config = {
                    height = 100,
                    width = 400,
                    prompt_position = "top",
                    preview_cutoff = 40,
                },
            },
            pickers = {
                find_files = {
                    find_command = {
                        'fd',
                        '--type', 'f',       -- Only files, not directories
                        -- '--hidden',                 -- Include hidden files/dirs (e.g., ~/.config)
                        '--follow',          -- Follow symlinks
                        '--exclude', '.git', -- Skip .git directory
                        -- Exclude meaningless directories
                        '--exclude', '*.cache',
                        '--exclude', '*.local/share/Trash',
                        '--exclude', 'node_modules',
                        '--exclude', 'vendor',
                        '--exclude', 'dist',
                        '--exclude', 'build',
                        '--exclude', 'target',
                        '--exclude', 'tmp',
                        '--exclude', 'temp',
                        -- Exclude video and media files
                        '--exclude', '*.mp4',
                        '--exclude', '*.mkv',
                        '--exclude', '*.avi',
                        '--exclude', '*.mov',
                        '--exclude', '*.wmv',
                        '--exclude', '*.flv',
                        -- Exclude images
                        '--exclude', '*.jpg',
                        '--exclude', '*.jpeg',
                        '--exclude', '*.png',
                        '--exclude', '*.gif',
                        -- Exclude binaries/archives
                        '--exclude', '*.exe',
                        '--exclude', '*.o',
                        '--exclude', '*.a',
                        '--exclude', '*.so',
                        '--exclude', '*.zip',
                        '--exclude', '*.tar.gz',
                        '--exclude', '*.rar',
                    },
                    -- Search in home directory, including hidden dirs like .config
                    cwd = vim.fn.expand('~'), -- Start search in $HOME
                    hidden = true,            -- Ensure hidden files/dirs are included
                },
                live_grep = {
                    additional_args = function()
                        return {
                            '--hidden',      -- Include hidden files/dirs
                            '--glob', '!.git/*', -- Exclude .git
                            -- Exclude video and media files
                            '--glob', '!*.mp4',
                            '--glob', '!*.mkv',
                            '--glob', '!*.avi',
                            '--glob', '!*.mov',
                            -- Exclude images
                            '--glob', '!*.jpg',
                            '--glob', '!*.jpeg',
                            '--glob', '!*.png',
                            '--glob', '!*.gif',
                            -- Exclude meaningless directories
                            '--glob', '!*.cache/*',
                            '--glob', '!*.local/share/Trash/*',
                            '--glob', '!node_modules/*',
                            '--glob', '!vendor/*',
                            '--glob', '!dist/*',
                            '--glob', '!build/*',
                            '--glob', '!target/*',
                            '--glob', '!tmp/*',
                            '--glob', '!temp/*',
                        }
                    end,
                    cwd = vim.fn.expand('~'), -- Start search in $HOME
                },
            },
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
}
