-- Cursor
hl.env("XCURSOR_SIZE", "12")
hl.env("HYPRCURSOR_SIZE", "12")
-- hl.env("HYPRCURSOR_THEME", "bibata-43b34")

-- Qt / Wayland
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- Desktop / session
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_DEFAULT_FILE_MANAGER", "thunar")

-- Applications
hl.env("VISUAL", "nvim")
hl.env("BROWSER", "vivaldi")
hl.env("TERMINAL", "kitty")
hl.env("SUDO_EDITOR", "nvim")

-- Hardware acceleration
hl.env("LIBVA_DRIVER_NAME", "radeonsi")
hl.env("VDPAU_DRIVER", "radeonsi")

-- GTK
-- hl.env("GTK_THEME", "oomox-matuz")

-- Intentionally disabled from the old config:
-- hl.env("QT_STYLE_OVERRIDE", "qt6ct-style")
-- hl.env("WLR_NO_HARDWARE_CURSORS", "1")
-- hl.env("GDK_BACKEND", "wayland")