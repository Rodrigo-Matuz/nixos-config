# Git

Enables Git. The original workstation supplies its own author name and email in
its base configuration; the reusable module does not copy those values to other
machines.

During portable installation, the script optionally asks for the new user's
name and email. Leave both blank to configure Git later. To set them manually,
use the `matuz.git.authorName` and `matuz.git.authorEmail` options in the profile.

The module is active on the workstation and can be selected during installation.
