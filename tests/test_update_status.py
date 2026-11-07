"""Exercise the Waybar update module with fake package commands."""
import json
import os
import re
from pathlib import Path
import subprocess
import shutil
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parents[1] / "src/usr/share/argvus/taskbar/sh/waybar-update-status.sh"


class UpdateStatusTests(unittest.TestCase):
    def run_check(self, official, official_status=0, aur=None, aur_status=0, enabled=True):
        Path('/tmp/argvus').mkdir(exist_ok=True)
        with tempfile.TemporaryDirectory(dir='/tmp/argvus') as directory:
            root = Path(directory)
            for name in ("mkdir", "mktemp", "rm", "timeout", "awk", "jq"):
                (root / name).symlink_to(shutil.which(name))
            def command(name, body):
                path = root / name
                path.write_text('#!/bin/sh\n' + body + '\n')
                path.chmod(0o755)
            command('argvus', 'if [ "$1" = config ]; then printf "%s" "$CHECK_AUR"; else printf "%s" "$4"; fi')
            command('checkupdates', 'printf "%s" "$OFFICIAL"; exit "$OFFICIAL_STATUS"')
            if aur is not None:
                command('paru', 'printf "%s" "$AUR"; exit "$AUR_STATUS"')
            env = dict(os.environ, PATH=str(root), CHECK_AUR=str(enabled).lower(),
                       OFFICIAL=official, OFFICIAL_STATUS=str(official_status), AUR=aur or '', AUR_STATUS=str(aur_status))
            result = subprocess.run(['/bin/sh', str(SCRIPT)], env=env, capture_output=True, text=True, check=True)
            return json.loads(result.stdout)

    def test_update_group_shares_focus_frame_and_background(self):
        css = (SCRIPT.parents[1] / 'config/argvus-taskbar.css').read_text()
        blocks = re.findall(r'([^{}]+)\{([^{}]*)\}', css)
        shared = [(selectors, declarations) for selectors, declarations in blocks
                  if '#focus' in selectors and '#update-status' in selectors]
        self.assertTrue(any('border: 1px solid @th-border-rights' in declarations
                            and 'margin-left: 5px' in declarations for _, declarations in shared))
        self.assertTrue(any('background: @th-right02-bg' in declarations
                            for _, declarations in shared))

    def test_counts_distinct_sources(self):
        result = self.run_check('one 1 -> 2\ntwo 1 -> 2\n', aur='two 1 -> 2\nthree 1 -> 2\n')
        self.assertEqual(result['text'], '3')
        self.assertIn('AUR: 2', result['tooltip'])

    def test_no_updates(self):
        result = self.run_check('', official_status=2, aur='', aur_status=1)
        self.assertEqual(result['text'], '0')
        self.assertEqual(result['class'], 'current')

    def test_failure_is_not_zero(self):
        result = self.run_check('', official_status=1, enabled=False)
        self.assertEqual(result['text'], '0?')
        self.assertEqual(result['class'], 'error')

    def test_missing_helper_keeps_official_count(self):
        # No helper is installed in the isolated PATH used in CI.
        result = self.run_check('one 1 -> 2\n')
        self.assertEqual(result['text'], '1?')
        self.assertEqual(result['class'], 'error')


if __name__ == '__main__':
    unittest.main()
