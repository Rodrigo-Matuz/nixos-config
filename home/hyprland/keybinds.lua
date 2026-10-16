-- ==============================================================
-- Keybindings
-- ==============================================================

local SP = "SUPER"

-- Use the session locale for bind descriptions. On NixOS, changing
-- i18n.defaultLocale to pt_BR.UTF-8 and restarting Hyprland enables the
-- Brazilian Portuguese descriptions below.
local function first_locale(...)
  for index = 1, select("#", ...) do
    local value = select(index, ...)
    if value and value ~= "" then
      return value
    end
  end
  return "en_US.UTF-8"
end

local locale = first_locale(
  os.getenv("LC_ALL"),
  os.getenv("LC_MESSAGES"),
  os.getenv("LANGUAGE"),
  os.getenv("LANG")
)

local is_pt_br = locale:match("^pt[_-]BR") ~= nil

local function d(english, portuguese)
  return is_pt_br and portuguese or english
end

-- --------------------------------------------------------------
-- Applications
-- --------------------------------------------------------------

hl.bind(SP .. " + A", hl.dsp.exec_cmd("kitty"), {
  description = d("Open terminal", "Abrir terminal")
})
hl.bind(SP .. " + C", hl.dsp.window.close(), {
  description = d("Close focused window", "Fechar janela em foco")
})
hl.bind(SP .. " + E", hl.dsp.exec_cmd("dolphin"), {
  description = d("Open file manager", "Abrir gerenciador de arquivos")
})

hl.bind(SP .. " + F", hl.dsp.window.float(), {
  description = d("Toggle floating for focused window", "Alternar modo flutuante da janela em foco")
})

-- Toggle all windows on the current workspace to floating.
hl.bind(SP .. " + SHIFT + F", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"), {
  description = d("Toggle floating for all windows on current workspace", "Alternar modo flutuante de todas as janelas da área de trabalho atual")
})

-- Rofi launchers and widgets
-- hl.bind(SP .. " + R", hl.dsp.exec_cmd("~/.config/rofi/launchers/type-3/launcher.sh"))
-- hl.bind(SP .. " + RETURN", hl.dsp.global("caelestia:launcher"))
hl.bind(SP .. " + SPACE", hl.dsp.exec_cmd("vicinae open"), {
  description = d("Open Vicinae launcher", "Abrir lançador do Vicinae")
})

-- Help
hl.bind(
  SP .. " + SLASH",
  hl.dsp.exec_cmd("vicinae cmd launch '@sovereign/hypr-keybinds:hyprland-keybinds'"),
  { description = d("Show Hyprland keybinds", "Mostrar atalhos do Hyprland") }
)

-- MPD
hl.bind(SP .. " + CTRL + P", hl.dsp.exec_cmd("~/.config/rofi/applets/bin/mpd.sh"), {
  description = d("Open MPD controls", "Abrir controles do MPD")
})

-- Power menu
hl.bind(SP .. " + SHIFT + P", hl.dsp.exec_cmd("~/.config/rofi/powermenu/type-6/powermenu.sh"), {
  description = d("Open power menu", "Abrir menu de energia")
})

-- My custom Apps
hl.bind(SP .. " + R", hl.dsp.global("caelestia:wallpaper"), {
  description = d("Open wallpaper selector", "Abrir seletor de papéis de parede")
})
hl.bind(SP .. " + W", hl.dsp.exec_cmd("wallpaper-picker-ui"), {
  description = d("Open wallpaper picker", "Abrir seletor de papéis de parede")
})
hl.bind(SP .. " + K", hl.dsp.exec_cmd("kanatype"), {
  description = d("Open Kanatype", "Abrir Kanatype")
})

hl.bind(SP .. " + M", hl.dsp.window.fullscreen_state({internal = 3, client = 3,}), {
  description = d("Toggle fullscreen", "Alternar tela cheia")
})

hl.bind(SP .. " + N", hl.dsp.exec_cmd("jerry --rofi -c"), {
  description = d("Continue watching anime with Jerry", "Continuar assistindo anime com Jerry")
})
hl.bind(SP .. " + SHIFT + N", hl.dsp.exec_cmd("jerry --rofi"), {
  description = d("Search anime with Jerry", "Procurar anime com Jerry")
})

hl.bind(SP .. " + D", hl.dsp.window.move({
  workspace = "special:minimized",
}), { description = d("Minimize focused window to special workspace", "Minimizar janela em foco na área de trabalho especial") })
hl.bind(SP .. " + SHIFT + D", hl.dsp.workspace.toggle_special("minimized"), {
  description = d("Show minimized windows", "Mostrar janelas minimizadas")
})

-- --------------------------------------------------------------
-- Focus
-- --------------------------------------------------------------

hl.bind(SP .. " + LEFT", hl.dsp.focus({ direction = "l" }), {
  description = d("Focus window to the left", "Focar janela à esquerda")
})
hl.bind(SP .. " + RIGHT", hl.dsp.focus({ direction = "r" }), {
  description = d("Focus window to the right", "Focar janela à direita")
})
hl.bind(SP .. " + UP", hl.dsp.focus({ direction = "u" }), {
  description = d("Focus window above", "Focar janela acima")
})
hl.bind(SP .. " + DOWN", hl.dsp.focus({ direction = "d" }), {
  description = d("Focus window below", "Focar janela abaixo")
})

-- --------------------------------------------------------------
-- Workspaces
-- --------------------------------------------------------------

-- SUPER + [1-9]
for i = 1, 9 do
  local key = tostring(i)

  hl.bind(
    SP .. " + " .. key,
    hl.dsp.focus({ workspace = key }),
    { description = d("Switch to workspace " .. key, "Mudar para a área de trabalho " .. key) }
  )

  hl.bind(
    SP .. " + SHIFT + " .. key,
    hl.dsp.window.move({ workspace = key }),
    { description = d("Move focused window to workspace " .. key, "Mover janela em foco para a área de trabalho " .. key) }
  )
end

-- SUPER + 0 = workspace 10
hl.bind(SP .. " + 0", hl.dsp.focus({ workspace = "10" }), {
  description = d("Switch to workspace 10", "Mudar para a área de trabalho 10")
})
hl.bind(SP .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }), {
  description = d("Move focused window to workspace 10", "Mover janela em foco para a área de trabalho 10")
})

-- --------------------------------------------------------------
-- Monitor switching
-- --------------------------------------------------------------

-- Snappy Switcher: standard Alt+Tab MRU window switching.
-- The previous Alt+Tab monitor binding was replaced to avoid a key conflict.
hl.bind(
  "ALT + TAB",
  hl.dsp.exec_cmd("snappy-switcher next --mod alt"),
  { description = d("Cycle windows with Snappy Switcher", "Alternar entre janelas com o Snappy Switcher") }
)

-- --------------------------------------------------------------
-- Special workspace / scratchpad
-- --------------------------------------------------------------

hl.bind(SP .. " + S", hl.dsp.workspace.toggle_special("magic"), {
  description = d("Toggle magic scratchpad", "Alternar scratchpad mágico")
})

hl.bind(
  SP .. " + SHIFT + S",
  hl.dsp.window.move({ workspace = "special:magic" }),
  { description = d("Move focused window to magic scratchpad", "Mover janela em foco para o scratchpad mágico") }
)

-- --------------------------------------------------------------
-- Workspace scrolling
-- --------------------------------------------------------------

hl.bind(
  SP .. " + mouse_down",
  hl.dsp.focus({ workspace = "e+1" }),
  { description = d("Switch to next workspace", "Mudar para a próxima área de trabalho") }
)

hl.bind(
  SP .. " + mouse_up",
  hl.dsp.focus({ workspace = "e-1" }),
  { description = d("Switch to previous workspace", "Mudar para a área de trabalho anterior") }
)

-- --------------------------------------------------------------
-- Move / resize windows with mouse
-- --------------------------------------------------------------

hl.bind(
  SP .. " + mouse:272",
  hl.dsp.window.drag(),
  { mouse = true, description = d("Move window with mouse", "Mover janela com o mouse") }
)

hl.bind(
  SP .. " + mouse:273",
  hl.dsp.window.resize(),
  { mouse = true, description = d("Resize window with mouse", "Redimensionar janela com o mouse") }
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
  ),
  { description = d("Capture a region to clipboard", "Capturar uma região para a área de transferência") }
)

-- SUPER + ALT + P = screenshot → Satty
hl.bind(
  SP .. " + ALT + P",
  hl.dsp.exec_cmd(
    "grimblast --freeze save area - | satty -f - --copy-command wl-copy"
  ),
  { description = d("Capture a region and annotate with Satty", "Capturar uma região e anotar com o Satty") }
)

-- --------------------------------------------------------------
-- OBS - WebSocket Controls
-- --------------------------------------------------------------

hl.bind(
  "ALT + Z",
  hl.dsp.exec_cmd("obs-control replay save"),
  { description = d("OBS: Save Replay Buffer", "OBS: Salvar buffer de replay") }
)

hl.bind(
  "ALT + F10",
  hl.dsp.exec_cmd("obs-control recording toggle"),
  { description = d("OBS: Toggle Recording", "OBS: Alternar gravação") }
)

-- --------------------------------------------------------------
-- Audio
-- --------------------------------------------------------------

hl.bind( "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+"),
  { locked = true, description = d("Increase volume", "Aumentar volume") }
)

hl.bind( "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
  { locked = true, description = d("Decrease volume", "Diminuir volume") }
)

hl.bind( "XF86AudioMute",
  hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, description = d("Toggle mute", "Alternar silenciamento") }
)

hl.bind( "XF86AudioNext",
  hl.dsp.exec_cmd("mpc next"),
  { locked = true, description = d("Next track", "Próxima faixa") }
)

hl.bind( "XF86AudioPrev",
  hl.dsp.exec_cmd("mpc prev"),
  { locked = true, description = d("Previous track", "Faixa anterior") }
)

-- --------------------------------------------------------------
-- Custom Cava background
-- --------------------------------------------------------------

hl.bind(
  SP .. " + SHIFT + C",
  hl.dsp.exec_cmd("~/Documents/scripts/kittycava.sh"),
  { description = d("Open Cava visualizer", "Abrir visualizador Cava") }
)

-- --------------------------------------------------------------
-- Task Manager
-- --------------------------------------------------------------

hl.bind(
  "CTRL + SHIFT + escape",
  hl.dsp.exec_cmd("kitty -e btop"),
  { description = d("Open system monitor (btop)", "Abrir monitor do sistema (btop)") }
)

-- --------------------------------------------------------------
-- Disabled / old bindings kept as comments
-- --------------------------------------------------------------

-- hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl -a play-pause"), { locked = true })
-- hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl -a play-pause"), { locked = true })

-- bind = CTRL ALT, right, workspace, +1
-- bind = CTRL ALT, left, workspace, -1
-- bind = SUPER, M, exec, pavucontrol-qt
