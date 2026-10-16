cask "claude-switcher" do
  arch arm: "aarch64", intel: "x64"

  version "0.2.1"
  sha256 arm:   "f78ebec73868346f8093e531b7b84a18be4b5bd49b4b114e9831bb281d59bab7",
         intel: "fcf099578a8f1b7fdfe4ac4ce615c47604ade693c23f392965511aaa29d683bc"

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
