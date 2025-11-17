return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
            "b0o/schemastore.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",   -- Bash/Shell scripts
                    "jsonls",   -- JSON files (waybar, rofi configs)
                    "yamlls",   -- YAML files
                    "cssls",    -- CSS (for waybar styling)
                    "html",     -- HTML
                    "lua_ls",   -- Lua (for nvim config)
                    "marksman", -- Markdown
                }
            })

            -- Get capabilities for completion
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Configure LSP servers using the modern vim.lsp.config API
            vim.lsp.config.bashls = {
                cmd = { "bash-language-server", "start" },
                filetypes = { "sh", "bash" },
                root_markers = { ".git" },
                capabilities = capabilities,
            }

            vim.lsp.config.jsonls = {
                cmd = { "vscode-json-language-server", "--stdio" },
                filetypes = { "json", "jsonc" },
                root_markers = { ".git", "package.json" },
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            }

            vim.lsp.config.yamlls = {
                cmd = { "yaml-language-server", "--stdio" },
                filetypes = { "yaml", "yml" },
                root_markers = { ".git" },
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemas = {
                            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                            "/docker-compose*.yml",
                        },
                        validate = true,
                        completion = true,
                        hover = true,
                    },
                },
            }

            vim.lsp.config.cssls = {
                cmd = { "vscode-css-language-server", "--stdio" },
                filetypes = { "css", "scss", "less" },
                root_markers = { ".git", "package.json" },
                capabilities = capabilities,
                settings = {
                    css = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                },
            }

            vim.lsp.config.html = {
                cmd = { "vscode-html-language-server", "--stdio" },
                filetypes = { "html" },
                root_markers = { ".git", "package.json" },
                capabilities = capabilities,
            }

            vim.lsp.config.lua_ls = {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }

            vim.lsp.config.marksman = {
                cmd = { "marksman", "server" },
                filetypes = { "markdown", "md" },
                root_markers = { ".git", ".marksman.toml" },
                capabilities = capabilities,
            }

            -- Enable all configured LSP servers
            vim.lsp.enable("bashls")
            vim.lsp.enable("jsonls")
            vim.lsp.enable("yamlls")
            vim.lsp.enable("cssls")
            vim.lsp.enable("html")
            vim.lsp.enable("lua_ls")
            vim.lsp.enable("marksman")
        end,
    },
    -- Blink.cmp - modern completion plugin
    {
        "saghen/blink.cmp",
        lazy = false,
        version = 'v0.*',
        opts = {
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'buffer' },
            },
        },
    },
}
