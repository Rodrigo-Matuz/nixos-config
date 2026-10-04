hl.config({
  -- ------------------------------------------------------------
  -- Keyboard / Input
  -- ------------------------------------------------------------

  input = {
    kb_layout = "us",
    kb_variant = "intl",
    kb_model = "",
    kb_options = "compose:caps",
    kb_rules = "",

    follow_mouse = 1,
    sensitivity = 0,

    touchpad = {
      natural_scroll = false,
    },
  },

  -- ------------------------------------------------------------
  -- General
  -- ------------------------------------------------------------

  general = {
    gaps_in = 3,
    gaps_out = 5,
    border_size = 2,

    col = {
      active_border = {
        colors = {
          "rgba(FC1A70ee)",
          "rgba(FF4D00ee)",
          "rgba(FFFF87ee)",
          "rgba(A4e400ee)",
          "rgba(1E65FFee)",
          "rgba(702EF3ee)",
        },
        angle = 45,
      },
      inactive_border = "rgba(1c1c1caa)",
    },

    layout = "dwindle",
    allow_tearing = false,
  },

  -- ------------------------------------------------------------
  -- Decoration
  -- ------------------------------------------------------------

  decoration = {
    rounding = 5,
    active_opacity = 1,
    inactive_opacity = 1,

    blur = {
      enabled = true,
      size = 3,
      passes = 2,
      popups = false,
      special = false,
    },

    shadow = {
      enabled = false,
      range = 10,
    },
  },

  -- ------------------------------------------------------------
  -- Animations
  -- ------------------------------------------------------------

  animations = {
    enabled = true,
  },
})

-- ------------------------------------------------------------
-- Animation Curves
-- ------------------------------------------------------------

-- Smooth, fast, and natural.
hl.curve("smooth", {
  type = "bezier",
  points = {
    { 0.22, 1.0 },
    { 0.36, 1.0 },
  },
})

-- Slight overshoot for windows.
-- Gives opening/closing a subtle "snap".
hl.curve("overshoot", {
  type = "bezier",
  points = {
    { 0.34, 1.3 },
    { 0.64, 1.0 },
  },
})

-- Very smooth acceleration/deceleration.
hl.curve("easeOut", {
  type = "bezier",
  points = {
    { 0.16, 1.0 },
    { 0.3, 1.0 },
  },
})

-- ------------------------------------------------------------
-- Animations
-- ------------------------------------------------------------

-- General window animation.
hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 4,
  bezier = "smooth",
  style = "popin 85%",
})

-- Opening windows.
hl.animation({
  leaf = "windowsIn",
  enabled = true,
  speed = 4,
  bezier = "overshoot",
  style = "popin 85%",
})

-- Closing windows.
hl.animation({
  leaf = "windowsOut",
  enabled = true,
  speed = 3,
  bezier = "easeOut",
  style = "popin 85%",
})

-- Moving/resizing windows.
hl.animation({
  leaf = "windowsMove",
  enabled = true,
  speed = 4,
  bezier = "smooth",
})

-- ------------------------------------------------------------
-- Workspace animations
-- ------------------------------------------------------------

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 4,
  bezier = "easeOut",
  style = "slidefade 20%",
})

-- ------------------------------------------------------------
-- Fade animations
-- ------------------------------------------------------------

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 3,
  bezier = "easeOut",
})

hl.animation({
  leaf = "fadeIn",
  enabled = true,
  speed = 3,
  bezier = "easeOut",
})

hl.animation({
  leaf = "fadeOut",
  enabled = true,
  speed = 3,
  bezier = "easeOut",
})

hl.animation({
  leaf = "fadeSwitch",
  enabled = true,
  speed = 2,
  bezier = "smooth",
})

-- ------------------------------------------------------------
-- Layer-shell animations
-- Useful for things like launchers / panels / widgets.
-- ------------------------------------------------------------

hl.animation({
  leaf = "layers",
  enabled = true,
  speed = 4,
  bezier = "smooth",
  style = "slide",
})

hl.animation({
  leaf = "layersIn",
  enabled = true,
  speed = 4,
  bezier = "overshoot",
  style = "slide",
})

hl.animation({
  leaf = "layersOut",
  enabled = true,
  speed = 3,
  bezier = "easeOut",
  style = "slide",
})

-- ------------------------------------------------------------
-- Border
-- ------------------------------------------------------------

-- Smoothly transition between border colors.
hl.animation({
  leaf = "border",
  enabled = true,
  speed = 5,
  bezier = "smooth",
})

hl.animation({
  leaf = "borderangle",
  enabled = true,
  speed = 100,
  bezier = "linear",
  style = "loop",
})

hl.curve("linear", {
  type = "bezier",
  points = {
    { 0.0, 0.0 },
    { 1.0, 1.0 },
  },
})
