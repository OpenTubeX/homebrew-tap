#!/usr/bin/env python3
"""Update the cask from the latest published OpenTubeX release."""

import json
from pathlib import Path
import re
import subprocess


CASK = Path(__file__).resolve().parents[1] / "Casks/opentubex.rb"


def update(source, release):
    tag = release["tagName"]
    if release["isDraft"] or release["isPrerelease"]:
        raise ValueError("Only published stable releases can update the cask")
    if not re.fullmatch(r"v\d+\.\d+\.\d+(?:-beta)?", tag):
        raise ValueError(f"Unexpected release tag: {tag}")
    version = tag[1:]
    current = re.search(r'^  version "([^"]+)"$', source, re.MULTILINE)
    if current is None:
        raise ValueError("Cask version is missing")

    def version_key(value):
        return (*map(int, value.removesuffix("-beta").split(".")), not value.endswith("-beta"))

    if version_key(version) < version_key(current[1]):
        raise ValueError("Refusing to downgrade the cask")

    updated = source
    for block, arch in (("arm", "arm64"), ("intel", "x64")):
        name = f"opentubex-{version}-mac-{arch}.zip"
        matches = [asset for asset in release["assets"] if asset["name"] == name]
        if len(matches) != 1:
            raise ValueError(f"Expected exactly one release asset: {name}")
        asset = matches[0]
        url = f"https://github.com/OpenTubeX/OpenTubeX/releases/download/{tag}/{name}"
        if asset["url"] != url or asset["state"] != "uploaded":
            raise ValueError(f"Unexpected or incomplete asset: {name}")
        digest = asset.get("digest") or ""
        if not re.fullmatch(r"sha256:[a-f0-9]{64}", digest):
            raise ValueError(f"Missing SHA-256 digest: {name}")
        pattern = r'(  sha256 arm:   )"[a-f0-9]{64}"' if block == "arm" else r'(         intel: )"[a-f0-9]{64}"'
        updated, count = re.subn(pattern, lambda match: f'{match[1]}"{digest[7:]}"', updated)
        if count != 1:
            raise ValueError(f"Expected exactly one {block} checksum")
    return updated.replace(current[0], f'  version "{version}"', 1)


if __name__ == "__main__":
    result = subprocess.run(
        ["gh", "release", "view", "--repo", "OpenTubeX/OpenTubeX",
         "--json", "tagName,isDraft,isPrerelease,assets"],
        check=True, capture_output=True, text=True,
    )
    source = CASK.read_text()
    updated = update(source, json.loads(result.stdout))
    if updated != source:
        CASK.write_text(updated)
        print("Updated OpenTubeX cask")
    else:
        print("OpenTubeX cask is current")
