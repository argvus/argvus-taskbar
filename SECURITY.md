# Security Policy

Only the latest tagged release is actively supported.

Please do not open a public issue for security vulnerabilities. Report them
privately through [GitHub Security Advisories](https://github.com/argvus/argvus-taskbar/security/advisories/new)
or contact the maintainers directly.

Include the affected version, reproduction steps, impact, and a suggested fix
when possible.

Published packages are GPG-signed. Verify a downloaded package with:

```sh
gpg --verify argvus-taskbar-VERSION-1-any.pkg.tar.zst.sig argvus-taskbar-VERSION-1-any.pkg.tar.zst
```

The source archive checksum is generated and validated by the packaging
workflow; repository PKGBUILDs intentionally keep `sha256sums=()` empty.
