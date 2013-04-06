require 'formula'

class Stormlib < Formula
  homepage 'https://github.com/stormlib/StormLib'
  url 'https://github.com/stormlib/StormLib/archive/v8.21.tar.gz'
  sha1 '76a783538f26f14b3b4b8d48158ee1e86900b723'

  depends_on 'cmake' => :build
  def patches
    DATA
  end

  def install
    # ENV.j1  # if your formula's build system can't parallelize
    system "cmake", ".", "-DWITH_TEST=YES", "-DWITH_STATIC=YES", *std_cmake_args
    system "make install" # if this fails, try separate make/make install steps
  end

  def test
    return true
  end
end


__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index d78825f..109e90a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -299,6 +299,6 @@ if(WIN32)
     set_target_properties(storm PROPERTIES OUTPUT_NAME StormLib)
 endif()
 
-install(TARGETS storm RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib FRAMEWORK DESTINATION /Library/Frameworks)
+install(TARGETS storm RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib FRAMEWORK DESTINATION Frameworks)
 install(FILES src/StormLib.h src/StormPort.h DESTINATION include)
 

