require 'formula'
class MPQExtractor < Formula
  homepage 'https://github.com/Kanma/MPQExtractor'
  url 'https://github.com/Kanma/MPQExtractor/archive/6cb515122170ce02bf505f11edc403c1de091483.tar.gz'
  sha1 'ccba935f0648ff328db1cf44ebce162767891d0e'
  head 'https://github.com/Kanma/MPQExtractor.git', :revision => '6cb515122170ce02bf505f11edc403c1de091483'

  depends_on 'cmake' => :build

  def install
    ENV.j1  # if your formula's build system can't parallelize

    system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    system "false"
  end
end
