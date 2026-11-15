cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.38.1-beta"
  sha256 arm:   "dcb9fb21d756992f797cccb5b615d73f0291e0d2a94664810455c91d16b609c7",
         intel: "4e99704b36f6cd4a8e3ed3ee3656cab7ca8a2c6ad0b878cd950b8db8e5f685bb"

  url "https://github.com/OpenTubeX/OpenTubeX/releases/download/v#{version}/opentubex-#{version}-mac-#{arch}.zip"
  name "OpenTubeX"
  desc "Private YouTube client"
  homepage "https://opentubex.org/"

  conflicts_with cask: "opentubex@nightly"
  depends_on macos: :ventura

  app "OpenTubeX.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/io.opentubex.opentubex.sfl*",
    "~/Library/Application Support/OpenTubeX",
    "~/Library/Preferences/io.opentubex.opentubex.plist",
    "~/Library/Saved Application State/io.opentubex.opentubex.savedState",
  ]

  caveats <<~EOS
    OpenTubeX is ad-hoc signed and is not notarized by Apple.
    If macOS blocks the first launch, allow OpenTubeX in System Settings > Privacy & Security.
  EOS
end
