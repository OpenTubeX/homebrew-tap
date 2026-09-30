cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.35.2-beta"
  sha256 arm:   "7fca47a5507d3b848944117898c27f606f1c54192e9bfca40d65e0ab92fe18b3",
         intel: "b8ec8d6b6f894ce9bdc269951c1d5deacb18cc8b5565dfb86bb6dc461edd8777"

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
