rm -rf *.out
rm -rf lex.yy.c

flex 1705066.l
g++ lex.yy.c -lfl
./a.out $1
