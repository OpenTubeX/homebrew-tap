cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.35.0-beta"
  sha256 arm:   "325bf799f9d1b9c67102fa3473dd87309e13433fdf5718a67dbbe31287d34d4a",
         intel: "c53952853868df7254703d4f6d9ad6c04cd5f9c1120e4e8027fea3135c28a7e3"

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
