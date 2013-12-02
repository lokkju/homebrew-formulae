require 'formula'

class Securecoin < Formula
  homepage ''
  url 'https://github.com/lokkju/Securecoin/archive/0.8.3-beta-1.tar.gz'
  head 'https://github.com/lokkju/Securecoin.git'
  version '0.8.3-beta1'
  sha1 '3554adda1812558e86ff1a95656ee7b51de58675'

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

    You can also bootstrap your peers.dat and blockchain via the bootstrap.zip file available for this release:
    https://github.com/lokkju/Securecoin/releases/download/#{version}/bootstrap.zip
    EOS
  end

  def patches
#    DATA
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
