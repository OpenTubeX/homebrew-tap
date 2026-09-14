# OpenTubeX Homebrew tap

This repository distributes [OpenTubeX](https://github.com/OpenTubeX/OpenTubeX)
through [Homebrew](https://brew.sh/) on macOS 12 and later. It supports Apple
Silicon and Intel Macs and installs the app into Applications.

## Install OpenTubeX

With Homebrew installed, run:

```sh
brew install --cask opentubex/tap/opentubex
```

Homebrew adds the tap and selects the package for your Mac automatically.
Open OpenTubeX from Applications after installation.

OpenTubeX is ad-hoc signed and is not notarized by Apple. If macOS blocks the
first launch, allow OpenTubeX in **System Settings → Privacy & Security**.

## Update OpenTubeX

```sh
brew update
brew upgrade --cask opentubex
```

The tap tracks stable OpenTubeX releases, whose version tags currently end in
`-beta`. Nightly builds are not included.

## Uninstall OpenTubeX

```sh
brew uninstall --cask opentubex
brew untap opentubex/tap
```

Uninstalling leaves your OpenTubeX settings and user data intact.

## How publishing works

After an OpenTubeX release finishes uploading its assets and is published,
the application repository triggers the **Update stable release** workflow.
The tap also checks for updates every six hours. The workflow:

1. reads the latest published stable release and validates its macOS ZIP
   assets and SHA-256 digests;
2. updates the version and architecture-specific checksums in
   `Casks/opentubex.rb`;
3. checks Homebrew style, installs the candidate cask, and verifies app
   integrity and the Electron runtime on Apple Silicon and Intel runners;
4. publishes the tested cask with a GitHub-signed commit if it changed.

The workflow reuses the official release packages without rebuilding the app.
It can also be run manually to pick up the latest stable release:

```sh
gh workflow run update.yml --repo OpenTubeX/homebrew-tap --ref main
```

## Maintainer setup

Enable GitHub Actions for this repository. The update workflow uses its
built-in `GITHUB_TOKEN` with `contents: write` permission to publish cask
changes; no additional secret is needed in the tap repository.

The OpenTubeX application repository uses its existing `PUSH_TOKEN` secret
to trigger the cross-repository workflow. That token needs Actions write
access to `OpenTubeX/homebrew-tap`.

The **Test cask** workflow checks changes on Apple Silicon and Intel Macs,
including installation and removal. Run the updater tests locally with:

```sh
python3 -m unittest discover -s tests
```
