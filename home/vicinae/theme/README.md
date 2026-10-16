# Matuz theme for Vicinae

A dark Vicinae theme using the Matuz colors:

| Color | Use |
| --- | --- |
| `#050505` | background |
| `#fc1a70` | danger |
| `#702ef3` | primary |
| `#1e65ff` | accent |
| `#ff4d00` | warning |
| `#ffff87` | highlight |
| `#a4e400` | success |

Home Manager generates `matuz-palette.toml` in Vicinae's theme directory. To
select it manually:

```bash
vicinae theme set matuz-palette
```

Vicinae 0.15 and newer use the TOML theme format. The source is in
[`default.nix`](default.nix); the TOML file is included for reference.
