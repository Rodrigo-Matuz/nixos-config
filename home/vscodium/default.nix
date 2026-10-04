{ pkgs, ... }:

{
  programs.vscodium = {
    enable = true;

    profiles.default = {
      userSettings = {
        "window.menuBarVisibility" = "toggle";
        "workbench.colorTheme" = "Sweet Dracula Monokai";
        "symbols.hidesExplorerArrows" = false;
        "workbench.iconTheme" = "catppuccin-mocha";
        "workbench.activityBar.location" = "top";
        "window.customTitleBarVisibility" = "auto";
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "security.workspace.trust.untrustedFiles" = "open";
        "json.schemaDownload.trustedDomains" = {
          "https://schemastore.azurewebsites.net/" = true;
          "https://raw.githubusercontent.com/microsoft/vscode/" = true;
          "https://raw.githubusercontent.com/devcontainers/spec/" = true;
          "https://kubernetes-schemas.pages.dev/" = true;
          "https://raw.githubusercontent.com/" = true;
          "https://www.schemastore.org/" = true;
          "https://json.schemastore.org/" = true;
          "https://json-schema.org/" = true;
          "https://developer.microsoft.com/json-schemas/" = true;
          "https://biomejs.dev" = true;
        };
      };

      extensions =
        with pkgs.vscode-marketplace;
        [
          adamcaviness.theme-monokai-dark-soda
          biomejs.biome
          catppuccin.catppuccin-vsc-icons
          lefd.sweetdracula-monokai
          ms-vscode.vscode-typescript-next
        ];
    };
  };
}
