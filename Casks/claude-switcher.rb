cask "claude-switcher" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "00066530f5de361ca9068350332df74b6731d03209065c22dc2aaa53f9d3c42f",
         intel: "14db32e7b126f1f5d51c5418d43b8510e768900c8d4327652cd291362fb92c81"

  url "https://github.com/efideas/claude-switcher/releases/download/v#{version}/Claude.Switcher_#{version}_#{arch}.dmg"
  name "Claude Switcher"
  desc "Launcher that opens several Claude Desktop instances, one per account"
  homepage "https://github.com/efideas/claude-switcher"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Claude Switcher.app"

  # The app is not signed or notarized. Clear the quarantine flag so Gatekeeper
  # does not block the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Claude Switcher.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.efideas.claude-switcher",
    "~/Library/Caches/com.efideas.claude-switcher",
    "~/Library/Preferences/com.efideas.claude-switcher.plist",
    "~/Library/Saved Application State/com.efideas.claude-switcher.savedState",
    "~/Library/WebKit/com.efideas.claude-switcher",
  ]

  caveats <<~EOS
    Claude Switcher is not notarized by Apple. If macOS still refuses to open it,
    right-click the app in /Applications and choose Open, or run:
      xattr -dr com.apple.quarantine "#{appdir}/Claude Switcher.app"
  EOS
end
