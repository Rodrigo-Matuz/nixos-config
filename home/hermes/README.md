# Hermes Agent

Installs the Hermes Agent app and its user service. The local backend listens on
port `9119` and uses the provider settings declared by this profile.

You do not need credentials during installation. After signing in, use Hermes'
own setup commands, such as:

```bash
hermes model
hermes setup
```

Authentication files, sessions, `.env` files, and profile archives belong
outside Git. The optional encrypted setup is documented in
[`../../secrets/README.md`](../../secrets/README.md).

The module is active on the workstation and can be selected in a portable
install. It assumes a user session for its service.

Learn more: [Hermes Agent documentation](https://hermes-agent.nousresearch.com/docs)
