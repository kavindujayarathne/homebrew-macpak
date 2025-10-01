class Macpak < Formula
  desc "Interactive Homebrew helper + leftover zapper for non-brew apps"
  homepage "https://github.com/kavindujayarathne/macpak"
  url "https://github.com/kavindujayarathne/macpak/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "d538c95e5d852672f1415438d72765e455bf3b3cbb1b81213dbddefe1b3f82a0"
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
      zsh completions load automatically if your shell runs `compinit`.

      Bash users:
        - If you have the 'bash-completion' package installed and sourced,
          the completion file in #{HOMEBREW_PREFIX}/etc/bash_completion.d/macpak
          will be picked up automatically.
        - Otherwise, source it manually in your ~/.bashrc:
            [[ -r "#{HOMEBREW_PREFIX}/etc/bash_completion.d/macpak" ]] && \
              . "#{HOMEBREW_PREFIX}/etc/bash_completion.d/macpak"

      Optional tools you may want:
        - trash (used when USE_TRASH=1; macOS 14+ has /usr/bin/trash)
        - tmux  (only for the pager split in previews)
    EOS
  end

  test do
    assert_match "macpak", shell_output("#{bin}/macpak -v")
    system "#{bin}/macpak", "--help"
  end
end
