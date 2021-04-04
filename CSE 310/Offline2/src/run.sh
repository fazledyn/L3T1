flex 1705066.l
g++ lex.yy.c -lfl

command=$1

if [ "$command" = "clr" ]
then 
    rm -rf 1705066_log.txt
    rm -rf 1705066_token.txt
    rm -rf a.out
    rm -rf lex.yy.c
else
    ./a.out "$command"
fi
