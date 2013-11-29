require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Reaver < Formula
  homepage 'https://code.google.com/p/reaver-wps'
  url 'https://reaver-wps.googlecode.com/files/reaver-1.4.tar.gz'
  sha1 '2ebec75c3979daa7b576bc54adedc60eb0e27a21'

  def install
    # ENV.j1  # if your formula's build system can't parallelize

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    system "true"
  end
end
