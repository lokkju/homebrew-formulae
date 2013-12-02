require 'formula'

class Securecoin < Formula
  homepage ''
  url 'https://github.com/lokkju/Securecoin.git', :revision => '77c8d6c1990f5098cd426fd4a2a9238572d76346'
  head 'https://github.com/lokkju/Securecoin.git'
  version '0.8.3-beta1'
  sha1 ''

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
    prefix.install "Securecoin-Qt.app"
    Dir.chdir "src"
    system "make","-f","makefile.osx"
    bin.install "securecoind"
  end

  def caveats; <<-EOS.undent
    Securecoin-Qt.app installed to:
      #{prefix}

    To link the application to a normal Mac OS X location:
        brew linkapps
    or:
        ln -s #{prefix}/Securecoin-qt.app /Applications
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
diff --git a/securecoin-qt.pro b/securecoin-qt.pro
index 88d03e6..cdb7e95 100755
--- a/securecoin-qt.pro
+++ b/securecoin-qt.pro
@@ -103,14 +103,14 @@ INCLUDEPATH += src/leveldb/include src/leveldb/helpers
 LIBS += $$PWD/src/leveldb/libleveldb.a $$PWD/src/leveldb/libmemenv.a
 !win32 {
     # we use QMAKE_CXXFLAGS_RELEASE even without RELEASE=1 because we use RELEASE to indicate linking preferences not -O preferences
-    # genleveldb.commands = cd $$PWD/src/leveldb && CC=$$QMAKE_CC CXX=$$QMAKE_CXX $(MAKE) OPT=\"$$QMAKE_CXXFLAGS $$QMAKE_CXXFLAGS_RELEASE\" libleveldb.a libmemenv.a
+    genleveldb.commands = cd $$PWD/src/leveldb && CC=$$QMAKE_CC CXX=$$QMAKE_CXX $(MAKE) OPT=\"$$QMAKE_CXXFLAGS $$QMAKE_CXXFLAGS_RELEASE\" libleveldb.a libmemenv.a
 } else {
     # make an educated guess about what the ranlib command is called
     isEmpty(QMAKE_RANLIB) {
         QMAKE_RANLIB = $$replace(QMAKE_STRIP, strip, ranlib)
     }
     LIBS += -lshlwapi
-    # genleveldb.commands = cd $$PWD/src/leveldb && CC=$$QMAKE_CC CXX=$$QMAKE_CXX TARGET_OS=OS_WINDOWS_CROSSCOMPILE $(MAKE) OPT=\"$$QMAKE_CXXFLAGS $$QMAKE_CXXFLAGS_RELEASE\" libleveldb.a libmemenv.a && $$QMAKE_RANLIB $$PWD/src/leveldb/libleveldb.a && $$QMAKE_RANLIB $$PWD/src/leveldb/libmemenv.a
+    genleveldb.commands = cd $$PWD/src/leveldb && CC=$$QMAKE_CC CXX=$$QMAKE_CXX TARGET_OS=OS_WINDOWS_CROSSCOMPILE $(MAKE) OPT=\"$$QMAKE_CXXFLAGS $$QMAKE_CXXFLAGS_RELEASE\" libleveldb.a libmemenv.a && $$QMAKE_RANLIB $$PWD/src/leveldb/libleveldb.a && $$QMAKE_RANLIB $$PWD/src/leveldb/libmemenv.a
 }
 genleveldb.target = $$PWD/src/leveldb/libleveldb.a
 genleveldb.depends = FORCE

diff --git a/share/qt/Info.plist b/share/qt/Info.plist
index 2312094..378b1c2 100755
--- a/share/qt/Info.plist
+++ b/share/qt/Info.plist
@@ -15,19 +15,19 @@
 	<key>CFBundleSignature</key>
 	<string>????</string>
 	<key>CFBundleExecutable</key>
-	<string>Bitcoin-Qt</string>
+	<string>Securecoin-Qt</string>
 	<key>CFBundleIdentifier</key>
-	<string>org.bitcoinfoundation.Bitcoin-Qt</string>
+	<string>org.securecoin.Securecoin-Qt</string>
         <key>CFBundleURLTypes</key>
         <array>
           <dict>
             <key>CFBundleTypeRole</key>
             <string>Editor</string>
             <key>CFBundleURLName</key>
-            <string>org.bitcoinfoundation.BitcoinPayment</string>
+            <string>org.securecoin.SecurecoinPayment</string>
             <key>CFBundleURLSchemes</key>
             <array>
-              <string>bitcoin</string>
+              <string>securecoin</string>
             </array>
           </dict>
         </array>
diff --git a/src/makefile.osx b/src/makefile.osx
index 8caac87..1f735a6 100755
--- a/src/makefile.osx
+++ b/src/makefile.osx
@@ -7,6 +7,7 @@
 # Originally by Laszlo Hanyecz (solar@heliacal.net)
 
 CXX=llvm-g++
+CC=llvm-gcc
 DEPSDIR=/opt/local
 
 INCLUDEPATHS= \
@@ -157,7 +158,7 @@ obj/%.o: %.cpp
 	  rm -f $(@:%.o=%.d)
 
 obj/%.o: %.c
-	$(CXX) -c $(CFLAGS) -fpermissive -MMD -MF $(@:%.o=%.d) -o $@ $<
+	$(CC) -c $(CFLAGS) -fpermissive -MMD -MF $(@:%.o=%.d) -o $@ $<
 	@cp $(@:%.o=%.d) $(@:%.o=%.P); \
 	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
 	      -e '/^$$/ d' -e 's/$$/ :/' < $(@:%.o=%.d) >> $(@:%.o=%.P); \

