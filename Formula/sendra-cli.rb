class SendraCli < Formula
  desc "Terminal-native HTTP client. Sends requests defined in YAML files."
  homepage "https://github.com/sendra-lab/Sendra"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sendra-lab/Sendra/releases/download/0.1.0/sendra-cli-aarch64-apple-darwin.tar.xz"
      sha256 "cb872ef758235cb9679525d0b86bc7fb3275652e7bbb77af9ea11f2234524ce9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sendra-lab/Sendra/releases/download/0.1.0/sendra-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8ad5227686b606db52b605a0abc8780deae1688160cba06a82c13989a737f04b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sendra-lab/Sendra/releases/download/0.1.0/sendra-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dde04ce28fe21ddf3fa5d9cefff42e88e5486e08551e6926ead0f7530c8de2c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sendra-lab/Sendra/releases/download/0.1.0/sendra-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9b2e0e9296d525ca31687823998a94c2b9c3072c6b15e928d22b24686920e8d8"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sendra"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sendra"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sendra"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sendra"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
