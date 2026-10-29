cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.37.1-beta"
  sha256 arm:   "499c05e760ee871b25f4b289a27226a1a4f23b18e5229049b961d8bf83134d4b",
         intel: "e959ee9ccf57868acf682fa3fc0a86ee85da377e7777ae21fcff229ade464fde"

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
