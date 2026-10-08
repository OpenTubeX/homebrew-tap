cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.36.0-beta"
  sha256 arm:   "1277c4cceb86fee350058138629c47dd363dcaa353ffdc28090576470ffea081",
         intel: "bca6527fc9b2c34da6f314eaccd19f6c76abfa700072f0a08af7d500bad7d0b2"

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
