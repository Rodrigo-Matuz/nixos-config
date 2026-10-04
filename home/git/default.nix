{ config, pkgs, inputs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Rodrig-Matuz";
        email = "rodrigosantoslima1311@gmail.com";
      };

    #   init.defaultBranch = "main";
    #
    #   pull.rebase = true;
    #
    #   push = {
    #     autoSetupRemote = true;
    #     followTags = true;
    #   };
    #
    #   fetch.prune = true;
    #
    #   merge.conflictStyle = "zdiff3";
    #
    #   rerere.enabled = true;
    #
    #   core = {
    #     editor = "nvim";
    #     autocrlf = "input";
    #   };
    #
    #   diff = {
    #     algorithm = "histogram";
    #     colorMoved = "default";
    #   };
    #
    #   branch.sort = "-committerdate";
    #   tag.sort = "version:refname";
    };
  };
}
