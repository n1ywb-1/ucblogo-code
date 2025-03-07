#!/bin/bash -v

# wasm mdarray unit test crashes with OOB error with -O > 0
# Future: use -mtail-call (is the interpreter even recursive?)

export CFLAGS="-std=c90 -Wno-int-conversion -O1 -g"
export CXXFLAGS="-O1 -g"

emconfigure ./configure --disable-docs --disable-x11 --disable-wx --prefix=/ --datadir=/logolib --enable-wasm 

make clean && emmake make -j9

# Final link step
# I assume this is required due to an incomplete integration between emscripten
# and autotools

em++ -O1 -gsource-map -Wno-write-strings -Wno-unused-variable -o ucblogo.html \
ucblogo-coms.o ucblogo-error.o ucblogo-eval.o ucblogo-files.o ucblogo-graphics.o \
ucblogo-init.o ucblogo-intern.o ucblogo-libloc.o ucblogo-lists.o \
ucblogo-logodata.o ucblogo-main.o ucblogo-math.o ucblogo-mem.o ucblogo-paren.o \
ucblogo-parse.o ucblogo-print.o ucblogo-wrksp.o   ucblogo-term.o \
ucblogo-nographics.o \
--embed-file logolib \
--pre-js pre.js \
--embed-file tests \
-s ASYNCIFY=2 \
-s ASYNCIFY_STACK_SIZE=100000 \
-s ALLOW_MEMORY_GROWTH \
-s SAFE_HEAP=2 -s STACK_OVERFLOW_CHECK=2 -s EXIT_RUNTIME=1 -s ASSERTIONS=2

#--embed-file ucblogo.wasm.map \
#-s EXCEPTION_DEBUG=1  \
#-s ASYNCIFY_ADVISE=1 \
#-s ASYNCIFY_DEBUG=1 


# Doesn't work with asyncify
# Does it work with JSPI?
# -fsanitize=address 

# redundant with -gsource-maps
# --profiling-funcs \

# This is future but node isn't quite there
# -s MODULARIZE -s EXPORT_ES6 

# Must enable experimental wasm stack swtiching in chrome://flags
# Run tests by 
# 1. typing into the dialog box: load "tests/test.lg"
# 2. Click OK (adds line to buffer)
# 3. Click Cancel (executes lines in buffer)
# 4. Watch output pane
# python3 -m http.server 8080 & xdg-open http://0.0.0.0:8080/ucblogo.html

# Or use node; it uses the same V8 engine as chrome
#node --experimental-wasm-stack-switching  ./ucblogo.js tests/test.lg
