cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.36.1-beta"
  sha256 arm:   "c9db0f95a83f9a58cbe8c3250cb24f6d4f0a26732d2013d3cfe17c31d4867cec",
         intel: "d548a29c7eda27ea48742390d6a763f79309cd5a64b015b09ca9341e23329cb4"

  url "https://github.com/OpenTubeX/OpenTubeX/releases/download/v#{version}/opentubex-#{version}-mac-#{arch}.zip"
  name "OpenTubeX"
  desc "Private YouTube client"
  homepage "https://opentubex.org/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "OpenTubeX.app"

  caveats <<~EOS
    OpenTubeX is ad-hoc signed and is not notarized by Apple.
    If macOS blocks the first launch, allow OpenTubeX in System Settings > Privacy & Security.
  EOS
end
