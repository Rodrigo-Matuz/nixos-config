{ config, lib, ... }:
let
  identity = config.matuz.git;
in
{
  options.matuz.git = {
    authorName = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Optional Git author name (never default to the repository owner's identity on portable installs).";
    };
    authorEmail = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Optional Git author email.";
    };
  };

  config.programs.git = {
    enable = true;
    settings = lib.optionalAttrs (identity.authorName != null || identity.authorEmail != null) {
      user = lib.optionalAttrs (identity.authorName != null) { name = identity.authorName; }
        // lib.optionalAttrs (identity.authorEmail != null) { email = identity.authorEmail; };
    };
  };
}
