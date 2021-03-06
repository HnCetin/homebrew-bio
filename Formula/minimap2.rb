class Minimap2 < Formula
  # cite Li_2018: "https://doi.org/10.1093/bioinformatics/bty191"
  desc "Fast pairwise aligner for genomic and spliced nucleotide sequences"
  homepage "https://github.com/lh3/minimap2"
  url "https://github.com/lh3/minimap2/releases/download/v2.16/minimap2-2.16.tar.bz2"
  sha256 "24845e612424f3a601a99adab6707d026d7021044f14aa31cb7998d9ec9fc07b"
  head "https://github.com/lh3/minimap2.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "8a2d6b89ea351215268b494789beb5384932b317c60d66dd20913a2d13c5b754" => :sierra
    sha256 "b739700c5ffcbb89ab497feb1d0f6ba6abbb9965ded664a0b409f9ee60f4bb47" => :x86_64_linux
  end

  depends_on "k8" # for paftools.js
  depends_on "zlib" unless OS.mac?

  def install
    system "make"
    bin.install "minimap2"
    bin.install "misc/paftools.js"
    bin.install_symlink "paftools.js" => "paftools"
    man1.install "minimap2.1"
    pkgshare.install "python", "test", "misc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/minimap2 --version 2>&1")
    assert_match /\d/, shell_output("#{bin}/paftools version 2>&1")
  end
end
