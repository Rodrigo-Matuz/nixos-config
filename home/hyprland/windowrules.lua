-- ==============================================================
-- Window Rules
-- ==============================================================

-- Rules are evaluated in order. Keep this file ordered intentionally.

-- --------------------------------------------------------------
-- Kitty
-- --------------------------------------------------------------

hl.window_rule({
  name = "kitty-sizing",
  match = {
    class = "^kitty$",
  },
  size = { "45%", "51%" },
  xray = false,
})

-- --------------------------------------------------------------
-- Thunar
-- --------------------------------------------------------------

hl.window_rule({
  name = "thunar",
  match = {
    class = "^thunar$",
  },
  size = { "50%", "50%" },
  float = true,
})

-- --------------------------------------------------------------
-- Pavucontrol
-- --------------------------------------------------------------

hl.window_rule({
  name = "pavucontrol",
  match = {
    class = "^pavucontrol-qt$",
  },
  size = { "25%", "60%" },
  move = { "74%", "3%" },
  float = true,
})

-- --------------------------------------------------------------
-- OBS
-- --------------------------------------------------------------

hl.window_rule({
  name = "obs-window",
  match = {
    class = "^com%.obsproject%.Studio$",
  },
  size = { 1125, 900 },
  monitor = "DP-1",
  workspace = "special:minimized silent",
  float = true,
})

-- --------------------------------------------------------------
-- Wallpaper Picker
-- --------------------------------------------------------------

hl.window_rule({
  name = "Wallpaper Picker",
  match = {
    title = "^wallpaper-picker-ui$",
  },
  float = true,
})

-- --------------------------------------------------------------
-- MPV
-- --------------------------------------------------------------

hl.window_rule({
  name = "mpv",
  match = {
    class = "^mpv$",
  },
  float = true,
})

-- --------------------------------------------------------------
-- Discord - Open Files
-- --------------------------------------------------------------

hl.window_rule({
  name = "discord-open-files-floating",
  match = {
    title = "^Open Files$",
  },
  float = true,
})

-- --------------------------------------------------------------
-- Firefox Picture-in-Picture
-- --------------------------------------------------------------

hl.window_rule({
  name = "Picture in pincture popout float",
  match = {
    title = "^Picture%-in%-Picture$",
  },
  float = true,
})

-- --------------------------------------------------------------
-- Hyprland screen selection
-- --------------------------------------------------------------

hl.window_rule({
  name = "Hyprland selection screen",
  match = {
    class = "^hyprland%-share%-picker$",
  },
  float = true,
})

-- --------------------------------------------------------------
-- Zenity
-- --------------------------------------------------------------

hl.window_rule({
  name = "Zenity for file/folder picking",
  match = {
    class = "^zenity$",
  },
  float = true,
  size = { "50%", "50%" },
})

-- --------------------------------------------------------------
-- Vivaldi X-Ray
-- --------------------------------------------------------------

hl.window_rule({
  name = "X-Ray for vivaldi",
  match = {
    class = "^vivaldi$",
  },
  xray = true,
})

-- --------------------------------------------------------------
-- Steam Settings
-- --------------------------------------------------------------

hl.window_rule({
  name = "Steam",
  match = {
    title = "^Steam Settings$",
  },
  float = true,
})

-- --------------------------------------------------------------
-- Steam
-- --------------------------------------------------------------

hl.window_rule({
  name = "Steam max window",
  match = {
    title = "^Steam$",
  },
  fullscreen = true,
})

-- --------------------------------------------------------------
-- Kittycava
-- --------------------------------------------------------------

hl.window_rule({
  name = "No blur for cava on kitty",
  match = {
    class = "^kittycava$",
  },
  no_blur = true,
})

-- --------------------------------------------------------------
-- Old Flameshot rules
-- --------------------------------------------------------------

-- hl.window_rule({
--   name = "flameshot",
--   match = {
--     class = "^flameshot$",
--     title = "^flameshot$",
--   },
--   move = { 0, 0 },
--   pin = true,
--   fullscreen_state = "3 3",
--   float = true,
-- })