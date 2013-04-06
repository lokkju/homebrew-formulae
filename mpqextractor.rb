require 'formula'
class Mpqextractor < Formula
  homepage 'https://github.com/Kanma/MPQExtractor'
  url 'https://github.com/Kanma/MPQExtractor/archive/6cb515122170ce02bf505f11edc403c1de091483.tar.gz'
  sha1 'ccba935f0648ff328db1cf44ebce162767891d0e'
  head 'https://github.com/Kanma/MPQExtractor.git', :revision => '6cb515122170ce02bf505f11edc403c1de091483'

  depends_on 'cmake' => :build

  def patches
    DATA
  end

  def install
    ENV.j1  # if your formula's build system can't parallelize

    system "cmake", ".", "-DCMAKE_LIBRARY_PATH=#{HOMEBREW_PREFIX}/Frameworks/storm.framework/",*std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    system "false"
  end
end


__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 39b6560..21ed48a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -6,29 +6,20 @@ set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${MPQEXTRACTOR_BINARY_DIR}/lib")
 set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${MPQEXTRACTOR_BINARY_DIR}/bin")
 
 
-if (NOT EXISTS "${MPQEXTRACTOR_SOURCE_DIR}/StormLib/CMakeLists.txt")
-    message(FATAL_ERROR
-"Missing dependency: StormLib
-MPQExtractor requires the StormLib library.
-It is provided as a GIT submodule of this repository.
-Did you forgot to execute the following commands?
-   git submodule init
-   git submodule update")
-endif()
+include_directories("${MPQEXTRACTOR_SOURCE_DIR}/include/")
+
 
 
-add_subdirectory(StormLib)
-
-include_directories("${MPQEXTRACTOR_SOURCE_DIR}/StormLib/src/"
-                    "${MPQEXTRACTOR_SOURCE_DIR}/include/"
-)
-
 add_executable(MPQExtractor main.cpp)
-target_link_libraries(MPQExtractor storm)
+find_library(STORM NAMES storm PATHS "HOMEBREW_PREFIX/Frameworks")
+target_link_libraries(MPQExtractor ${STORM})
 
 # Set the RPATH
-if (APPLE)
-    set_target_properties(MPQExtractor PROPERTIES LINK_FLAGS "-Wl,-rpath,@loader_path/.")
-elseif (UNIX)
-    set_target_properties(MPQExtractor PROPERTIES INSTALL_RPATH ".")
-endif()
+if (APPLE)
+    set_target_properties(MPQExtractor PROPERTIES LINK_FLAGS "-Wl,-rpath,HOMEBREW_PREFIX/Frameworks/.")
+elseif (UNIX)
+    set_target_properties(MPQExtractor PROPERTIES INSTALL_RPATH ".")
+endif()
+
+install(TARGETS MPQExtractor RUNTIME DESTINATION bin LIBRARY DESTINATION lib ARCHIVE DESTINATION lib FRAMEWORK DESTINATION Frameworks)
+
 
