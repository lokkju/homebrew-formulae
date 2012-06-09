require 'formula'

class Kicad < Formula
  url 'http://iut-tice.ujf-grenoble.fr/cao/sources/kicad_sources-2011-07-08-BZR3044.zip'
  # Since KiCad doesn't specify version numbers use what Ubuntu uses
  version '0.0.20110708'
  homepage 'http://www.lis.inpg.fr/realise_au_lis/kicad/'
  md5 '0f46b28df994a4914bfd8e6b1c75c8e6'

  depends_on 'cmake'
  depends_on 'wxpython'

  # def patches
  #     DATA
  # end

  def install
    args = []

    args << "#{std_cmake_parameters}"
    args << "-DCMAKE_OSX_ARCHITECTURES=x86_64 -isysroot /Developer/SDKs/MacOSX10.7.sdk -mmacosx-version-min=10.7"
    args << "-DCMAKE_OSX_SYSROOT=/Developer/SDKs/MacOSX10.7.sdk"
    args << "-DCMAKE_CXX_FLAGS=-D__ASSERTMACROS__"
    args << "-DCMAKE_EXE_LINKER_FLAGS=-lwx_osx_cocoau_aui-2.9"
    args << "-DCMAKE_BUILD_TYPE=Release"
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DKICAD_TESTING_VERSION=ON"

    system "cmake", *args
    system "make"
    system "make install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6b40156..3a844c0 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -108,7 +108,7 @@ if(USE_BOOST_POLYGON_LIBRARY)
 endif(USE_BOOST_POLYGON_LIBRARY)
 
 # Locations for install targets.
-set(KICAD_BIN bin
+set(KICAD_BIN .
     CACHE PATH "Location of KiCad binaries.")
 
 if(UNIX)
