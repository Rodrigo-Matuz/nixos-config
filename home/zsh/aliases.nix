{
  programs.zsh.shellAliases = {
    # -------------------------------------------------------------------------
    # Navigation
    # -------------------------------------------------------------------------
    ".." = "cd ..";
    mkdir = "mkdir -p";
    sudodir = "sudo mkdir -p";

    # -------------------------------------------------------------------------
    # Editors / CLI
    # -------------------------------------------------------------------------
    vi = "nvim";
    cat = "bat";
    cls = "clear";
    task = "btop";
    tm = "tmux";
    img = "kitten icat";
    ff = "fastfetch -l ~/.config/fastfetch/logo.txt";
    sdedit = "sudoedit";

    # -------------------------------------------------------------------------
    # Media
    # -------------------------------------------------------------------------
    mp = "musikcube";

    yt-audio =
      "yt-dlp -f bestaudio --extract-audio --audio-format 'opus' --audio-quality 0 --add-metadata";

    yt-video =
      "yt-dlp -f bestvideo+bestaudio --recode-video mov";

    yt-video-4k =
      "yt-dlp -f 'bestvideo[height<=2160]+bestaudio/best' -o '%(title)s.%(ext)s'";

    # -------------------------------------------------------------------------
    # Applications
    # -------------------------------------------------------------------------
    ani = "jerry --rofi";
    code = "codium";
  };
}
