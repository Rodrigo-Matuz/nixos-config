hl.on("hyprland.start", function()
  hl.exec_cmd(
    'rm -rf ~/.config/obs-studio/.sentinel && sleep 2 && obs --startreplaybuffer --minimize-to-tray --scene "DP-2"'
  )
end)
