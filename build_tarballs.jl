using BinaryBuilder

name = "CDDLib"
version = v"0.94h"

sources = [
    "https://github.com/saschatimme/cddlib/archive/v0.94h.tar.gz" =>
    "c14181fe20562d09f09a5ec010d0ae6323e0ff18fa539f671777163a385b1b9a",
    "https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2" =>
    "5275bb04f4863a13516b2f39392ac5e272f5e1bb8057b18aec1c9b79d73d8fb2"
]

script = raw"""
echo $prefix
cd $WORKSPACE/srcdir/gmp-*/
mkdir -p $WORKSPACE/tmpdir
./configure --prefix=$WORKSPACE/tmpdir/gmp --host=${target}
make
make install

cd $WORKSPACE/srcdir/cddlib-*/

./configure --prefix=${prefix} --host=${target} CFLAGS="-I$WORKSPACE/tmpdir/gmp/include -L$WORKSPACE/tmpdir/gmp/lib"
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
    name,
    version,
    sources,
    script,
    platforms,
    products,
    dependencies,
)
