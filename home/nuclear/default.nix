{ inputs, ... }: {
  imports = [ inputs.nuclear.homeManagerModules.default ];
  programs.nuclear-music-player.enable = true;
}
