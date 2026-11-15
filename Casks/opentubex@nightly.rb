cask "opentubex@nightly" do
  arch arm: "arm64", intel: "x64"

  version "0.38.0-nightly-3199"
  sha256 arm:   "57233c77d2ce913f5e0bfe9928fcd14488621755d439d2e1168dfaf84dea4266",
         intel: "266a2675e806311a2a5b88cd91ed163d633efc985ad8064837db649a66fe2d79"

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
