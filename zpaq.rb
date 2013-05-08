require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Zpaq < Formula
  homepage 'https://github.com/zpaq/zpaq/'
  url 'https://github.com/zpaq/zpaq/archive/1ccc81277cb268d394b3174fffe1263294e34f01.tar.gz'
  sha1 'e15df39b4dc5c66c2014e360264dd4714bbc66d4'
  version '6.20'
  head 'https://github.com/zpaq/zpaq.git'
  env :std

  def install
    ENV.j1  # if your formula's build system can't parallelize
    system "make", "-f","Makefile.mac"
    system "pod2man","zpaq.1.pod","zpaq.1"
    bin.install "zpaq"
    lib.install "libzpaq.o"
    include.install "libzpaq.h"
    man1.install "zpaq.1"
  end

  test do
    system "true"
  end
end

