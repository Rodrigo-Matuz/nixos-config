{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = "source ${pkgs.zsh-powerlevel10k}/share/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme && [[ -r ~/.p10k.zsh ]] && source ~/.p10k.zsh; [[ -z \"$DISPLAY\" && -z \"$WAYLAND_DISPLAY\" && \"$(tty)\" == \"/dev/tty1\" ]] && exec start-hyprland";

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
      }
    ];
  };
}
