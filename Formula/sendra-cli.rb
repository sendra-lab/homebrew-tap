class SendraCli < Formula
  desc "Terminal-native HTTP client. Sends requests defined in YAML files."
  homepage "https://github.com/sendra-lab/Sendra"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sendra-lab/Sendra/releases/download/v0.1.0/sendra-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b33e59841f58908f573972d68d2f42d31520fa5931163e11048c7d41b6ad3596"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sendra-lab/Sendra/releases/download/v0.1.0/sendra-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a8fe2f78ae999b1a7f3ed6e87781971c369259c9f57a16b5d97b3386a3423b47"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sendra-lab/Sendra/releases/download/v0.1.0/sendra-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "22e6836530310da63e8f69ec9c57bb05448696339eaf6bf07c8ee5acd1dd809c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sendra-lab/Sendra/releases/download/v0.1.0/sendra-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "06d1c52d17e6608b82d5a49a73fdb9d8656baa45557caf02d1b2818ecd72e593"
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
