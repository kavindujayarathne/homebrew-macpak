class Macpak < Formula
  desc "Interactive Homebrew helper + leftover zapper for non-brew apps"
  homepage "https://github.com/kavindujayarathne/macpak"
  url ""
  sha256 ""
  license "MIT"
  head "https://github.com/kavindujayarathne/macpak.git", branch: "main"

  depends_on "fzf"

  def install
    libexec.install "lib", "bin/macpak"
    (bin/"macpak").write_env_script libexec/"macpak", {
      MACPAK_VERSION: version.to_s,
      MACPAK_LIBDIR:  "#{libexec}/lib"
    }

    bash_completion.install "completions/macpak"
    zsh_completion.install  "completions/_macpak"
  end

  def caveats
    <<~EOS
      Shell completions for macpak have been installed:

        zsh:  #{HOMEBREW_PREFIX}/share/zsh/site-functions
        bash: #{HOMEBREW_PREFIX}/etc/bash_completion.d

      If your shell already sources completions, these will be picked up automatically.
      For additional setup details, see the official Homebrew shell completion guide:
        https://docs.brew.sh/Shell-Completion
    EOS
  end

  test do
    out = shell_output("#{bin}/macpak --version").strip
    assert_match version.to_s, out
  end
end
