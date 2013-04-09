from distutils.core import setup, Extension

module1 = Extension('_liq', 
    sources = ['_liq.c',
               'lib/libimagequant.c',
               'lib/blur.c',
               'lib/mediancut.c',
               'lib/mempool.c',
               'lib/nearest.c',
               'lib/pam.c',
               'lib/viter.c'
              ],
    extra_compile_args=['-std=c99'])

setup (name = 'PNGQuant',
    version = '1.0',
    description = 'This is a demo package',
    ext_modules = [module1])
