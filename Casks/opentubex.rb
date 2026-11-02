cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.37.3-beta"
  sha256 arm:   "f49f0b9144fc290e8793fc1304cd33f040adaf1fac1b2bbc2c61a4d84d48186f",
         intel: "a2c9bf0e5d1c0e4e7c2a874d48ddd3bb7c7fa1d0d60cac669a592b30a77d5a7d"

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
