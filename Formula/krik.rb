class Krik < Formula
  desc "Fast static site generator built with Rust"
  homepage "https://github.com/mcaserta/krik"
  version "0.1.27"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mcaserta/krik/releases/download/v#{version}/kk-macos-aarch64"
      sha256 "fa113cecc62d39f33140b0a6cccbcbb20e323b1c3a9b356bae7b6d57fd877ab1"
    else
      url "https://github.com/mcaserta/krik/releases/download/v#{version}/kk-macos-x86_64"
      sha256 "3e831276ca793f5a782ae428b1a18ac4359468446ef3c996f94fa4a4a403ebfd"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/mcaserta/krik/releases/download/v#{version}/kk-linux-x86_64"
      sha256 "0fe7af8e94163adccb7b49a746fc374175ee509c9931c14c229d62215bedfa69"
    end
  end

  def install
    # The downloaded file will be in the build directory
    # Rename it to just "krik" and install
    bin.install Dir["*"].first => "kk"
    
    # Make sure it's executable (should already be, but just in case)
    chmod 0755, bin/"kk"
  end

  test do
    system "#{bin}/kk", "--version"

    # More comprehensive test if possible:
    # system "#{bin}/krik", "--help"
    # You could test basic functionality like:
    # system "#{bin}/krik", "init", "test-site"
    # assert_predicate testpath/"test-site", :exist?
  end
end
