yacc -Wyacc -y -d -Wno-yacc 1705066.y
g++ -w -c -o y.o y.tab.c
flex 1705066.l
g++ -w -c -o l.o lex.yy.c
g++ -o a.out y.o l.o -lfl
./a.out $1