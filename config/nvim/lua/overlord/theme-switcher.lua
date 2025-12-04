-- Add this to your Neovim config (init.lua or a separate file)

-- Path where the theme file will be stored
local theme_file = vim.fn.expand('~/.config/nvim/current_theme.txt')

-- Ensure the file exists with a default theme
if vim.fn.filereadable(theme_file) == 0 then
  local file = io.open(theme_file, 'w')
  if file then
    file:write('tokyonight-night')
    file:close()
  end
end

-- Function to load theme from file
local function load_theme()
  local file = io.open(theme_file, 'r')
  if file then
    local theme = file:read('*line')
    file:close()

    if theme and theme ~= '' then
      -- Safely attempt to set colorscheme
      local ok = pcall(vim.cmd.colorscheme, theme)
      if not ok then
        vim.notify('Theme "' .. theme .. '" not found', vim.log.levels.WARN)
      end
    end
  end
end

-- Load theme on startup
load_theme()

-- Watch for file changes and reload theme automatically
local function watch_theme_file()
  local uv = vim.loop
  local handle = uv.new_fs_event()

  local function on_change()
    -- Small delay to ensure file is fully written
    vim.defer_fn(function()
      load_theme()
      vim.notify('Theme reloaded', vim.log.levels.INFO)
    end, 50)
  end

  uv.fs_event_start(handle, theme_file, {}, vim.schedule_wrap(on_change))
end

----------------- Theme -------------------

local nvim_api = vim.api.nvim_set_hl

-- Transparent for all
nvim_api(0, "Normal", { bg = "none" })
nvim_api(0, "NormalFloat", { bg = "none" })

nvim_api(0, "NormalNC", { bg = "none" })

-- Transparent floating windows
nvim_api(0, "FloatBorder", { bg = "none" })
-- Transparent tab on top
nvim_api(0, "TabLine",     { bg = "NONE" })
nvim_api(0, "TabLineFill", { bg = "NONE" })
nvim_api(0, "TabLineSel",  { bg = "NONE" })

nvim_api(0, "StatusLine",   { bg = "NONE" })
nvim_api(0, "StatusLineNC", { bg = "NONE" })

nvim_api(0, "VertSplit", { bg = "NONE", fg = fg, bold = true }) -- column separator

-- Transparent line numbers
nvim_api(0, "LineNr", { bg = "none", fg = fg })
nvim_api(0, "SignColumn", { bg = "none", fg = fg })

-- Transparent backgrounds for telescope
nvim_api(0, "TelescopeBorder",         { bg = "NONE" })  -- dim border
nvim_api(0, "TelescopePromptBorder",   { bg = "NONE" })
nvim_api(0, "TelescopeResultsBorder",  { bg = "NONE" })
nvim_api(0, "TelescopePreviewBorder",  { bg = "NONE" })
nvim_api(0, "TelescopeNormal",         { bg = "NONE" })
nvim_api(0, "TelescopePromptNormal",   { bg = "NONE" })
nvim_api(0, "TelescopeResultsNormal",  { bg = "NONE" })
nvim_api(0, "TelescopePreviewNormal",  { bg = "NONE" })
nvim_api(0, "TelescopeSelection",      { bg = "#2d3f52", fg = "#ffffff", bold = true })

-- Transparent backgrounds for nvim-cmp
nvim_api(0, "CmpItemAbbr",             { bg = "NONE" })
nvim_api(0, "CmpItemAbbrDeprecated",   { bg = "NONE" })
nvim_api(0, "CmpItemAbbrMatch",        { bg = "NONE" })
nvim_api(0, "CmpItemAbbrMatchFuzzy",   { bg = "NONE" })
nvim_api(0, "CmpItemKind",             { bg = "NONE" })
nvim_api(0, "CmpItemMenu",             { bg = "NONE" })

-- Transparent backgrounds for lsp-trouble
nvim_api(0, "LspTroubleNormal",        { bg = "NONE" })
nvim_api(0, "LspTroubleText",          { bg = "NONE" })
nvim_api(0, "LspTroubleCount",         { bg = "NONE" })
nvim_api(0, "LspTroubleIndent",        { bg = "NONE" })

-- Transparent winbar
nvim_api(0, "WinBar",                  { bg = "NONE" })
nvim_api(0, "WinBarNC",                { bg = "NONE" })

-- Start watching
watch_theme_file()

-- Optional: Manual reload command
vim.api.nvim_create_user_command('ThemeReload', load_theme, {})

