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
    mkpath "#{share}/src"
    cp Dir["*"],"#{share}/src"
    system "make", "-f","Makefile.mac"
    system "pod2man","zpaq.1.pod","zpaq.1"
    system "pod2man","libzpaq.3.pod","libzpaq.3"
    bin.install "zpaq"
    bin.install "zpipe"
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
diff --git a/Makefile.mac b/Makefile.mac
index 8b7e749..2dac15a 100644
--- a/Makefile.mac
+++ b/Makefile.mac
@@ -1,13 +1,16 @@
-OBJECTS=zpaq.o libzpaq.o divsufsort.o
+OBJECTS=libzpaq.o divsufsort.o
 
-BINARY=zpaq
+BINARY=zpaq zpipe
 
 CXXFLAGS=-Wall -O1 -DNDEBUG -Dunix -m64 -fopenmp
 CXX=g++
 
 all: $(BINARY)
 
-$(BINARY): $(OBJECTS)
+zpaq: zpaq.o $(OBJECTS)
+	g++ -o $@ $^
+
+zpipe: zpipe.o $(OBJECTS)
 	g++ -o $@ $^
 
 clean:

