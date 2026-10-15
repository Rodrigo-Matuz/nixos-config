# Hermes Agent

Enables the Hermes Agent desktop application and Home Manager service. The local
backend listens on port `9119`; the configuration selects the `openai-codex`
provider, high reasoning, all toolsets, local terminal execution, and memory.

There is **no required secret file**: installing this module works before a user
has credentials. Sign in interactively after installation (`hermes model` /
`hermes setup`), or opt the workstation into
[encrypted API credentials](../../secrets/README.md) after provisioning a key
and ciphertext. OAuth tokens live in the user's Hermes `auth.json`, outside Git.
`environmentFiles` is not a systemd-only setting: the Hermes module merges its
content into a persistent `$HERMES_HOME/.env` at activation. Keep that profile
private and back it up accordingly. Named profiles need their own `HERMES_HOME`.
The local `hermes-profile.gz` archive is ignored, **not** safe to publish or
keep world-readable; move it outside the checkout.

## Upstream and original sources

- [Hermes Agent](https://github.com/NousResearch/hermes-agent) — application, CLI, Nix integration, and source.
- [Hermes Agent documentation](https://hermes-agent.nousresearch.com/docs) — current configuration reference.
- [Home Manager](https://github.com/nix-community/home-manager) — module/service framework.

## Module

Imported by [`../matuz.nix`](../matuz.nix); implementation is in
[`default.nix`](default.nix). Do not commit `auth.json`, `.env`, session data, or a live profile.
