require 'formula'

class Extremecoin < Formula
  homepage ''
  url 'https://github.com/CaptChadd/Extremecoin.git', :revision => 'ce9c443a6cb1a6c216592bc51311418d967092ad'
  head 'https://github.xom/CaptChadd/Extremecoin.git'
  version '1.3'
  sha1 ''

  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on 'boost'
  depends_on 'berkeley-db4'
  depends_on 'openssl'
  depends_on 'miniupnpc'
  depends_on 'qrencode' => :optional
  
  def install
    # ENV.j1  # if your formula's build system can't parallelize

    # Remove unrecognized options if warned by configure
    Dir.chdir 'src'
    system "make","-f","makefile.osx"
    bin.install('Extremecoin')
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
