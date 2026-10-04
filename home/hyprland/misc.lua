-- Misc / Devices / Cursor
-- ==============================================================

hl.config({
  misc = {
    -- 0 = disable Hyprland's default wallpaper
    force_default_wallpaper = 0,
  },
})

-- --------------------------------------------------------------
-- Dwindle
-- --------------------------------------------------------------
--
-- These were commented out in the old configuration, so they
-- remain commented here rather than changing your behavior.
--
-- hl.config({
--   dwindle = {
--     pseudotile = true,
--     preserve_split = true,
--   },
-- })

-- --------------------------------------------------------------
-- Master
-- --------------------------------------------------------------
--
-- hl.config({
--   master = {
--     new_is_master = true,
--   },
-- })

-- --------------------------------------------------------------
-- Gestures
-- --------------------------------------------------------------
--
-- hl.gesture({
--   fingers = 3,
--   direction = "horizontal",
--   action = "workspace",
-- })

-- --------------------------------------------------------------
-- Per-device configuration
-- --------------------------------------------------------------

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})

-- --------------------------------------------------------------
-- Cursor
-- --------------------------------------------------------------

hl.config({
  cursor = {
    inactive_timeout = 3,
  },
})