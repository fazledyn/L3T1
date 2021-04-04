%option noyywrap

%{

#include "bits/stdc++.h"
#include "lib/SymbolTable.h"

#define BUCKET_SIZE 7

SymbolTable st(BUCKET_SIZE);

FILE *logFile, *tokenFile;
int lineCount = 1, errorCount = 0;

string toUppercase(char *arr) {
	string ret(arr);
	for (int i=0; i < ret.length(); i++) {
		ret[i] = toupper(arr[i]);
	}
	return ret;
}

char processCharacter(char *arr) {
	string ret(arr);
	char ch;

	if (ret.length() == 3) {
		ch = ret[1];
	}
	else {
		if (ret[1] == '\\') {
			switch(ret[2]){
				case 'n':
					ch = '\n'; break;
				case 't':
					ch = '\t'; break;
				case 'r':
					ch = '\r'; break;
				case 'a':
					ch = '\a'; break;
				case 'f':
					ch = '\f'; break;
				case 'b':
					ch = '\b'; break;
				case 'v':
					ch = '\v'; break;
				case '0':
					ch = '\0'; break;
				case '\\':
					ch = '\\'; break;
				case '\"':
					ch = '\"'; break;	
				default:
					ch = ret[2]; break;
			}
		}
	}
	return ch;
}

%}

ADDOP [+-]
MULOP [*/%]
INCOP ("++"|"--")
RELOP (">"|">="|"<"|"<="|"=="|"!=")
ASSIGNOP ("=")
LOGICOP ("&&"|"||")
NOT ("!")
LPAREN ("(")
RPAREN (")")
LCURL ("{")
RCURL ("}")
LTHIRD ("[")
RTHIRD ("]")

COMMA [,]
SEMICOLON [;]

NEWLINE [\r?\n]
WHITESPACE [ \t\f\r\v]+

/* Keywords */
KEYWORD "break"|"case"|"char"|"continue"|"default"|"do"|"double"|"else"|"float"|"for"|"if"|"int"|"return"|"switch"|"while"|"void"

DIGIT [0-9]
DIGITS {DIGIT}+
CONST_INT {DIGITS}

EXP ([Ee][-+]?{DIGITS})
FLOAT_1 ({DIGITS}\.{DIGITS})({EXP})?
FLOAT_2 (\.{DIGITS})({EXP})?
FLOAT_3 ({DIGITS})({EXP})?
CONST_FLOAT ({FLOAT_1}|{FLOAT_2}|{FLOAT_3})

NORMAL_CHAR '([ -~]{-}['\\])'
SPECIAL_CHAR '(\\[nt\\afrbv0\"])'
CONST_CHAR {NORMAL_CHAR}|{SPECIAL_CHAR}

IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*

%%

{ADDOP} {
	fprintf(tokenFile, "<ADDOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <ADDOP> Lexeme %s found\n", lineCount, yytext);
}

{MULOP} {
	fprintf(tokenFile, "<MULOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <MULOP> Lexeme %s found\n", lineCount, yytext);
}

{INCOP} {
	fprintf(tokenFile, "<INCOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <INCOP> Lexeme %s found\n", lineCount, yytext);
}

{RELOP} {
	fprintf(tokenFile, "<RELOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <RELOP> Lexeme %s found\n", lineCount, yytext);
}

{ASSIGNOP} {
	fprintf(tokenFile, "<ASSIGNOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <ASSIGNOP> Lexeme %s found\n", lineCount, yytext);
}

{LOGICOP} {
	fprintf(tokenFile, "<LOGICOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <LOGICOP> Lexeme %s found\n", lineCount, yytext);
}

{NOT} {
	fprintf(tokenFile, "<NOT, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <NOT> Lexeme %s found\n", lineCount, yytext);
}

{LPAREN} {
	fprintf(tokenFile, "<LPAREN, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <LPAREN> Lexeme %s found\n", lineCount, yytext);
}

{RPAREN} {
	fprintf(tokenFile, "<REPAREN, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <REPAREN> Lexeme %s found\n", lineCount, yytext);
}

{LCURL} {
	fprintf(tokenFile, "<LCURL, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <LCURL> Lexeme %s found\n", lineCount, yytext);
}

{RCURL} {
	fprintf(tokenFile, "<RCURL, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <RCURL> Lexeme %s found\n", lineCount, yytext);
}

{LTHIRD} {
	fprintf(tokenFile, "<LTHIRD, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <LTHIRD> Lexeme %s found\n", lineCount, yytext);
}

{RTHIRD} {
	fprintf(tokenFile, "<RTHIRD, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <RTHIRD> Lexeme %s found\n", lineCount, yytext);
}

{COMMA} {
	fprintf(tokenFile, "<COMMA, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <COMMA> Lexeme %s found\n", lineCount, yytext);
}

{SEMICOLON} {
	fprintf(tokenFile, "<SEMICOLON, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <SEMICOLON> Lexeme %s found\n", lineCount, yytext);
}

{WHITESPACE} {}

{NEWLINE} { lineCount++; }

{KEYWORD} {
	string temp = toUppercase(yytext);
	fprintf(tokenFile, "<%s> ", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <%s> Lexeme %s found\n", lineCount, temp.c_str(), yytext);
}

{CONST_INT} {
	string temp(yytext);
	fprintf(tokenFile, "<CONST_INT, %s>", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <CONST_INT> Lexeme %s found\n", lineCount, yytext);
}

{CONST_FLOAT} {
	string temp(yytext);
	fprintf(tokenFile, "<CONST_FLOAT, %s>", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <CONST_FLOAT> Lexeme %s found\n", lineCount, yytext);
}

{CONST_CHAR} {
	char ch = processCharacter(yytext);
	fprintf(tokenFile, "<CONST_CHAR, %c>", ch);
	fprintf(logFile, "\nLine no %d: Token <CONST_CHAR> Lexeme %s found\n", lineCount, yytext);
}

{IDENTIFIER} {
	string temp(yytext);
	fprintf(tokenFile, "<ID, %s>", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <ID> Lexeme %s found\n", lineCount, yytext);
	
	st.insert(temp, "ID");
	st.printAllScope_(logFile);
}



%%

int main(int argc,char *argv[]){
	
	if(argc!=2){
		printf("Please provide input file name and try again\n");
		return 0;
	}
	
	FILE *inputFile = fopen(argv[1],"r");

	tokenFile = fopen("1705066_token.txt", "w");
	logFile = fopen("1705066_log.txt", "w");

	if(inputFile == nullptr){
		printf("Cannot open specified file\n");
		return 0;
	}

	yyin= inputFile;
	yylex();

	fclose(inputFile);
	fclose(logFile);
	fclose(tokenFile);

	return 0;
}
