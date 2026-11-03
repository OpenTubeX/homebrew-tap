#!/usr/bin/env python3
"""Update the casks from a published OpenTubeX release.

Usage: update.py [TAG]

Without a tag, the latest stable release is used. Stable releases update both
casks; nightly releases update only the nightly cask.
"""

import json
from pathlib import Path
import re
import subprocess
import sys


CASKS = Path(__file__).resolve().parents[1] / "Casks"
STABLE = CASKS / "opentubex.rb"
NIGHTLY = CASKS / "opentubex@nightly.rb"
TAG = re.compile(r"v(\d+)\.(\d+)\.(\d+)(-beta|-nightly-(\d+))?")


def version_key(version):
    match = TAG.fullmatch(f"v{version}")
    if match is None:
        raise ValueError(f"Unexpected version: {version}")
    major, minor, patch, suffix, nightly = match.groups()
    # Betas precede the final release. Nightlies follow the release they are numbered after.
    rank = (2, int(nightly)) if nightly else (0, 0) if suffix else (1, 0)
    return (int(major), int(minor), int(patch), *rank)


def update(source, release, nightly=False):
    tag = release["tagName"]
    match = TAG.fullmatch(tag)
    if release["isDraft"] or match is None:
        raise ValueError(f"Unexpected release tag: {tag}")
    is_nightly = match[5] is not None
    if release["isPrerelease"] != is_nightly:
        raise ValueError(f"Release type does not match tag: {tag}")
    if is_nightly and not nightly:
        raise ValueError("Only published stable releases can update the stable cask")
    version = tag[1:]
    current = re.search(r'^  version "([^"]+)"$', source, re.MULTILINE)
    if current is None:
        raise ValueError("Cask version is missing")

    if version_key(version) < version_key(current[1]):
        if nightly:
            # The nightly cask already follows a newer build.
            return source
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
        ["gh", "release", "view", *sys.argv[1:2], "--repo", "OpenTubeX/OpenTubeX",
         "--json", "tagName,isDraft,isPrerelease,assets"],
        check=True, capture_output=True, text=True,
    )
    release = json.loads(result.stdout)
    casks = [(NIGHTLY, True)] if release["isPrerelease"] else [(STABLE, False), (NIGHTLY, True)]
    for path, nightly in casks:
        source = path.read_text()
        updated = update(source, release, nightly)
        if updated != source:
            path.write_text(updated)
            print(f"Updated {path.name}")
        else:
            print(f"{path.name} is current")
