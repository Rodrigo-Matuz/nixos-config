# Desktop GTK/Qt theme

Configures the desktop-wide dark appearance for GTK and Qt applications:

- Packages the upstream `Fantasy` icon theme and selects `Fantasy-blue-dark`.
- Applies `MatuzDark` to GTK 3/4 and GSettings, matching the KDE scheme's dark surfaces and blue selection. GTK 3 retains Adwaita widget rules; GTK 4/libadwaita only accepts partial CSS overrides.
- Uses KDE's Qt platform integration with the existing `MatuzDark` KDE color scheme.
- Keeps Breeze as the Qt widget style and uses Fantasy icons through `kdeglobals`.

The GTK palette lives in [`gtk-3.0/gtk.css`](gtk-3.0/gtk.css) and
[`gtk-4.0/gtk.css`](gtk-4.0/gtk.css); Dolphin remains a Qt application
and reads the KDE color scheme, not the GTK theme.
The GTK 3 portal file chooser gets navy title, breadcrumb and column headers
from [`gtk-3.0/file-chooser.css`](gtk-3.0/file-chooser.css). Home Manager
installs this as user CSS at higher priority than Adwaita's imported theme CSS;
the GTK 4 theme receives matching navy headers. Inactive GTK 3 dialogs keep
navy surfaces with muted text rather than Adwaita's gray backdrop. Qt file
dialogs still use KDE colors.

The GTK portal is long-running and loads user CSS at startup. After activating
the new Home Manager generation, close any open file dialogs and restart
`xdg-desktop-portal-gtk.service` (or log out and back in) to load the CSS.

The Fantasy theme is pinned to upstream commit
`993280f3117bbe1eebcfc5dfa07f33a36845edc7`.
