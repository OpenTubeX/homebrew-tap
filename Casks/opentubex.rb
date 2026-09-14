cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.34.1-beta"
  sha256 arm:   "a3a3f7ab91758f612f3beee71b9eef00544a0bc09a0b6b4ec76b0ca77d83a3ad",
         intel: "8d5cf2bed2f4c2250b7da71c0f89d3d8bb4b2994ef81e45a29c6bf89a225b773"

  url "https://github.com/OpenTubeX/OpenTubeX/releases/download/v#{version}/opentubex-#{version}-mac-#{arch}.zip"
  name "OpenTubeX"
  desc "Private YouTube client"
  homepage "https://opentubex.org/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "OpenTubeX.app"

  caveats <<~EOS
    OpenTubeX is ad-hoc signed and is not notarized by Apple.
    If macOS blocks the first launch, allow OpenTubeX in System Settings > Privacy & Security.
  EOS
end
