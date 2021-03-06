#!/bin/sh
export CPPFLAGS="-I${PREFIX}/include"
export LDFLAGS="$LDFLAGS -L${PREFIX}/lib"
export CXXINTRINSICS="-msse2 -msse3 -msse4 -mpopcnt"
make -j${CPU_COUNT}

cd apps/umve/
qmake && make -j${CPU_COUNT}

# Install
cd ../../

for f in $(ls apps); do
    if [ -d apps/$f ]; then
        cp apps/$f/$f ${PREFIX}/bin
    fi
done

find . -name "*.a" -exec cp {} ${PREFIX}/lib \;
