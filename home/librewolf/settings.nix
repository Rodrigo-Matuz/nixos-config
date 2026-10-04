{
  # ------------------------------------------------------------
  # Startup
  # ------------------------------------------------------------
  "browser.startup.page" = 3;
  # Restore previous session.
  "browser.startup.homepage" = "about:blank";
  # ------------------------------------------------------------
  # Privacy
  # ------------------------------------------------------------
  # Keep LibreWolf's anti-fingerprinting protection.
  "privacy.resistFingerprinting" = true;
  # Letterboxing makes arbitrary window sizes less useful
  # for fingerprinting.
  "privacy.resistFingerprinting.letterboxing" = false;
  # Strict tracking protection.
  "browser.contentblocking.category" = "strict";
  # Do not allow third-party cookies outside the partition.
  "network.cookie.cookieBehavior" = 5;
  # ------------------------------------------------------------
  # WebRTC
  # ------------------------------------------------------------
  # Prevent WebRTC from exposing local IP addresses.
  "media.peerconnection.ice.no_host" = true;
  # ------------------------------------------------------------
  # Telemetry / experiments
  # ------------------------------------------------------------
  "datareporting.healthreport.uploadEnabled" = false;
  "datareporting.policy.dataSubmissionEnabled" = false;
  "toolkit.telemetry.enabled" = false;
  "toolkit.telemetry.unified" = false;
  "toolkit.telemetry.archive.enabled" = false;
  "browser.newtabpage.activity-stream.feeds.telemetry" = false;
  "browser.newtabpage.activity-stream.telemetry" = false;
  # ------------------------------------------------------------
  # Pocket / recommendations
  # ------------------------------------------------------------
  "extensions.pocket.enabled" = false;
  "browser.newtabpage.activity-stream.showSponsored" = false;
  "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
  # ------------------------------------------------------------
  # UI
  # ------------------------------------------------------------
  "browser.compactmode.show" = true;
  "browser.uidensity" = 1;
  "browser.tabs.closeWindowWithLastTab" = false;
  # ------------------------------------------------------------
  # Downloads
  # ------------------------------------------------------------
  "browser.download.useDownloadDir" = true;
  "browser.download.alwaysOpenPanel" = false;
  # ------------------------------------------------------------
  # Permissions
  # ------------------------------------------------------------
  "permissions.default.camera" = 2;
  "permissions.default.microphone" = 2;
  "permissions.default.geo" = 2;
  # ------------------------------------------------------------
  # Autoplay
  # ------------------------------------------------------------
  # Block autoplay by default.
  "media.autoplay.default" = 5;
  # ------------------------------------------------------------
  # HTTPS
  # ------------------------------------------------------------
  "dom.security.https_only_mode" = true;
}
