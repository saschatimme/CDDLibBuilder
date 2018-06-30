using BinaryBuilder

name = "CDDLib"
version = v"0.94h"

src_tarball = "https://github.com/saschatimme/cddlib/archive/v0.94h.tar.gz"
src_hash    = "d0d154f1cf94c53da2efd835b51b608a5a5bccf825d5571122e0d9eda1505815"
sources = [
    src_tarball => src_hash
]

script = raw"""
make
make install
"""

platforms = [
    BinaryProvider.Windows(:i686),
    BinaryProvider.Windows(:x86_64),
    BinaryProvider.Linux(:i686, :glibc),
    BinaryProvider.Linux(:x86_64, :glibc),
    BinaryProvider.Linux(:aarch64, :glibc),
    BinaryProvider.Linux(:armv7l, :glibc),
    # ppc64le isn't working right now....
    #BinaryProvider.Linux(:powerpc64le, :glibc),
    BinaryProvider.MacOS()
]

products(prefix) = [
    LibraryProduct(prefix, "cddlib", :cddlib)
]

dependencies = []

# Build 'em!
build_tarballs(
    ARGS,
    "libfoo",
    sources,
    script,
    platforms,
    products,
    dependencies,
)
