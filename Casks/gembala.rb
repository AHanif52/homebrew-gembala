cask "gembala" do
  version "0.1.3"
  sha256 "e30bc5472a8236c243c0abc5ae7ef2fe40bac7c356aa09f338021cf7d9b3c995"

  url "https://github.com/AHanif52/gembala/releases/download/v#{version}/Gembala-#{version}-arm64.zip"
  name "Gembala"
  desc "Terminal for herding many AI coding agents in one window"
  homepage "https://github.com/AHanif52/gembala"

  depends_on arch: :arm64

  app "Gembala.app"

  # Signed with the self-signed "Gembala Dev" certificate, not notarized: Gatekeeper refuses the downloaded copy
  # while it carries the quarantine flag (Homebrew has no --no-quarantine any more)
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Gembala.app"],
                          writable_paths: ["{{appdir}}/Gembala.app"]
  end

  caveats <<~EOS
    Close Gembala with "Quit and Stop All Agents…" before `brew upgrade gembala`:
    the running daemon lives inside the app bundle.
  EOS

  zap trash: [
    "~/Library/Application Support/Gembala",
    "~/Library/Caches/dev.gembala.app",
  ]
end
