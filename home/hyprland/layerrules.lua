-- ==============================================================
-- Layer Rules
-- ==============================================================

-- --------------------------------------------------------------
-- SwayNC control center
-- --------------------------------------------------------------

hl.layer_rule({
  name = "swaync-blur",
  match = {
    namespace = "^swaync-control-center$",
  },
  blur = true,
  ignore_alpha = 0.5,
})

-- --------------------------------------------------------------
-- SwayNC notifications
-- --------------------------------------------------------------

hl.layer_rule({
  name = "swaync-notif-blur",
  match = {
    namespace = "^swaync-notification-window$",
  },
  blur = true,
  ignore_alpha = 0.5,
})

-- --------------------------------------------------------------
-- Rofi
-- --------------------------------------------------------------

hl.layer_rule({
  name = "rofi-blur",
  match = {
    namespace = "^rofi$",
  },
  blur = true,
})

-- --------------------------------------------------------------
-- Hyprshot selection
-- --------------------------------------------------------------

hl.layer_rule({
  name = "selection-noanim",
  match = {
    namespace = "^selection$",
  },
  no_anim = true,
})