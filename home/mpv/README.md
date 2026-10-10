# mpv with ModernZ

Installs mpv and configures [ModernZ](https://github.com/Samillion/ModernZ), a modern replacement for mpv's stock OSC.

The ModernZ files are copied from commit `579897e8c974c380caa5017dc7b27a69123c1333` and installed declaratively by Home Manager:

- `scripts/modernz.lua` — ModernZ OSC script
- `script-opts/modernz.conf` — Matuz dark-palette configuration
- `fonts/modernz-icons.ttf` — ModernZ icon font
- `mpv.conf` — disables the stock OSC and prevents saved subtitle positions from conflicting with ModernZ
- `yt-dlp` and `ffmpeg` — required by ModernZ's enabled video download control

The vendored ModernZ script uses yt-dlp's single-argument `--format=<value>` form,
so format selection works with mpv's subprocess argument list.

No `nixos-rebuild switch` is performed automatically.
