# argvus-taskbar

<div align="center">

[![CI](https://github.com/argvus/argvus-taskbar/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/argvus/argvus-taskbar/actions/workflows/ci.yml)
[![License](https://img.shields.io/github/license/argvus/argvus-taskbar)](./LICENSE)
[![Language: Shell](https://img.shields.io/badge/Shell-POSIX-4EAA25?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Platform: Arch Linux | Wayland](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Wayland-1793D1?logo=archlinux&logoColor=white)](https://archlinux.org/)
[![Pull requests](https://img.shields.io/github/issues-pr/argvus/argvus-taskbar)](https://github.com/argvus/argvus-taskbar/pulls)
[![Issues](https://img.shields.io/github/issues/argvus/argvus-taskbar)](https://github.com/argvus/argvus-taskbar/issues)
[![Last commit](https://img.shields.io/github/last-commit/argvus/argvus-taskbar)](https://github.com/argvus/argvus-taskbar/commits/main)
[![Docs](https://img.shields.io/badge/docs-project-blue)](./docs/)

</div>

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
