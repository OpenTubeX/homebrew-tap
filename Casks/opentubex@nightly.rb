cask "opentubex@nightly" do
  arch arm: "arm64", intel: "x64"

  version "0.37.4-nightly-2901"
  sha256 arm:   "b1e0ee414ea0084623d50d01528d48e81857aa02f4145ddfbcf65b14abbf942c",
         intel: "7d02e966b57ca9ff0debe1f106309d95130b04e632459221e24e408f7719904f"

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
