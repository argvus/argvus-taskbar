# argvus-taskbar

Waybar top panel integration for the ARGVUS desktop.

This repository contains the Arch Linux package payload: the taskbar action
dispatcher, Waybar configuration, themes, and supporting scripts.

## Build and validate

On Arch Linux or a compatible distribution:

```sh
sudo pacman -S --needed base-devel git gnupg make pacman-contrib shellcheck
make validate
make build
```

`make build` creates a deterministic source archive in `build/artifacts/` and
the package in `build/dist/`. See [DEVELOPMENT.md](DEVELOPMENT.md) for local
builds, checksums, and releases.

## Contributing and policies

- [CONTRIBUTING.md](https://github.com/argvus/.github/blob/main/CONTRIBUTING.md) — contribution workflow
- [SECURITY.md](https://github.com/argvus/.github/blob/main/SECURITY.md) — private vulnerability reports
- [Code of Conduct](https://github.com/argvus/.github/blob/main/policies/CODE_OF_CONDUCT.md) — community standards
- [AI usage policy](https://github.com/argvus/.github/blob/main/policies/IA_USAGE.md) — rules for AI-assisted contributions

## License

SPDX: `GPL-3.0-only`. See [LICENSE](LICENSE).
