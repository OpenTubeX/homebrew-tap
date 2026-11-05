cask "opentubex@nightly" do
  arch arm: "arm64", intel: "x64"

  version "0.37.3-nightly-2776"
  sha256 arm:   "8dbcf270454320d044b9618e12b7d19ad181527b122109b21d374f6cd0f05a4c",
         intel: "12c86eb7d8c482378209cbd8b0ae749091de94ef362d318d3ed0024afa81ef4a"

  url "https://github.com/OpenTubeX/OpenTubeX/releases/download/v#{version}/opentubex-#{version}-mac-#{arch}.zip"
  name "OpenTubeX Nightly"
  desc "Private YouTube client"
  homepage "https://opentubex.org/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+-nightly-\d+)$/i)
    strategy :github_releases
  end

  conflicts_with cask: "opentubex"
  depends_on macos: :monterey

  app "OpenTubeX.app"

  caveats <<~EOS
    OpenTubeX Nightly installs untested development builds and may be unstable.
    It uses the same app and settings as the stable OpenTubeX cask.

    OpenTubeX is ad-hoc signed and is not notarized by Apple.
    If macOS blocks the first launch, allow OpenTubeX in System Settings > Privacy & Security.
  EOS
end
