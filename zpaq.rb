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

  def patches
    DATA
  end
  def install
    ENV.j1  # if your formula's build system can't parallelize
    mkpath "#{prefix}/share/src"
    cp Dir["*"],"#{prefix}/share/src"
    system "make", "-f","Makefile.mac"
    system "pod2man","zpaq.1.pod","zpaq.1"
    system "pod2man","libzpaq.3.pod","libzpaq.3"
    bin.install "zpaq"
    bin.install "zpaqmake"
    lib.install "libzpaq.o"
    include.install "libzpaq.h"
    man1.install "zpaq.1"
    man3.install "libzpaq.3"
  end

  test do
    system "true"
  end
end

__END__
diff --git a/zpaqmake b/zpaqmake
index e69de29..864b50d 100755
--- a/zpaqmake
+++ b/zpaqmake
@@ -0,0 +1,9 @@
+#!/bin/bash
+# This script is called by ZPAQ to compile optimized versions. It is
+# expected to compile %1.cpp to %1.exe with -DOPT -DNDEBUG,
+# #include <zpaq.h> and link it to zpaq.cpp or zpaq.o. These files can
+# be anywhere, but this script is expected to find them.
+# The following assumes zpaq.cpp and zpaq.h are in the homebrew share/src
+# and temporary files go in %TEMP%. Adjust accordingly.
+g++ -Wall -O1 -DNDEBUG -Dunix -m64 -fopenmp -DOPT $1.cpp -IHOMEBREW_PREFIX/include HOMEBREW_PREFIX/Cellar/zpaq/6.20/share/src/zpaq.cpp -o $1
+

