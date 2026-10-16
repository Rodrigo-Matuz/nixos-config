# Optional secrets

The normal workstation and the portable installer work without this directory.
Use it only when you deliberately want to deploy encrypted API credentials to
the original workstation.

## Important rules

- Never commit a private age key or a plaintext `.env` file.
- Keep the machine key root-owned and readable only by root.
- Keep a recovery key offline.
- Do not put secrets in Nix strings, environment declarations, or generated
  store files. Values in the Nix store are not private.

## Workstation setup

1. Install an age identity outside this repository, such as
   `/var/lib/sops-nix/key.txt`, with root-only permissions.
2. Create an encrypted dotenv file elsewhere and encrypt it to both the machine
   and recovery public keys:

   ```bash
   sops encrypt \
     --age "$MACHINE_PUBLIC,$RECOVERY_PUBLIC" \
     --input-type dotenv --output-type dotenv \
     --output secrets/hermes.enc /private/path/hermes.env
   ```

3. Confirm that `secrets/hermes.enc` contains ciphertext, not plaintext.
4. Set `matuz.secrets.hermes.enable = true;` in `../secrets.nix`, then dry-build before
   switching.

The portable `#install` profile never imports this module. App logins such as
`gh auth login` and Hermes OAuth should normally be done interactively instead.

If a credential ever reached Git history, rotate it. Removing the file is not
enough.

Links: [sops-nix](https://github.com/Mic92/sops-nix) ·
[Hermes secrets setup](https://hermes-agent.nousresearch.com/docs/getting-started/nix-setup#secrets-management)
