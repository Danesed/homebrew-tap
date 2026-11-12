# The cask for the Danesed/homebrew-tap repository. Scripts/cask.sh fills in the
# version and checksum of a release and writes the result into a tap checkout.
cask "mustats" do
  version "0.2.1"
  sha256 "8e09769e3934eea7fc17fc8fb3b918bd3a768daf9f8075635f44d5a0a637b0a5"

  url "https://github.com/Danesed/muStats/releases/download/v#{version}/muStats.dmg"
  name "μStats"
  desc "Lightweight system monitor for the menu bar"
  homepage "https://github.com/Danesed/muStats"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "muStats.app"
  binary "#{appdir}/muStats.app/Contents/MacOS/muStats", target: "mustats"

  # Signed ad hoc, not notarized: without this Gatekeeper blocks the first launch.
  # Drop it once releases carry a Developer ID signature.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/muStats.app"]
  end

  uninstall quit: "com.danesed.muStats"

  zap trash: [
    "~/Library/Application Support/muStats",
    "~/Library/Caches/com.danesed.muStats",
    "~/Library/Containers/com.danesed.muStats.widgets",
    "~/Library/HTTPStorages/com.danesed.muStats",
    "~/Library/HTTPStorages/com.danesed.muStats.binarycookies",
    "~/Library/Preferences/com.danesed.muStats.plist",
  ]
end
