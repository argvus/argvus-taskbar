PREFIX ?= /usr
DESTDIR ?=
INSTALL ?= install
RM ?= rm -f

.DEFAULT_GOAL := help

.PHONY: help install uninstall validate build clean

help:
	@echo "Available targets:"
	@echo "  make build"
	@echo "  make install"
	@echo "  make uninstall"
	@echo "  make validate"

install:
	$(INSTALL) -Dm755 src/usr/bin/argvus-taskbar-actions "$(DESTDIR)$(PREFIX)/bin/argvus-taskbar-actions"
	$(INSTALL) -dm755 "$(DESTDIR)$(PREFIX)/share/argvus/taskbar"
	cp -R --no-preserve=ownership src/usr/share/argvus/taskbar/. "$(DESTDIR)$(PREFIX)/share/argvus/taskbar/"
	find "$(DESTDIR)$(PREFIX)/share/argvus/taskbar/sh" -type f -name '*.sh' -exec chmod 755 {} \;
	$(INSTALL) -Dm644 LICENSE "$(DESTDIR)$(PREFIX)/share/licenses/argvus-taskbar/LICENSE"

uninstall:
	$(RM) "$(DESTDIR)$(PREFIX)/bin/argvus-taskbar-actions"
	rm -rf "$(DESTDIR)$(PREFIX)/share/argvus/taskbar"
	$(RM) "$(DESTDIR)$(PREFIX)/share/licenses/argvus-taskbar/LICENSE"

validate:
	@set -eu; \
	test -x src/usr/bin/argvus-taskbar-actions; \
	test -f src/usr/share/argvus/taskbar/config/argvus-taskbar.jsonc; \
	test -f src/usr/share/argvus/taskbar/config/argvus-taskbar.css; \
	scripts="src/usr/bin/argvus-taskbar-actions $$(find src/usr/share/argvus/taskbar/sh -type f -name '*.sh' | sort)"; \
	for script in $$scripts; do sh -n "$$script"; done; \
	if command -v shellcheck >/dev/null 2>&1; then shellcheck -e SC1090 -e SC1091 -e SC2034 $$scripts; else echo "shellcheck not found; skipped"; fi; \
	for theme in src/usr/share/argvus/taskbar/config/themes/*; do test -f "$$theme/theme.css"; done
	@echo "argvus-taskbar validation ok"

build:
	@tools/build-local-package.sh

clean:
	rm -rf dist
	rm -f packaging/arch/*.zst packaging/arch/*.tar.gz
