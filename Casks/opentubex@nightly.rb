cask "opentubex@nightly" do
  arch arm: "arm64", intel: "x64"

  version "0.37.3-nightly-2725"
  sha256 arm:   "167d9f41c9b4dd57abece776b175938ef0ffcd4a095c9e98f437402870742b1c",
         intel: "d6edb9dac2d5198b0126424a3d754b19e65b4a74a1cd3512eaf79bbc3c9296e5"

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
