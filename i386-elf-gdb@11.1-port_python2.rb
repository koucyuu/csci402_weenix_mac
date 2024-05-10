class I386ElfGdbAT111 < Formula
  desc "GNU Project Debugger targetting i386-elf"
  homepage "https://www.gnu.org/software/gdb/"
  url "https://ftp.gnu.org/gnu/gdb/gdb-11.1.tar.xz"
  sha256 "cccfcc407b20d343fb320d4a9a2110776dd3165118ffd41f4b1b162340333f94"
  revision 2
  env :std

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--target=i386-elf",
                          "--program-prefix=i386-elf-",
                          "CXXFLAGS=-Wno-enum-constexpr-conversion",
                          "--with-python=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/python2.7",
                          "--disable-werror"

    system "make"
    system "make", "install"

    # Conflict with i386-elf-binutils
    rm_rf info
    rm_rf "#{share}/locale"
  end

  test do
    system "#{bin}/i386-elf-gdb", "--version"
  end
end
