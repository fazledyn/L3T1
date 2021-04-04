%option noyywrap 

%{

#include "bits/stdc++.h"
#include "lib/SymbolTable.h"

#define BUCKET_SIZE 7

SymbolTable st(BUCKET_SIZE);

FILE *logFile, *tokenFile;
int lineCount = 1, errorCount = 0;

void countLine(char *arr) {
	for (int i=0; i < strlen(arr); i++) {
		if (arr[i] == '\n') {
			lineCount++;
		}
	}
}

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

string processString(char *arr) {
	string str = "";
	int len = strlen(arr);

	for (int i=0; i < len; i++) {
		if (arr[i] == '\\' && i+1 < len) {
			
			if (arr[i+1] == 't')		str.push_back('\t');
			else if (arr[i+1] == 'n')	str.push_back('\n');
			else if (arr[i+1] == 'r')	str.push_back('\r');
			else if (arr[i+1] == 'f')	str.push_back('\f');
			else if (arr[i+1] == 'v')	str.push_back('\v');
			else if (arr[i+1] == 'a')	str.push_back('\a');
			else if (arr[i+1] == 'b')	str.push_back('\b');		
			
			i++;
		}
		else if (arr[i] == '\n'){
			// do nothing
		}
		else {
			str.push_back(arr[i]);
		}
	}
	return str;
}

%}

/* Operators */
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

NEWLINE [\n|\r\n]
WHITESPACE [ \t\f\r\v]+

/* Keywords */
KEYWORD "break"|"case"|"char"|"continue"|"default"|"do"|"double"|"else"|"float"|"for"|"if"|"int"|"return"|"switch"|"while"|"void"

/* Numbers and stuff */
DIGIT [0-9]
DIGITS {DIGIT}+
CONST_INT {DIGITS}

EXP ([Ee][-+]?{DIGITS})
FLOAT_1 ({DIGITS}\.{DIGITS})({EXP})?
FLOAT_2 (\.{DIGITS})({EXP})?
FLOAT_3 ({DIGITS})({EXP})?
CONST_FLOAT ({FLOAT_1}|{FLOAT_2}|{FLOAT_3})

/* Chars */
NORMAL_CHAR '([ -~]{-}['\\])'
SPECIAL_CHAR '(\\[nt\\afrbv0\"])'
CONST_CHAR {NORMAL_CHAR}|{SPECIAL_CHAR}

IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*

/* String */
SPC_FOR_STR (\n|\t)
NORMAL_CHAR_FOR_STR [^\n\"]
/*
STRING \"({SPC_FOR_STR}|{NORMAL_CHAR_FOR_STR})*\"
*/
STRING \"([^\"\n]|(\\[\n])|(\"))*\"


/* Comments */
SLASH_FOLLOWED_BY_NEWLINE ([\\]+([\n])?)?
NO_NEWLINE [^\n]*

/*
INLINE_COMMENT \/\/[^\n\r]+?(?:\*\)|[\n\r]
*/

INLINE_COMMENT "//"({SLASH_FOLLOWED_BY_NEWLINE}|{NO_NEWLINE})*


STAR_FOLLOWED_BY_NO_SLASH \*[^\/]
NO_STAR [^*]
MULTILINE_COMMENT ("/*")({NO_STAR}|{STAR_FOLLOWED_BY_NO_SLASH})*("*/")

COMMENT {INLINE_COMMENT}|{MULTILINE_COMMENT}

/* Lexical Errors */

FLOAT_IDEAL ({DIGITS}\.{DIGITS})
FLOAT_AUX (\.{DIGITS})

DECIMAL_ERR_1 ({FLOAT_IDEAL}|{FLOAT_AUX})
DECIMAL_ERR_2 ({FLOAT_IDEAL}|{FLOAT_AUX})*

TOO_MANY_DECIMAL_POINTS_ERROR {DECIMAL_ERR_1}{DECIMAL_ERR_2}

/*	Ill formed numbers
	1 - 1.2E23.4
	2 - 10E4.5
	3 - .34E3.4
*/
FLOAT_ERR_1 ({DIGITS}\.{DIGITS})([Ee][-+]?)({CONST_FLOAT})
FLOAT_ERR_2 (\.{DIGITS})([Ee][-+]?)({CONST_FLOAT})
FLOAT_ERR_3 ({DIGITS})([Ee][-+]?)({CONST_FLOAT})

ILL_FORMED_NUM_ERROR ({FLOAT_ERR_1}|{FLOAT_ERR_2}|{FLOAT_ERR_3})

/* Invalid number suffix or identifier prefix */
INVALID_IDENTIFIER_ERROR [0-9][a-zA-Z0-9_]*

/* Multi character error
	However, this is different from the CHAR regex. Because that had ' ' around them.
	And this is going to have multiple char within a ' '
*/
NORMAL_CHAR_DIGIT ([ -~]{-}['\\])
SPECIAL_CHAR_DIGIT (\\[nt\\afrbv0\"])

MULTI_CHAR_ERROR '(({NORMAL_CHAR_DIGIT}|{SPECIAL_CHAR_DIGIT})*)'

/* Unfinished char error */
UNFINISHED_CHAR '({NORMAL_CHAR_DIGIT}|{SPECIAL_CHAR_DIGIT})*
SINGLE_SLASH '[\\]'

UNFINISHED_CHAR_ERROR {UNFINISHED_CHAR}|{SINGLE_SLASH}

/* Empty character error */
EMPTY_CHAR_ERROR ''

/*
UNFINISHED_COMMENT "/*"({NO_STAR}|{STAR_FOLLOWED_BY_NO_SLASH})*"\n"
*/

STAR_COMMENT_START "/*"
/**/
ANYTHING_EXCEPT_STAR [^\*]
UNFINISHED_STAR_COMMENT {STAR_COMMENT_START}({ANYTHING_EXCEPT_STAR}|([\*]+[^*/]))*

UNFINISHED_COMMENT_1 \{([^}\n]*)\n

UNFINISHED_COMMENT {UNFINISHED_STAR_COMMENT}

UNFINISHED_STRING \"([^\"\n]|(\\[\n]))*

/*
SLASH [\\]
NOT_QUOTE_SLASH_OR_NEWLINE [^"\\\r\n]
ANYTHING ({NO_NEWLINE}|{NEWLINE})

UNFINISHED_STRING \"({NOT_QUOTE_SLASH_OR_NEWLINE}|{SLASH}{ANYTHING})*
*/

%%

{WHITESPACE} {}

{NEWLINE} { lineCount++; }

{COMMENT} {
	string temp(yytext);
	fprintf(logFile, "\nLine no %d: Token <COMMENT> Lexeme %s found\n", lineCount, temp.c_str());
	countLine(yytext);
}

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
	st.enterScope();
}

{RCURL} {
	fprintf(tokenFile, "<RCURL, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <RCURL> Lexeme %s found\n", lineCount, yytext);
	st.exitScope();
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

{KEYWORD} {
	string temp = toUppercase(yytext);
	fprintf(tokenFile, "<%s> ", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <%s> Lexeme %s found\n", lineCount, temp.c_str(), yytext);
}

{CONST_INT} {
	string temp(yytext);
	fprintf(tokenFile, "<CONST_INT, %s> ", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <CONST_INT> Lexeme %s found\n", lineCount, yytext);
	
	st.insert(temp, "CONST_INT");
	st.printAllScope_(logFile);
}

{CONST_FLOAT} {
	string temp(yytext);
	fprintf(tokenFile, "<CONST_FLOAT, %s> ", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <CONST_FLOAT> Lexeme %s found\n", lineCount, yytext);
	
	st.insert(temp, "CONST_FLOAT");
	st.printAllScope_(logFile);
}

{CONST_CHAR} {
	char ch = processCharacter(yytext);
	fprintf(tokenFile, "<CONST_CHAR, %c> ", ch);
	fprintf(logFile, "\nLine no %d: Token <CONST_CHAR> Lexeme %s found", lineCount, yytext);
	fprintf(logFile, " --> <CHAR_CONST, %c>\n", ch);
	
	string temp(yytext);
	st.insert(temp, "CONST_CHAR");
	st.printAllScope_(logFile);
}

{IDENTIFIER} {
	string temp(yytext);
	fprintf(tokenFile, "<ID, %s> ", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <ID> Lexeme %s found\n", lineCount, yytext);

	if (st.lookup(temp) == nullptr)	{
		st.insert(temp, "ID");
		st.printAllScope_(logFile);
	}
	else {
		fprintf(logFile, " \n%s already exists in current ScopeTable\n", temp.c_str());
	}
}

{STRING} {
	string temp = processString(yytext);
	fprintf(tokenFile, "<STRING, %s> ", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <STRING> Lexeme %s found", lineCount, yytext);
	fprintf(logFile, " --> <STRING, %s>\n", temp.c_str());
	countLine(yytext);
}

{TOO_MANY_DECIMAL_POINTS_ERROR} {
	fprintf(logFile, "\nError at line no %d: ", lineCount);
	fprintf(logFile, "Too many decimal point error for character sequence like %s\n", yytext);
	errorCount++;
}

{ILL_FORMED_NUM_ERROR} {
	fprintf(logFile, "\nError at line no %d: ", lineCount);
	fprintf(logFile, "Ill formed number such as %s\n", yytext);
	errorCount++;
}

{INVALID_IDENTIFIER_ERROR} {
	fprintf(logFile, "\nError at line no %d: ", lineCount);
	fprintf(logFile, "Invalid Suffix on numeric constant or invalid prefix on identifier for character sequence like %s\n", yytext);
	errorCount++;
}

{EMPTY_CHAR_ERROR} {
	fprintf(logFile, "\nError at line no %d: ", lineCount);
	fprintf(logFile, "Empty character constant %s\n", yytext);
	errorCount++;
}

{MULTI_CHAR_ERROR} {
	fprintf(logFile, "\nError at line no %d: ", lineCount);
	fprintf(logFile, "Multi character constant error for character sequence like %s\n", yytext);
	errorCount++;
}

{UNFINISHED_CHAR_ERROR} {
	fprintf(logFile, "\nError at line no %d: ", lineCount);
	fprintf(logFile, "Unfinished character such as %s\n", yytext);
	errorCount++;
}

{UNFINISHED_COMMENT} {
	fprintf(logFile, "\nError at line no %d: ", lineCount);
	fprintf(logFile, "Unfinished comment at %s\n", yytext);
	errorCount++;
	countLine(yytext);
}

{UNFINISHED_STRING} {
	fprintf(logFile, "\nError at line no %d: ", lineCount);
	fprintf(logFile, "Unfinished string at %s\n", yytext);
	errorCount++;
	countLine(yytext);
}

. {
	fprintf(logFile, "\nError at line no %d: ", lineCount);
	fprintf(logFile, "Unrecognized character at %s\n", yytext);
	errorCount++;
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

	st.printAllScope_(logFile);
	fprintf(logFile, "\nTotal lines: %d\n", lineCount);
	fprintf(logFile, "Total Errors: %d\n", errorCount);

	fclose(inputFile);
	fclose(logFile);
	fclose(tokenFile);
	
	return 0;
}
