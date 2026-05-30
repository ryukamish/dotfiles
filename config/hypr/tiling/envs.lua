-- Cursor settings

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("XCURSOR_THEME", "Bibata-Original-Classic")
-- hl.env("HYPRCURSOR_THEME", "Bibata-Original-Classic")

-- Force all apps to use Wayland
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("GDK_BACKEND", "wayland")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("QT_ENABLE_HIGHDPI_SCALING", "1")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")
-- qt based apps themes
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
-- Allow better support for screen sharing (Google Meet, Discord, etc)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_MENU_PREFIX", "arch- kbuildsycoca6")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

hl.env("TERMINAL", "kitty")
hl.env("EDITOR", "nvim")
