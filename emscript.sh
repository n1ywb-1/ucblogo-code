#!/bin/env sh

# wasm mdarray unit test crashes with OOB error with -O > 0
# Future: use -mtail-call (is the interpreter even recursive?)
CFLAGS="-std=c90 -Wno-int-conversion -O1 -g" \
CXXFLAGS="-O1 -g" \
emconfigure ./configure --disable-docs --disable-x11 --disable-wx --prefix=/ --datadir=/logolib --enable-wasm && \
make clean && emmake make -j9 && \
# Final link step
# I assume this is required due to an incomplete integration between emscripten
# and autotools
em++ -gsource-map -O1 -Wno-write-strings -Wno-unused-variable -o ucblogo.js ucblogo-coms.o ucblogo-error.o ucblogo-eval.o ucblogo-files.o ucblogo-graphics.o ucblogo-init.o ucblogo-intern.o ucblogo-libloc.o ucblogo-lists.o ucblogo-logodata.o ucblogo-main.o ucblogo-math.o ucblogo-mem.o ucblogo-paren.o ucblogo-parse.o ucblogo-print.o ucblogo-wrksp.o   ucblogo-term.o  ucblogo-nographics.o   --embed-file logolib --pre-js pre.js --embed-file tests  -s ASYNCIFY -s ASYNCIFY_STACK_SIZE=10000 -s ALLOW_MEMORY_GROWTH \
-s SAFE_HEAP=2 -s STACK_OVERFLOW_CHECK=2 -s EXIT_RUNTIME=1 -s ASSERTIONS=2 \
--profiling-funcs
# -fsanitize=address 
# -s EXCEPTION_DEBUG=1 -s ASYNCIFY_ADVISE=1 -s ASYNCIFY_DEBUG=1 -s MODULARIZE -s EXPORT_ES6 

# python3 -m http.server 8080 & xdg-open http://0.0.0.0:8080/ucblogo.html

