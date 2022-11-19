#!/usr/bin/env python3
import os
import subprocess

zenity_bin = subprocess.run(["which", "zenity"], capture_output=True, text=True)

if len(zenity_bin.stdout) < 1:
    print("Zenity was not found in PATH. Is it installed?")
    exit(1)

whoami = os.environ["USER"]
subprocess.run(
    [
        zenity_bin.stdout.strip(),
        "--question",
        f"--text=Greetings {whoami.capitalize()}!\n🐍🐍🐍\nHas it been a good Delve so far?",
    ]
)
