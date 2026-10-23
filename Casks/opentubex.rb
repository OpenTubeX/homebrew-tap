cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.37.0-beta"
  sha256 arm:   "7ed47507452f18f8e0b0a3a5d6095837301122311f163308690e026c34d9e5f8",
         intel: "bf766f1ff13a72a3d10932eedb5638f070c66e53aec58074785a6ece0fa9b531"

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
