cask "claude-switcher" do
  arch arm: "aarch64", intel: "x64"

  version "0.3.0"
  sha256 arm:   "8e68959d26e45879fc17d1ff2b09344b7f1f1a1a733143e269f30358859a7fe0",
         intel: "9be63b36b1ed7de16033c0af53bbed67a84fb2dc063f39c55b277ec35e0f1244"

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
