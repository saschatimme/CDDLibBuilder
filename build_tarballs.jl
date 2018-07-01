using BinaryBuilder

name = "CDDLib"
version = v"0.94h"

sources = [
    "https://github.com/saschatimme/cddlib/archive/v0.94h.tar.gz" =>
    "c14181fe20562d09f09a5ec010d0ae6323e0ff18fa539f671777163a385b1b9a"
]

script = raw"""
cd $WORKSPACE/srcdir/cddlib-*/

./configure --prefix=${prefix} --host=${target}
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

dependencies = [
    # We need GMP
    "https://github.com/JuliaMath/GMPBuilder/releases/download/v6.1.2/build.jl"
]

# Build 'em!
build_tarballs(
    ARGS,
    name,
    version,
    sources,
    script,
    platforms,
    products,
    dependencies,
)
