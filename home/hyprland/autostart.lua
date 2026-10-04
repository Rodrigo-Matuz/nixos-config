-- ============================================================

--[[   -- Static wallpaper
  -- Restore last wallpapers
  hl.exec_cmd('~/.local/state/mpvpaper-wallpapers/restore.sh && sleep 2 && pkill -f "mpvpaper-HDMI-A-1"')

  -- Cursor
  hl.exec_cmd("hyprctl setcursor BibataMatuz 12")

  -- D-Bus / systemd activation environment
  hl.exec_cmd("dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

  -- MPD
  hl.exec_cmd("[ ! -s ~/.config/mpd/pid ] && mpd")

  -- Steam
  hl.exec_cmd("steam -silent -console -nofriendsui")

  -- OneDrive
  hl.exec_cmd("rclone --vfs-cache-mode writes mount OneDrive: /mnt/hdd/OneDrive") ]]

-- Disabled:
-- hl.exec_cmd("/usr/bin/swaylock --screenshots --effect-scale 0.5 --effect-pixelate 5x5 --datestr '%Y-%m-%d'")
