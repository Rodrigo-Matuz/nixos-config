{
  # ------------------------------------------------------------
  # Startup
  # ------------------------------------------------------------

  "browser.startup.page" = 3;
  "browser.startup.homepage" = "about:blank";

  # ------------------------------------------------------------
  # Privacy / Tracking
  # ------------------------------------------------------------

  # Firefox Strict Enhanced Tracking Protection.
  "browser.contentblocking.category" = "strict";

  # Do NOT enable LibreWolf's fingerprinting resistance.
  # It can break compatibility and isn't necessary for this setup.
  #
  # "privacy.resistFingerprinting" = true;

  # ------------------------------------------------------------
  # HTTPS
  # ------------------------------------------------------------

  "dom.security.https_only_mode" = true;

  # ------------------------------------------------------------
  # Permissions
  # ------------------------------------------------------------

  # Ask before allowing sites to access these.
  "permissions.default.camera" = 2;
  "permissions.default.microphone" = 2;
  "permissions.default.geo" = 2;

  # ------------------------------------------------------------
  # WebRTC
  # ------------------------------------------------------------

  # Leave WebRTC unrestricted for compatibility with calls/Meet/etc.

  # ------------------------------------------------------------
  # Telemetry
  # ------------------------------------------------------------

  "datareporting.healthreport.uploadEnabled" = false;
  "datareporting.policy.dataSubmissionEnabled" = false;
  "toolkit.telemetry.enabled" = false;
  "toolkit.telemetry.unified" = false;
  "toolkit.telemetry.archive.enabled" = false;

  "browser.newtabpage.activity-stream.feeds.telemetry" = false;
  "browser.newtabpage.activity-stream.telemetry" = false;

  # ------------------------------------------------------------
  # Pocket / Recommendations
  # ------------------------------------------------------------

  "extensions.pocket.enabled" = false;
  "browser.newtabpage.activity-stream.showSponsored" = false;
  "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

  # ------------------------------------------------------------
  # Cookies / Sessions
  # ------------------------------------------------------------

  # Intentionally DON'T set network.cookie.cookieBehavior.
  #
  # Firefox should retain cookies so Google and other websites
  # can keep you logged in.

  # ------------------------------------------------------------
  # Autoplay
  # ------------------------------------------------------------

  "media.autoplay.default" = 5;

  # ------------------------------------------------------------
  # Downloads
  # ------------------------------------------------------------

  "browser.download.useDownloadDir" = true;
  "browser.download.alwaysOpenPanel" = false;

  # ------------------------------------------------------------
  # UI
  # ------------------------------------------------------------

  "browser.compactmode.show" = true;
  "browser.uidensity" = 1;
  "browser.tabs.closeWindowWithLastTab" = false;

  # ------------------------------------------------------------
  # Theme / Rendering
  # ------------------------------------------------------------

  # Allow userChrome.css / userContent.css
  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

  # Keep declaratively installed extensions enabled in this profile.
  "extensions.autoDisableScopes" = 0;

  # Transparency
  # "widget.transparent-windows" = true;
  # "browser.tabs.allow_transparent_browser" = true;
  # "widget.wayland.opaque-region.enabled" = false;

  # Required by some modern Firefox themes/icons
  # "svg.context-properties.content.enabled" = true;

  # Hardware acceleration / WebRender
  # "layers.acceleration.force-enabled" = true;
  # "gfx.webrender.all" = true;
  # "gfx.webrender.enabled" = true;

  # CSS backdrop-filter support
  # "layout.css.backdrop-filter.enabled" = true;

  # Firefox UI customization
  # "userChrome.theme-chrome-refresh" = true;
  # "userChrome.ui-chrome-refresh" = true;
  # "userChrome.ui-compact-url-bar" = true;
}
