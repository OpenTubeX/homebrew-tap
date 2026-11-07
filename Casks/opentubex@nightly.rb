cask "opentubex@nightly" do
  arch arm: "arm64", intel: "x64"

  version "0.37.4-nightly-2856"
  sha256 arm:   "3a0475c5a6768ed79e8fce0c74aa0abd0b0aa8ee71820929d47f2edadabc1a19",
         intel: "62b754f98d342d4a6c5e08367719776d206b226a6ff5b022e0bc423b5892ec80"

  url "https://github.com/OpenTubeX/OpenTubeX/releases/download/v#{version}/opentubex-#{version}-mac-#{arch}.zip"
  name "OpenTubeX Nightly"
  desc "Private YouTube client"
  homepage "https://opentubex.org/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+-nightly-\d+)$/i)
    strategy :github_releases
  end

  conflicts_with cask: "opentubex"
  depends_on macos: :ventura

  app "OpenTubeX.app"

  caveats <<~EOS
    OpenTubeX Nightly installs untested development builds and may be unstable.
    It uses the same app and settings as the stable OpenTubeX cask.

    OpenTubeX is ad-hoc signed and is not notarized by Apple.
    If macOS blocks the first launch, allow OpenTubeX in System Settings > Privacy & Security.
  EOS
end
