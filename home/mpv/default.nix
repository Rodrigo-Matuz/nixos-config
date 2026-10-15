{ pkgs, ... }:

{
  home.packages = [
    pkgs.mpv
    pkgs.yt-dlp
    pkgs.ffmpeg
  ];

  xdg.configFile."mpv/mpv.conf".text = ''
    # ModernZ replaces mpv's stock on-screen controller.
    osc=no
    # ModernZ dynamically moves subtitles above its controller.
    watch-later-options-remove=sub-pos
  '';

  # Expose mpv through MPRIS so Caelestia can show metadata, artwork, and controls.
  xdg.configFile."mpv/scripts/mpris.so".source =
    "${pkgs.mpvScripts.mpris}/share/mpv/scripts/mpris.so";

  xdg.configFile."mpv/scripts/modernz.lua".source = ./modernz.lua;
  xdg.configFile."mpv/script-opts/modernz.conf".source = ./modernz.conf;
  xdg.configFile."mpv/fonts/modernz-icons.ttf".source = ./modernz-icons.ttf;
}
