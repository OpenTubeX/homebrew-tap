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

The `opentubex` cask tracks stable OpenTubeX releases, whose version tags
currently end in `-beta`.

## Nightly builds

The `opentubex@nightly` cask installs the daily development builds:

```sh
brew install --cask opentubex/tap/opentubex@nightly
```

Nightly builds are meant for testing and may be unstable. The cask also
receives each stable release and then the nightlies that follow it.

Both casks install `OpenTubeX.app` and share its settings and user data, so
only one can be installed at a time. To switch, uninstall one cask and install
the other.

## Uninstall OpenTubeX

```sh
brew uninstall --cask opentubex  # or opentubex@nightly
brew untap opentubex/tap
```

Uninstalling leaves your OpenTubeX settings and user data intact.

## How publishing works

After an OpenTubeX stable or nightly release finishes uploading its assets,
the application repository sends an `opentubex-release` or
`opentubex-nightly` repository dispatch containing the release tag. The
**Update casks** workflow then:

1. reads that release and validates its macOS ZIP assets and SHA-256 digests;
2. updates the version and architecture-specific checksums in
   `Casks/opentubex.rb` for stable releases and in `Casks/opentubex@nightly.rb`
   for both stable and nightly releases. The nightly cask keeps its version
   when the release is older than the build it already offers;
3. checks Homebrew style, installs each changed candidate cask, and verifies
   app integrity and the Electron runtime on Apple Silicon and Intel runners;
4. publishes the tested casks with GitHub-signed commits.

The workflow reuses the official release packages without rebuilding the app.
It can also be run manually. Without a tag, it picks up the latest stable
release:

```sh
gh workflow run update.yml --repo OpenTubeX/homebrew-tap --ref main
gh workflow run update.yml --repo OpenTubeX/homebrew-tap --ref main \
  -f releaseTag=v0.37.3-nightly-2677
```

## Maintainer setup

Enable GitHub Actions for this repository. The update workflow uses its
built-in `GITHUB_TOKEN` with `contents: write` permission to publish cask
changes; no additional secret is needed in the tap repository.

The OpenTubeX application repository uses its existing `PUSH_TOKEN` secret
to send the repository dispatches. That token needs Contents write access to
`OpenTubeX/homebrew-tap`.

The **Test cask** workflow checks both casks on Apple Silicon and Intel Macs,
including installation and removal. Run the updater tests locally with:

```sh
python3 -m unittest discover -s tests
```
