cask "opentubex@nightly" do
  arch arm: "arm64", intel: "x64"

  version "0.38.1-nightly-3261"
  sha256 arm:   "fd6de1e48e9aa001a5f6f4cd8fa819491a77fbef0232543abf5c80efc03d0fd1",
         intel: "a79df55258aa5fbc9f2cff7d337570bb40db64782a2096f0dfed8a9a6f457d02"

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
