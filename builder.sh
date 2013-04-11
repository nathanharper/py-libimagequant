swig -python liq.i
gcc -Wall -Wno-unknown-pragmas -I. -DNDEBUG -O3 -fstrict-aliasing -ffast-math -funroll-loops -fomit-frame-pointer -ffinite-math-only -std=c99 -I/usr/include/python2.7 -fPIC -c lib/libimagequant.c lib/mempool.c lib/pam.c lib/mediancut.c lib/nearest.c lib/viter.c lib/blur.c liq_wrap.c
ld -shared libimagequant.o mempool.o pam.o mediancut.o nearest.o blur.o viter.o liq_wrap.o -o _liq.so
