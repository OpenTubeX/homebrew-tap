cask "opentubex@nightly" do
  arch arm: "arm64", intel: "x64"

  version "0.37.3-nightly-2825"
  sha256 arm:   "e0e425c8fe79f66c951dfb949d2c308e6032a993a2d27e092feb2d8e0aaaef77",
         intel: "17a5412dab20a1c4b8195e71751e0fb56115a799b5b28fbfeb7a92cddf560403"

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
  depends_on macos: :monterey

  app "OpenTubeX.app"

  caveats <<~EOS
    OpenTubeX Nightly installs untested development builds and may be unstable.
    It uses the same app and settings as the stable OpenTubeX cask.

    OpenTubeX is ad-hoc signed and is not notarized by Apple.
    If macOS blocks the first launch, allow OpenTubeX in System Settings > Privacy & Security.
  EOS
end
