require 'formula'

class Pssh < Formula
  homepage 'https://code.google.com/p/parallel-ssh/'
  url 'https://parallel-ssh.googlecode.com/files/pssh-2.3.1.tar.gz'
  version '2.3.1'
  head 'https://code.google.com/p/parallel-ssh/source/browse/', :using => :git, :tag => '2.3.1'
  sha1 '65736354baaa289cffdf374eb2ffd9aa1eda7d85'

  depends_on :python

  def install
    # ENV.j1  # if your formula's build system can't parallelize

    system python, "setup.py", "install", "--prefix=#{prefix}"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test pssh`.
  end
end
