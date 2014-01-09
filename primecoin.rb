require 'formula'

class Primecoin < Formula
  homepage 'http://primecoin.org/'
  url 'https://github.com/primecoin/primecoin/archive/v0.8.6.tar.gz'
  head 'https://github.com/primecoin/primecoin.git'
  version '0.8.6'
  sha1 '220cc2e3694d8378ad9af3721b1e2c8d282bad84'

  depends_on :x11 => :recommended
  depends_on 'boost'
  depends_on 'berkeley-db4'
  depends_on 'openssl'
  depends_on 'miniupnpc'
  depends_on 'qrencode' => :recommended
  depends_on 'qt' => :recommended

  def install
    # ENV.j1  # if your formula's build system can't parallelize

    # Remove unrecognized options if warned by configure
    system "qmake"
    system "make"
    prefix.install "Primecoin-Qt.app"
    Dir.chdir "src"
    system "make","-f","makefile.osx"
    bin.install "primecoind"
  end

  def caveats; <<-EOS.undent
    Primecoin-Qt.app installed to:
      #{prefix}

    To link the application to a normal Mac OS X location:
        brew linkapps
    or:
        ln -s #{prefix}/Primecoin-qt.app /Applications

    If you appreciate this homebrew formula, XPM tips are gladly accepted at 
    EOS
  end

  def patches
    DATA
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test Extremecoin`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "--version"`.
    system "false"
  end
end

__END__
diff --git a/share/qt/Info.plist b/share/qt/Info.plist
index 2312094..8b5e0bf 100644
--- a/share/qt/Info.plist
+++ b/share/qt/Info.plist
@@ -15,19 +15,19 @@
 	<key>CFBundleSignature</key>
 	<string>????</string>
 	<key>CFBundleExecutable</key>
-	<string>Bitcoin-Qt</string>
+	<string>Primecoin-Qt</string>
 	<key>CFBundleIdentifier</key>
-	<string>org.bitcoinfoundation.Bitcoin-Qt</string>
+	<string>org.primecoin.Primecoin-Qt</string>
         <key>CFBundleURLTypes</key>
         <array>
           <dict>
             <key>CFBundleTypeRole</key>
             <string>Editor</string>
             <key>CFBundleURLName</key>
-            <string>org.bitcoinfoundation.BitcoinPayment</string>
+            <string>org.primecoin.PrimecoinPayment</string>
             <key>CFBundleURLSchemes</key>
             <array>
-              <string>bitcoin</string>
+              <string>primecoin</string>
             </array>
           </dict>
         </array>
diff --git a/bitcoin-qt.pro b/bitcoin-qt.pro
index 69c2478..99ddf4b 100644
--- a/bitcoin-qt.pro
+++ b/bitcoin-qt.pro
@@ -1,6 +1,6 @@
 TEMPLATE = app
 TARGET = bitcoin-qt
-macx:TARGET = "Bitcoin-Qt"
+macx:TARGET = "Primecoin-Qt"
 VERSION = 0.8.6
 INCLUDEPATH += src src/json src/qt
 QT += network
diff --git a/src/makefile.osx b/src/makefile.osx
index 50279fd..b2ec8e0 100644
--- a/src/makefile.osx
+++ b/src/makefile.osx
@@ -120,7 +120,7 @@ ifneq (${USE_IPV6}, -)
 	DEFS += -DUSE_IPV6=$(USE_IPV6)
 endif
 
-all: bitcoind
+all: primecoind
 
 test check: test_bitcoin FORCE
 	./test_bitcoin
@@ -150,7 +150,7 @@ obj/%.o: %.cpp
 	      -e '/^$$/ d' -e 's/$$/ :/' < $(@:%.o=%.d) >> $(@:%.o=%.P); \
 	  rm -f $(@:%.o=%.d)
 
-bitcoind: $(OBJS:obj/%=obj/%)
+primecoind: $(OBJS:obj/%=obj/%)
 	$(CXX) $(CFLAGS) -o $@ $(LIBPATHS) $^ $(LIBS)
 
 TESTOBJS := $(patsubst test/%.cpp,obj-test/%.o,$(wildcard test/*.cpp))

