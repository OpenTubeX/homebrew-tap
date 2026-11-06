cask "opentubex@nightly" do
  arch arm: "arm64", intel: "x64"

  version "0.37.4-beta"
  sha256 arm:   "37ad7b44d579790fc940eae3e11c0efa84773e5ce9057b7a7f1526e4b20ca0f7",
         intel: "5f76ae75c901481ce965d93bf12097702a269b05d669f115dac6f137d9181e54"

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
