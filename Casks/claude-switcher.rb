cask "claude-switcher" do
  arch arm: "aarch64", intel: "x64"

  version "0.1.1"
  sha256 arm:   "d65785b5dd8b62a83879f5687b141564919f8e5de1baffe58115649835074cc8",
         intel: "c903003ff9056264c0215ed6a7b75bffb570c4a149380c91df2db5a405ffeff3"

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
