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
	$(INSTALL) -dm755 "$(DESTDIR)$(PREFIX)/lib/argvus-taskbar"
	cp -R --no-preserve=ownership src/usr/lib/argvus-taskbar/. "$(DESTDIR)$(PREFIX)/lib/argvus-taskbar/"
	find "$(DESTDIR)$(PREFIX)/lib/argvus-taskbar" -type f -name '*.sh' -exec chmod 755 {} \;
	$(INSTALL) -dm755 "$(DESTDIR)$(PREFIX)/share/argvus/waybar"
	cp -R --no-preserve=ownership src/waybar/. "$(DESTDIR)$(PREFIX)/share/argvus/waybar/"
	$(INSTALL) -dm755 "$(DESTDIR)$(PREFIX)/share/argvus/scripts/apps"
	ln -sfn "$(PREFIX)/bin/argvus-taskbar-actions" "$(DESTDIR)$(PREFIX)/share/argvus/scripts/apps/waybar-taskbar.sh"
	$(INSTALL) -Dm644 LICENSE "$(DESTDIR)$(PREFIX)/share/licenses/argvus-taskbar/LICENSE"

uninstall:
	$(RM) "$(DESTDIR)$(PREFIX)/bin/argvus-taskbar-actions"
	$(RM) "$(DESTDIR)$(PREFIX)/share/argvus/scripts/apps/waybar-taskbar.sh"
	$(RM) "$(DESTDIR)$(PREFIX)/share/argvus/waybar/argvus-taskbar.jsonc"
	$(RM) "$(DESTDIR)$(PREFIX)/share/argvus/waybar/argvus-taskbar.css"
	for theme in src/waybar/themes/*; do $(RM) "$(DESTDIR)$(PREFIX)/share/argvus/waybar/themes/$${theme##*/}/theme.css"; done
	rm -rf "$(DESTDIR)$(PREFIX)/lib/argvus-taskbar"
	$(RM) "$(DESTDIR)$(PREFIX)/share/licenses/argvus-taskbar/LICENSE"

validate:
	@set -eu; \
	test -x src/usr/bin/argvus-taskbar-actions; \
	test -f src/waybar/argvus-taskbar.jsonc; \
	test -f src/waybar/argvus-taskbar.css; \
	scripts="src/usr/bin/argvus-taskbar-actions $$(find src/usr/lib/argvus-taskbar -type f -name '*.sh' | sort)"; \
	for script in $$scripts; do sh -n "$$script"; done; \
	if command -v shellcheck >/dev/null 2>&1; then shellcheck -e SC1090 -e SC1091 -e SC2034 $$scripts; else echo "shellcheck not found; skipped"; fi; \
	for theme in src/waybar/themes/*; do test -f "$$theme/theme.css"; done
	@echo "argvus-taskbar validation ok"

build:
	@tools/build-local-package.sh

clean:
	rm -rf dist
	rm -f packaging/arch/*.zst packaging/arch/*.tar.gz
