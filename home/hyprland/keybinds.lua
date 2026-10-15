-- ==============================================================
-- Keybindings
-- ==============================================================

local SP = "SUPER"

-- --------------------------------------------------------------
-- Applications
-- --------------------------------------------------------------

hl.bind(SP .. " + A", hl.dsp.exec_cmd("kitty"))
hl.bind(SP .. " + C", hl.dsp.window.close())
hl.bind(SP .. " + E", hl.dsp.exec_cmd("dolphin"))

hl.bind(SP .. " + F", hl.dsp.window.float())

-- Toggle all windows on the current workspace to floating.
hl.bind(SP .. " + SHIFT + F", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"))

-- Rofi launchers and widgets
-- hl.bind(SP .. " + R", hl.dsp.exec_cmd("~/.config/rofi/launchers/type-3/launcher.sh"))
-- hl.bind(SP .. " + RETURN", hl.dsp.global("caelestia:launcher"))
hl.bind(SP .. " + SPACE", hl.dsp.exec_cmd("vicinae open"))

-- MPD
hl.bind(SP .. " + CTRL + P", hl.dsp.exec_cmd("~/.config/rofi/applets/bin/mpd.sh"))

-- Power menu
hl.bind(SP .. " + SHIFT + P", hl.dsp.exec_cmd("~/.config/rofi/powermenu/type-6/powermenu.sh"))

-- My custom Apps
hl.bind(SP .. " + R", hl.dsp.global("caelestia:wallpaper"))
hl.bind(SP .. " + W", hl.dsp.exec_cmd("wallpaper-picker-ui"))
hl.bind(SP .. " + K", hl.dsp.exec_cmd("kanatype"))

hl.bind(SP .. " + M", hl.dsp.window.fullscreen_state({internal = 3, client = 3,}))

hl.bind(SP .. " + N", hl.dsp.exec_cmd("jerry --rofi -c"))
hl.bind(SP .. " + SHIFT + N", hl.dsp.exec_cmd("jerry --rofi"))

hl.bind(SP .. " + D", hl.dsp.window.move({
  workspace = "special:minimized",
}))
hl.bind(SP .. " + SHIFT + D", hl.dsp.workspace.toggle_special("minimized"))

-- --------------------------------------------------------------
-- Focus
-- --------------------------------------------------------------

hl.bind(SP .. " + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind(SP .. " + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind(SP .. " + UP", hl.dsp.focus({ direction = "u" }))
hl.bind(SP .. " + DOWN", hl.dsp.focus({ direction = "d" }))

-- --------------------------------------------------------------
-- Workspaces
-- --------------------------------------------------------------

-- SUPER + [1-9]
for i = 1, 9 do
  local key = tostring(i)

  hl.bind(
    SP .. " + " .. key,
    hl.dsp.focus({ workspace = key })
  )

  hl.bind(
    SP .. " + SHIFT + " .. key,
    hl.dsp.window.move({ workspace = key })
  )
end

-- SUPER + 0 = workspace 10
hl.bind(SP .. " + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind(SP .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))

-- --------------------------------------------------------------
-- Monitor switching
-- --------------------------------------------------------------

-- Snappy Switcher: standard Alt+Tab MRU window switching.
-- The previous Alt+Tab monitor binding was replaced to avoid a key conflict.
hl.bind(
  "ALT + TAB",
  hl.dsp.exec_cmd("snappy-switcher next --mod alt"),
  { description = "Snappy Switcher: Alt+Tab" }
)

-- --------------------------------------------------------------
-- Special workspace / scratchpad
-- --------------------------------------------------------------

hl.bind(SP .. " + S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(
  SP .. " + SHIFT + S",
  hl.dsp.window.move({ workspace = "special:magic" })
)

-- --------------------------------------------------------------
-- Workspace scrolling
-- --------------------------------------------------------------

hl.bind(
  SP .. " + mouse_down",
  hl.dsp.focus({ workspace = "e+1" })
)

hl.bind(
  SP .. " + mouse_up",
  hl.dsp.focus({ workspace = "e-1" })
)

-- --------------------------------------------------------------
-- Move / resize windows with mouse
-- --------------------------------------------------------------

hl.bind(
  SP .. " + mouse:272",
  hl.dsp.window.drag(),
  { mouse = true }
)

hl.bind(
  SP .. " + mouse:273",
  hl.dsp.window.resize(),
  { mouse = true }
)

-- --------------------------------------------------------------
-- Screenshots
-- --------------------------------------------------------------

--hl.bind(SP .. "ALT + P", hl.dsp.exec_cmd("grimblast --notify --freeze --filetype png copy area"))

--hl.bind(SP .. "ALT + SHIFT + P", hl.dsp.exec_cmd("grimblast --notify --freeze --filetype png copysave area"))


-- SUPER + P = screenshot → clipboard
hl.bind(
  SP .. " + P",
  hl.dsp.exec_cmd(
    "grimblast --freeze copy area"
  )
)

-- SUPER + ALT + P = screenshot → Satty
hl.bind(
  SP .. " + ALT + P",
  hl.dsp.exec_cmd(
    "grimblast --freeze save area - | satty -f - --copy-command wl-copy"
  )
)

-- --------------------------------------------------------------
-- OBS - WebSocket Controls
-- --------------------------------------------------------------

hl.bind(
  "ALT + Z",
  hl.dsp.exec_cmd("obs-control replay save"),
  { description = "OBS: Save Replay Buffer" }
)

hl.bind(
  "ALT + F10",
  hl.dsp.exec_cmd("obs-control recording toggle"),
  { description = "OBS: Toggle Recording" }
)

-- --------------------------------------------------------------
-- Audio
-- --------------------------------------------------------------

hl.bind( "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"),
  { locked = true }
)

hl.bind( "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
  { locked = true }
)

hl.bind( "XF86AudioMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true }
)

hl.bind( "XF86AudioNext",
  hl.dsp.exec_cmd("mpc next"),
  { locked = true }
)

hl.bind( "XF86AudioPrev",
  hl.dsp.exec_cmd("mpc prev"),
  { locked = true }
)

-- --------------------------------------------------------------
-- Custom Cava background
-- --------------------------------------------------------------

hl.bind(
  SP .. " + SHIFT + C",
  hl.dsp.exec_cmd("~/Documents/scripts/kittycava.sh")
)

-- --------------------------------------------------------------
-- Task Manager
-- --------------------------------------------------------------

hl.bind(
  "CTRL + SHIFT + escape",
  hl.dsp.exec_cmd("kitty -e btop")
)

-- --------------------------------------------------------------
-- Disabled / old bindings kept as comments
-- --------------------------------------------------------------

-- hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl -a play-pause"), { locked = true })
-- hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl -a play-pause"), { locked = true })

-- bind = CTRL ALT, right, workspace, +1
-- bind = CTRL ALT, left, workspace, -1
-- bind = SUPER, M, exec, pavucontrol-qt
