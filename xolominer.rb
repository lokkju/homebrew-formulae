require 'formula'

class Xolominer < Formula
  homepage 'http://primecoin.org/'
  url 'https://github.com/lokkju/primecoin.git', :revision => 'e71d317a5ba9b587f6f37c8e2f34458ae486dd65'
  head 'https://github.com/lokkju/primecoin.git'
  version '0.8.RC1-2'
  sha1 ''

  depends_on 'leveldb'
  depends_on 'boost'
  depends_on 'berkeley-db4'
  depends_on 'openssl'
  depends_on 'miniupnpc'
  depends_on 'gmp'
  
  def install

    # Remove unrecognized options if warned by configure
    Dir.chdir "src"
    system "make","-f","makefile.osx"
    File.rename "primeminer","xolominer"
    bin.install "xolominer"
  end

  def patches
#    DATA
  end

  def caveats; <<-EOS.undent
    Bug reports and suggestions for this homebrew formula may be filed at: https://github.com/lokkju/homebrew-formulae/issues/
    Bug reports and suggestions for this branch of the xolominer project may be filed at: https://github.com/lokkju/primecoin/issues/

    If you find this formula useful, consider sending a tip to the formula author at XPM: AN7g5PqQdYJhrSNfG5soHVX7xkzzPsB4HL
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

