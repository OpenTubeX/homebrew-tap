cask "opentubex@nightly" do
  arch arm: "arm64", intel: "x64"

  version "0.37.3-nightly-2677"
  sha256 arm:   "3123a38295db232c48b249e69cf834a11e99f356cda2e873a2364fcaf692f9f9",
         intel: "9016dfbd0cb4546595f846c56edb7c522b64251050ae3a000702343fe3590913"

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
