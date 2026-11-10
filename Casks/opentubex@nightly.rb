cask "opentubex@nightly" do
  arch arm: "arm64", intel: "x64"

  version "0.37.4-nightly-2969"
  sha256 arm:   "12abbd311bf9c0ff440a95cbf1d207dee5abb779a928430ac7ea1b8f57f08b9a",
         intel: "0fd8c0801b1308cb14aabaa2f5048904db469a2a90d719946495b2c5c94be173"

  url "https://github.com/OpenTubeX/OpenTubeX/releases/download/v#{version}/opentubex-#{version}-mac-#{arch}.zip"
  name "OpenTubeX Nightly"
  desc "Private YouTube client"
  homepage "https://opentubex.org/"

  conflicts_with cask: "opentubex"
  depends_on macos: :ventura

  app "OpenTubeX.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/io.opentubex.opentubex.sfl*",
    "~/Library/Application Support/OpenTubeX",
    "~/Library/Preferences/io.opentubex.opentubex.plist",
    "~/Library/Saved Application State/io.opentubex.opentubex.savedState",
  ]

  caveats <<~EOS
    OpenTubeX Nightly installs untested development builds and may be unstable.
    It uses the same app and settings as the stable OpenTubeX cask.

    OpenTubeX is ad-hoc signed and is not notarized by Apple.
    If macOS blocks the first launch, allow OpenTubeX in System Settings > Privacy & Security.
  EOS
end
