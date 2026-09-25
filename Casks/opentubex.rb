cask "opentubex" do
  arch arm: "arm64", intel: "x64"

  version "0.35.1-beta"
  sha256 arm:   "eef2797dd17adcbe0f8e2ab24bb23fc7f95f01a5f7472205edb57b65330265bd",
         intel: "5bef13d695e675d5c66f9e07ac4c775bb8a40da76dabdead130e8c0196846f9b"

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
