cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.37.2-beta"
  sha256 arm:   "ec3c80eedaddbe788a32446141342e62e32c1665b4eb3cd62b9b43807ceeb915",
         intel: "d144359034dfdee3dc51196199e5cd1c2ce7dcf96f2e3ed77304e5b05ee397ad"

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
