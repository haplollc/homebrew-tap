class Vesalius < Formula
  desc "Map of your codebase for Claude Code: usages, feature maps and outlines over MCP"
  homepage "https://github.com/haplollc/Vesalius"
  url "https://github.com/haplollc/Vesalius/releases/download/v2.1.0/vesalius-2.1.0-macos-arm64.tar.gz"
  sha256 "337872c55c3ba2dcb2a10f1e06ade7abce1b32a98186e5953c2d9f8d654413a9"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  def install
    bin.install "vesalius"
  end

  def caveats
    <<~EOS
      Connect Claude Code and index the repository you are in:
        vesalius setup
      Check the connection any time with `vesalius doctor`; undo with `vesalius setup --undo`.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/vesalius --version").strip
    initialize = <<~JSON.delete("\n")
      {"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-06-18",
      "capabilities":{},"clientInfo":{"name":"brew","version":"1"}}}
    JSON
    assert_match '"name":"vesalius"', pipe_output("#{bin}/vesalius mcp --repo #{testpath}", "#{initialize}\n")
  end
end
