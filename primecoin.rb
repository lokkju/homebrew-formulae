require 'formula'

class Primecoin < Formula
  homepage 'http://primecoin.org/'
  url 'https://github.com/primecoin/primecoin/archive/v0.1.2xpm.tar.gz'
  head 'https://github.com/primecoin/primecoin.git'
  version '0.1.2xpm'
  sha1 'f0745f83b560fe3748d9dbcc4f55ea97acc58a8b'

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
    EOS

    Bug reports and suggestions for this homebrew formula may be filed at: https://github.com/lokkju/homebrew-formulae/issues/

    If you find this formula useful, consider sending a tip to the formula author at XPM: AYhpx394ZmurA93hvFoJigBC8pezjAt1ww
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
diff --git a/src/serialize.h b/src/serialize.h
index e3d9939..eac4e06 100644
--- a/src/serialize.h
+++ b/src/serialize.h
@@ -895,19 +895,6 @@ public:
     iterator insert(iterator it, const char& x=char()) { return vch.insert(it, x); }
     void insert(iterator it, size_type n, const char& x) { vch.insert(it, n, x); }
 
-    void insert(iterator it, const_iterator first, const_iterator last)
-    {
-        assert(last - first >= 0);
-        if (it == vch.begin() + nReadPos && (unsigned int)(last - first) <= nReadPos)
-        {
-            // special case for inserting at the front when there's room
-            nReadPos -= (last - first);
-            memcpy(&vch[nReadPos], &first[0], last - first);
-        }
-        else
-            vch.insert(it, first, last);
-    }
-
     void insert(iterator it, std::vector<char>::const_iterator first, std::vector<char>::const_iterator last)
     {
         assert(last - first >= 0);

