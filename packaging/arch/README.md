# Arch packaging layout

This package keeps two PKGBUILDs because they use different source inputs:

| Path | Use | Source |
| --- | --- | --- |
| `local/PKGBUILD` | local working-tree builds | generated local archive |
| `ci/PKGBUILD` | tagged releases | GitHub tag archive |

Both files share package metadata and payload logic through
`common/functions.sh`. `prepare()` normalizes GitHub's extracted directory to
`${pkgname}-${pkgver}` before `check()` and `package()` run.

Keep generated archives, checksums, `src/`, `pkg/`, and packages out of Git.
Run `make validate && make build` before a release.
