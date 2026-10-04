hl.on("hyprland.start", function()
    hl.exec_cmd('rm -rf ~/.config/obs-studio/.sentinel && sleep 2 && obs --startreplaybuffer --scene "DP-2"')
end)
