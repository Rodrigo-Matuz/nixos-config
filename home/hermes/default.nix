{ config, pkgs, inputs, ... }:

{
  programs.hermes-agent = {
    enable = true;

    desktop.enable = true;
  };

  services.hermes-agent = {
    enable = true;

    backend = {
      mode = "serve";
      port = 9119;
    };

    settings = {
      model = {
        provider = "openai-codex";

        # Pode trocar pelo modelo que quiser usar.
        default = "gpt-5.6";
      };

      auth = {
        # Recomendo false se você também usa o Codex CLI.
        # Evita Hermes e Codex brigando pelo mesmo refresh token.
        adopt_external_logins = false;

        # Opcional: usa OAuth normal pelo navegador.
        codex_login_flow = "browser";
      };

      agent = {
        reasoning_effort = "high";
      };

      toolsets = [ "all" ];

      terminal = {
        backend = "local";
        timeout = 180;
      };

      memory = {
        memory_enabled = true;
        user_profile_enabled = true;
      };
    };

    environmentFiles = [
      "/var/lib/hermes/env"
    ];
  };
}
