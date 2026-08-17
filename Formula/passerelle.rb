class Passerelle < Formula
  desc "Self-hosted HTTP tunnel"
  homepage "https://github.com/gauthier/passerelle"
  url "https://github.com/gauthier/passerelle/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "373d11d50285279d5115ba937b2a46fd083da4b398b48692d3c105743946f2eb"
  license "Apache-2.0"
  head "https://github.com/gauthier/passerelle.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/gauthier/passerelle/internal/version.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/passerelle"
  end

  service do
    run [opt_bin/"passerelle", "daemon"]
    keep_alive true
    log_path var/"log/passerelle.log"
    error_log_path var/"log/passerelle.log"
  end

  test do
    assert_match "auth", shell_output("#{bin}/passerelle --help")
  end
end
