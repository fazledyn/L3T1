bison -d -y 1705066.y
echo "Generated parser header"
g++ -w -c -o y.o y.tab.c
echo "Generated parser object"
flex 1705066.l
echo "Generated scanner c file"
g++ -w -c -o l.o lex.yy.c
echo "Generated Scanner object file"
g++ y.o l.o -lfl
echo "Running file input.c"

./a.out input.c

rm -rf *.o
rm -rf y.tab.*
rm -rf lex.yy.c
rm -rf *.out
