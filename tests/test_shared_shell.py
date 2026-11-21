"""Opt-in test of the shared bars in a nested Hyprland session."""

import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import time
import unittest


SHELL = Path(__file__).resolve().parents[1] / "src/usr/share/argvus/taskbar/quickshell"
SURFACES = ("taskbar", "widget-telemetry", "window-bar")


@unittest.skipUnless(
    os.environ.get("ARGVUS_TEST_SHARED_BARS") == "1"
    and os.environ.get("WAYLAND_DISPLAY")
    and all(shutil.which(command) for command in ("Hyprland", "qs", "hyprctl", "dbus-daemon", "grim")),
    "requires ARGVUS_TEST_SHARED_BARS=1 and a parent Wayland session",
)
class SharedShellTest(unittest.TestCase):
    def test_one_process_and_independent_surface_lifecycles(self):
        Path("/tmp/argvus").mkdir(exist_ok=True)
        with tempfile.TemporaryDirectory(dir="/tmp/argvus") as directory:
            self.check_shell(Path(directory))

    def check_shell(self, root):
        parent = Path(os.environ["XDG_RUNTIME_DIR"]) / os.environ["WAYLAND_DISPLAY"]
        runtime = root / "argvus/bars"
        runtime.mkdir(parents=True)
        config = root / "hyprland.lua"
        config.write_text(
            'hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })\n'
            'hl.config({ animations = { enabled = false } })\n'
        )
        stub = root / "argvus-cli"
        stub.write_text(
            r"""#!/bin/sh
case "$1 $2 $3 $4" in
"windows watch --json ")
    echo '{"floating":true,"position":"top","windows":[]}'
    exec sleep 60
    ;;
"windows ready  ") touch "$XDG_RUNTIME_DIR/floating-ready" ;;
"widget-telemetry toggle visible ") echo system ;;
"networkctl waybar --follow ")
    while [ ! -e "$XDG_RUNTIME_DIR/send-network-status" ]; do sleep 0.1; done
    printf '%s\n' '{"text":"󰖩 Network connected","tooltip":"Network connected\nFixture address"}'
    exec sleep 60
    ;;
"widget-telemetry block header system") echo Header ;;
"widget-telemetry block system ")
    touch "$XDG_RUNTIME_DIR/telemetry-collected"
    echo '{"text":"data"}'
    ;;
esac
"""
        )
        stub.chmod(0o755)
        binary_directory = root / "bin"
        binary_directory.mkdir()
        (binary_directory / "argvus").symlink_to(stub)
        env = dict(
            os.environ,
            WAYLAND_DISPLAY=str(parent),
            XDG_RUNTIME_DIR=str(root),
            XDG_CACHE_HOME=str(root / "cache"),
            XDG_CONFIG_HOME=str(root / "config"),
            ARGVUS_CONFIG_HOME=str(root / "config"),
            QT_QPA_PLATFORM="wayland",
            QT_QUICK_BACKEND="software",
            PATH=f"{binary_directory}:{os.environ['PATH']}",
        )
        env.pop("HYPRLAND_INSTANCE_SIGNATURE", None)

        with (root / "hyprland.log").open("w") as compositor_log:
            compositor = subprocess.Popen(
                ["Hyprland", "-c", str(config)], env=env,
                stdout=compositor_log, stderr=compositor_log,
            )
            try:
                self.wait_for(lambda: (
                    any(path.is_socket() for path in root.glob("wayland-*"))
                    and any(root.glob("hypr/*/.socket.sock"))
                ))
                env["WAYLAND_DISPLAY"] = next(path.name for path in root.glob("wayland-*") if path.is_socket())
                env["HYPRLAND_INSTANCE_SIGNATURE"] = next(root.glob("hypr/*/.socket.sock")).parent.name
                self.check_surfaces(root, runtime, env)
            finally:
                self.stop(compositor)

    def check_surfaces(self, root, runtime, env):
        def layers():
            raw = subprocess.check_output(["hyprctl", "-j", "layers"], env=env, text=True, timeout=2, stderr=subprocess.DEVNULL)
            return {
                layer["namespace"]: layer["pid"]
                for screen in json.loads(raw).values()
                for level in screen["levels"].values()
                for layer in level
            }

        def activate(name):
            pending = runtime / ".pending"
            pending.write_text("enabled\n")
            pending.replace(runtime / f"{name}.active")

        config = ["qs", "-p", str(SHELL)]
        with (root / "shell.log").open("w") as log:
            shell = subprocess.Popen(config, env=env, stdout=log, stderr=log)
            try:
                activate("taskbar")
                activate("window-bar")
                self.wait_for(lambda: all("argvus-" + name in layers() for name in ("taskbar", "window-bar")))
                self.assertNotIn("argvus-widget-telemetry", layers())
                self.check_indicators(root, runtime, env, config)
                activate("widget-telemetry")
                self.wait_for(lambda: all("argvus-" + name in layers() for name in SURFACES))
                self.assertEqual({layers()["argvus-" + name] for name in SURFACES}, {shell.pid})
                self.wait_for(lambda: (root / "telemetry-collected").exists())
                self.wait_for(lambda: (root / "floating-ready").exists())
                (runtime / "widget-telemetry.active").unlink()
                self.wait_for(lambda: "argvus-widget-telemetry" not in layers())
                self.assertEqual(layers()["argvus-taskbar"], shell.pid)
                subprocess.run(config + ["ipc", "call", "taskbar", "toggle"], env=env, check=True)
                self.wait_for(lambda: "argvus-taskbar" not in layers())
                self.assertEqual(layers()["argvus-window-bar"], shell.pid)
            except (AssertionError, subprocess.SubprocessError) as error:
                self.fail(f"{error}\n{(root / 'shell.log').read_text()}")
            finally:
                self.stop(shell)

    def check_indicators(self, root, runtime, env, config):
        def publish(**settings):
            snapshot = json.dumps({"taskbar": {
                "height": 32,
                "foreground": "#ff00ff",
                "background": "#000000",
                "utilityBackground": "#101010",
                "systemBackground": "#202020",
                "animations": False,
                "icons": icons,
                **settings,
            }})
            pending = runtime / ".presentation"
            pending.write_text(snapshot)
            pending.replace(runtime / "presentation.json")
            self.wait_for(lambda: subprocess.check_output(
                config + ["ipc", "call", "bars", "hasPresentation", snapshot],
                env=env, text=True, timeout=2, stderr=subprocess.DEVNULL,
            ).strip() == "true")

        def screenshot():
            result = subprocess.check_output(["grim", "-t", "ppm", "-"], env=env, timeout=3)
            _, dimensions, _, pixels = result.split(b"\n", 3)
            width, height = map(int, dimensions.split())
            return width, height, pixels

        def indicator_pixels():
            width, _, pixels = screenshot()
            visible = memoryview(pixels)
            return sum(
                visible[index] > 180 and visible[index + 1] < 80 and visible[index + 2] > 180
                for row in range(32)
                for index in range((row * width + 80) * 3, (row * width + width - 60) * 3, 3)
            )

        disabled = (
            "launcher mode ai_agents notifications removable_devices recording bluetooth "
            "audio_input audio_output keep_awake update_status power_profile keyboard_layout "
            "battery memory cpu cpu_temperature gpu_temperature focus date audio_player tray"
        )
        icons = {name + "_enabled": False for name in disabled.split()}
        icons.update(clock_enabled=True, network_enabled=False, clipboard_enabled=False)
        publish(utilityExpanded=False, height=28)
        self.wait_for(lambda: indicator_pixels() > 20)
        width, _, pixels = screenshot()

        def active_workspace_at(x, y):
            index = (y * width + x) * 3
            red, green, blue = pixels[index:index + 3]
            return red > 180 and green < 80 and blue > 180

        self.assertTrue(all(active_workspace_at(x, y) for x in range(6, 30) for y in (4, 23)))
        self.assertFalse(any(active_workspace_at(x, y) for x, y in ((5, 4), (30, 4), (6, 3), (6, 24))))

        # The selected workspace must draw its number over the solid highlight.
        ink = sum(not active_workspace_at(x, y) for x in range(10, 26) for y in range(7, 21))
        self.assertGreater(ink, 5)

        def clock_group_at(row):
            index = (row * width + width - 76) * 3
            return pixels[index:index + 3] == b"\x10\x10\x10"

        self.assertTrue(all(clock_group_at(row) for row in (4, 23)))
        self.assertFalse(any(clock_group_at(row) for row in (2, 25)))

        publish(utilityExpanded=False, height=24)
        width, _, pixels = screenshot()
        self.assertGreater(sum(not active_workspace_at(x, y) for x in range(10, 26)
                               for y in range(7, 18)), 5)

        icons.update(clock_enabled=False, network_enabled=True)
        publish(utilityExpanded=False)
        self.wait_for(lambda: indicator_pixels() == 0)
        (root / "send-network-status").touch()
        self.wait_for(lambda: indicator_pixels() > 20)

        def cursor(x, y):
            subprocess.run(
                ["hyprctl", "dispatch", f"hl.dsp.cursor.move({{x={x},y={y}}})"],
                env=env, check=True, timeout=2, capture_output=True,
            )

        def tooltip_surface(color, bottom=False):
            width, height, pixels = screenshot()
            start, end = (height - 120, height - 36) if bottom else (32, 120)
            return pixels[start * width * 3:end * width * 3].count(color) > 30

        publish(utilityExpanded=False, accent="#123456", background="#00ff00")
        width, _, pixels = screenshot()
        xs = [
            x for y in range(32) for x in range(80, width - 60)
            if (pixels[(y * width + x) * 3] > 180
                and pixels[(y * width + x) * 3 + 1] < 80
                and pixels[(y * width + x) * 3 + 2] > 180)
        ]
        cursor((min(xs) + max(xs)) // 2, 16)
        self.wait_for(lambda: tooltip_surface(b"\x00\xff\x00"))
        publish(utilityExpanded=False, accent="#123456", background="#00ffff")
        self.wait_for(lambda: tooltip_surface(b"\x00\xff\xff"))
        cursor(width // 2, 160)
        self.wait_for(lambda: not tooltip_surface(b"\x00\xff\xff"))

        publish(utilityExpanded=False, position="bottom", height=36, accent="#123456", background="#00ff00")
        width, height, _ = screenshot()
        cursor((min(xs) + max(xs)) // 2, height - 18)
        self.wait_for(lambda: tooltip_surface(b"\x00\xff\x00", bottom=True))
        cursor(width // 2, height - 160)

        icons.update(network_enabled=False, clipboard_enabled=True)
        publish(utilityExpanded=False)
        self.wait_for(lambda: indicator_pixels() == 0)
        publish(utilityExpanded=True)
        self.wait_for(lambda: indicator_pixels() > 4)

        for workspace in ("2", "3", "1"):
            subprocess.run(
                ["hyprctl", "dispatch", f'hl.dsp.focus({{ workspace = "{workspace}" }})'],
                env=env, check=True, timeout=2, capture_output=True,
            )
        errors = (root / "shell.log").read_text()
        self.assertNotIn("TypeError", errors)

    @staticmethod
    def stop(process):
        process.terminate()
        try:
            process.wait(timeout=5)
        except subprocess.TimeoutExpired:
            process.kill()
            process.wait(timeout=5)

    def wait_for(self, predicate):
        deadline = time.monotonic() + 15
        last_error = None
        while time.monotonic() < deadline:
            try:
                if predicate():
                    return
            except (subprocess.SubprocessError, json.JSONDecodeError) as error:
                last_error = error
            time.sleep(0.1)
        self.fail(f"Timed out waiting for the nested session. Last command error: {last_error}")
