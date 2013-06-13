require 'formula'

class Cdh4Hadoop < Formula
  homepage 'http://cloudera.com'
  url 'http://archive.cloudera.com/cdh4/cdh/4/hadoop-2.0.0-cdh4.3.0.tar.gz'
  sha1 '7f537c572d65baf485e1571a971b654c9348fa8d'
  version '2.0.0+1357'

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install %w[bin cloudera examples include libexec share bin-mapreduce1 etc examples-mapreduce1 lib sbin src]
    libexec.install Dir['*.jar']
    bin.write_exec_script Dir["#{libexec}/bin/*"]
    # But don't make rcc visible, it conflicts with Qt
    (bin/'rcc').unlink

    inreplace "#{libexec}/etc/hadoop/hadoop-env.sh",
      "# export JAVA_HOME=/usr/lib/j2sdk1.5-sun",
      "export JAVA_HOME=\"$(/usr/libexec/java_home)\""
  end

  def caveats; <<-EOS.undent
    In Hadoop's config file:
      #{libexec}/etc/hadoop/hadoop-env.sh
    $JAVA_HOME has been set to be the output of:
      /usr/libexec/java_home
    EOS
  end
end
