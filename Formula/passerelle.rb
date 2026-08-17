class Passerelle < Formula
  desc "Self-hosted HTTP tunnel"
  homepage "https://github.com/gauthier/passerelle"
  url "https://github.com/gauthier/passerelle/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "f081b5f7f892c8bb2a9fa9131fa0467cc294e7e13a8f3480ca19504ca3296eee"
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
