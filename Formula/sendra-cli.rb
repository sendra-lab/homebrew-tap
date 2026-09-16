class SendraCli < Formula
  desc "Terminal-native HTTP client. Sends requests defined in YAML files."
  homepage "https://github.com/sendra-lab/Sendra"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sendra-lab/Sendra/releases/download/0.1.0/sendra-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6f99e26d887a940951d4fcde24071d5240b01a9a1c1035bfed194b65135d1ecc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sendra-lab/Sendra/releases/download/0.1.0/sendra-cli-x86_64-apple-darwin.tar.xz"
      sha256 "75e66f8dc5f9282a0c67143a0475383f30216c08b95d57525258cb5e12469c41"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sendra-lab/Sendra/releases/download/0.1.0/sendra-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "238b9abb6fd1e0e31a2ec5e141dce58d495d8fbc48847b376eb78eee0be05a9e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sendra-lab/Sendra/releases/download/0.1.0/sendra-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f55462bec58984e459f261b780bf437af3d0fde847ef35da823b3d12dc1352c1"
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
