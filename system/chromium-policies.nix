{ ... }:

let
  chromeWebStoreUpdateUrl = "https://clients2.google.com/service/update2/crx";

  # Reuse the workstation Firefox bookmark source, converting its `bookmarks`
  # folders and links into Chromium's ManagedBookmarks policy format.
  firefoxBookmarks = import ../home/firefox/bookmarks.nix;
  firefoxToolbar = builtins.head (
    builtins.filter (bookmark: bookmark ? toolbar && bookmark.toolbar) firefoxBookmarks
  );

  toManagedBookmark = bookmark:
    if builtins.isString bookmark then
      null
    else if bookmark ? url then
      {
        name = bookmark.name;
        url = bookmark.url;
      }
    else
      {
        name = bookmark.name;
        children = builtins.filter (child: child != null)
          (map toManagedBookmark bookmark.bookmarks);
      };

  managedBookmarks = [
    { toplevel_name = firefoxToolbar.name; }
  ] ++ builtins.filter (bookmark: bookmark != null)
    (map toManagedBookmark firefoxToolbar.bookmarks);

  # Firefox's uBlock Origin is not duplicated here: Helium ships its own
  # built-in uBlock Origin fork. The remaining compatible Chromium extensions
  # are installed through the standard Chromium extension policy.
  extensionInstallForcelist = map
    (id: "${id};${chromeWebStoreUpdateUrl}")
    [
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
      "enamippconapkdmgfgjchkhakpfinmaj" # DeArrow
      "ponfpcnoihfmfllpaingbgckeeldkhle" # Enhancer for YouTube
      "fcjmgeodgobggcppooncdagfkogfffdm" # Imagus Reborn (Chromium equivalent)
    ];
in
{
  # Chromium-family browsers read this Linux managed-policy directory. Keep
  # this small system bridge separate from the user-owned Helium application
  # module; managed bookmarks and forced extensions cannot be reliably written
  # from Home Manager's user policy path.
  environment.etc."chromium/policies/managed/helium.json".text = builtins.toJSON {
    BrowserSignin = 0;
    SyncDisabled = true;
    MetricsReportingEnabled = false;
    BookmarkBarEnabled = true;
    ManagedBookmarks = managedBookmarks;
    ExtensionInstallForcelist = extensionInstallForcelist;
  };
}
