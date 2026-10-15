# Defaults for evaluation only. install.sh rewrites this file in the installed clone.
{
  username = "nixos";
  hostname = "nixos";
  timeZone = "Etc/UTC";
  stateVersion = "26.05";
  homeModules = [ ];
  systemModules = [ ];
  autoLogin = false; # installer asks for real hosts; VM variant always logs in
  gitAuthorName = null;
  gitAuthorEmail = null;
  partitionOwnerUid = null; # set only for explicit data-mount selections
}
