# Hermes Agent

Enables the Hermes Agent desktop application and Home Manager service. The local
backend listens on port `9119`; the configuration selects the `openai-codex`
provider, high reasoning, all toolsets, local terminal execution, and memory.

Credentials load from `/var/lib/hermes/env` and are not stored here. The local
profile archive `hermes-profile.gz` is ignored.

## Upstream and original sources

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — application, CLI, Nix integration, and source.
- [Hermes Agent documentation](https://hermes-agent.nousresearch.com/docs) — current configuration reference.
- [Home Manager](https://github.com/nix-community/home-manager) — module/service framework.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix). Keep credentials in the environment file.
