# Optional workstation secrets (sops-nix + age)

The portable `#install` profile **never imports this module** and needs no keys,
API tokens, or encrypted files. The workstation `#nixos` imports
[`../secrets.nix`](../secrets.nix) with `matuz.secrets.hermes.enable = false` by
default. GitHub CLI login and Hermes browser OAuth can remain entirely local;
use this only for API credentials you explicitly want deployed by Nix.

To opt the *original matuz workstation* in:

1. Create a **root-owned, mode-0600** age identity outside Git (for example
   `/var/lib/sops-nix/key.txt`, in a mode-0700 directory). Back it up securely
   and make a separate offline recovery age identity. Generate public
   recipients with `age-keygen -y PATH_TO_KEY` (use `sudo` for the root key).
   Never commit either private key. A replacement machine cannot decrypt a
   file addressed only to the old machine key.
2. Prepare a private dotenv file elsewhere containing only the desired
   `NAME=value` API credentials. Encrypt it to **both** public recipients:

   ```bash
   sops encrypt --age "$MACHINE_PUBLIC,$RECOVERY_PUBLIC" \
     --input-type dotenv --output-type dotenv \
     --output secrets/hermes.enc /private/path/hermes.env
   ```

   Confirm `secrets/hermes.enc` contains ciphertext and sops metadata, not
   plaintext, before tracking it. Do not put the plaintext in this checkout;
   the `*.env` ignore rule does not protect history or forced additions.
3. In the workstation configuration only, set
   `matuz.secrets.hermes.enable = true;` after the encrypted file and age
   identity exist. Stage the *encrypted* file so the Git flake includes it,
   evaluate/dry-build `.#nixos`, then switch only when ready. The NixOS
   sops-nix module decrypts it at activation to a runtime path owned by
   `matuz` with mode `0400`; Home Manager points Hermes at that path.
4. Verify the user service starts, and privately check the effective Hermes
   home (`HERMES_HOME`). **Hermes copies `environmentFiles` into its persistent
   `.env` at activation**; this is not ephemeral systemd-only injection.
   Restrict and back up the profile separately. A named Hermes profile needs
   explicit home/profile wiring before assuming this reaches it.

No public ciphertext, key, or service change is enabled automatically. API
secrets cannot be used at Nix evaluation time and must never be interpolated
into Nix strings, `environment`, or generated store files. Rotate credentials
if they ever appeared in Git history. For GitHub, prefer interactive
`gh auth login` over declaring a PAT. For OBS, keep its WebSocket password in
its existing user-owned, mode-0600 file, outside Git.

References: [sops-nix](https://github.com/Mic92/sops-nix),
[Hermes Nix secrets](https://hermes-agent.nousresearch.com/docs/getting-started/nix-setup#secrets-management).
