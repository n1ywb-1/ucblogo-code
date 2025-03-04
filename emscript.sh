#!/bin/env sh

# wasm mdarray unit test crashes with OOB error with -O > 0
CFLAGS="-std=c90 -Wno-int-conversion -g -O0" CXXFLAGS="-g -O0"  emconfigure ./configure --disable-docs --disable-x11 --disable-wx --prefix=/ --datadir=/logolib --enable-wasm

make clean && emmake make -j9

# Final link step
# I assume this is required due to an incomplete integration between emscripten
# and autotools
em++ -O0 -g -Wno-write-strings -Wno-unused-variable   -o ucblogo.html ucblogo-coms.o ucblogo-error.o ucblogo-eval.o ucblogo-files.o ucblogo-graphics.o ucblogo-init.o ucblogo-intern.o ucblogo-libloc.o ucblogo-lists.o ucblogo-logodata.o ucblogo-main.o ucblogo-math.o ucblogo-mem.o ucblogo-paren.o ucblogo-parse.o ucblogo-print.o ucblogo-wrksp.o   ucblogo-term.o  ucblogo-nographics.o   --embed-file logolib --pre-js pre.js --embed-file tests  -s ASYNCIFY -s ASYNCIFY_STACK_SIZE=10000

python3 -m http.server 8080 & xdg-open http://0.0.0.0:8080/ucblogo.html

