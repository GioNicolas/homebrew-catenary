cask "catenary" do
  arch arm: "arm64", intel: "x64"

  version "1.2.1"
  sha256 arm:   "b55ea93619b543dc7aaf05a19a352120f65bf2ba658e61cc7e79f3cd891b6a7a",
         intel: "be4901bf0896cf067623f404b156ad99925515d3091a3ea67cb00d1a2f66ece2"

  url "https://github.com/GioNicolas/catenary-releases/releases/download/v#{version}/Catenary-#{version}-#{arch}.dmg",
      verified: "github.com/GioNicolas/catenary-releases/"

  name "Catenary"
  desc "The IDE for coding agents"
  homepage "https://thecatenary.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself through electron-updater (the `publish:` block in
  # electron-builder.yml). Declaring that keeps `brew upgrade` from reinstalling
  # a version the app already replaced on its own — Homebrew skips auto-updating
  # casks unless the user asks for --greedy — so the two updaters don't fight
  # over the same /Applications bundle.
  auto_updates true

  # Electron 41's real floor is higher than this; :big_sur is the deliberate
  # under-estimate. Guessing LOW lets someone install on a Mac too old to run
  # the app (they see it fail to launch); guessing HIGH refuses a machine that
  # would have worked. Tighten it to the app's actual LSMinimumSystemVersion:
  #   /usr/libexec/PlistBuddy -c 'Print :LSMinimumSystemVersion' \
  #     /Applications/Catenary.app/Contents/Info.plist
  depends_on macos: :big_sur

  app "Catenary.app"

  # ---------------------------------------------------------------------------
  # DELETE THIS BLOCK THE DAY THE BUILD IS NOTARIZED.
  #
  # The macOS release step only signs when the MAC_CERTS secret is set; without
  # it electron-builder is run with CSC_IDENTITY_AUTO_DISCOVERY=false and the
  # .dmg ships unsigned and un-notarized. Anything Homebrew downloads carries
  # com.apple.quarantine, so Gatekeeper blocks the first launch of the app brew
  # just installed — the install "succeeds" and the app won't open.
  #
  # Being explicit about what this costs: stripping the quarantine flag opts
  # this app out of Gatekeeper's malware check on the user's machine. It is a
  # stopgap for a private tap, not a position. It is also why this cask cannot
  # be submitted to homebrew/homebrew-cask as-is — `brew audit` rejects exactly
  # this. The fix is an Apple Developer ID and notarization, which release.yml
  # is already wired for; then this block goes away and nothing else changes.
  # ---------------------------------------------------------------------------
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Catenary.app"],
                   sudo: false
  end

  uninstall quit: "com.catenary.app"

  # Paths follow from appId com.catenary.app and productName "Catenary" (both in
  # electron-builder.yml) — the latter is what Electron uses for
  # app.getPath('userData'). `zap` only runs on `brew uninstall --zap`; a plain
  # uninstall leaves the user's projects, settings and license activation alone.
  zap trash: [
    "~/Library/Application Support/Catenary",
    "~/Library/Caches/com.catenary.app",
    "~/Library/HTTPStorages/com.catenary.app",
    "~/Library/Logs/Catenary",
    "~/Library/Preferences/com.catenary.app.plist",
    "~/Library/Saved Application State/com.catenary.app.savedState",
  ]
end
