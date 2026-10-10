{ inputs, ... }: {
  imports = [ inputs.kanatype.homeManagerModules.default ];
  programs.kanatype.enable = true;
}
