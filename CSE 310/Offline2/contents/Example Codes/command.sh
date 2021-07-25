flex -o state.c state.l
g++ state.c -lfl -o state.out
./state.out state.txt
