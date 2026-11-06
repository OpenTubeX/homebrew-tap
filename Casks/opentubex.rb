cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.37.4-beta"
  sha256 arm:   "37ad7b44d579790fc940eae3e11c0efa84773e5ce9057b7a7f1526e4b20ca0f7",
         intel: "5f76ae75c901481ce965d93bf12097702a269b05d669f115dac6f137d9181e54"

  url "https://github.com/OpenTubeX/OpenTubeX/releases/download/v#{version}/opentubex-#{version}-mac-#{arch}.zip"
  name "OpenTubeX"
  desc "Private YouTube client"
  homepage "https://opentubex.org/"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "opentubex@nightly"
  depends_on macos: :ventura

  app "OpenTubeX.app"

  caveats <<~EOS
    OpenTubeX is ad-hoc signed and is not notarized by Apple.
    If macOS blocks the first launch, allow OpenTubeX in System Settings > Privacy & Security.
  EOS
end
