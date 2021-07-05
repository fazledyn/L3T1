%option noyywrap

%{
#include "bits/stdc++.h"
#include "lib/SymbolTable.h"
#include "y.tab.h"
using namespace std;

#define YYSTYPE SymbolInfo*

void yyerror(char*);

extern FILE *log_file;

extern int line_count;
extern int error_count;

extern SymbolTable st;

void countLine(char *arr) {
	for (int i=0; i < strlen(arr); i++) {
		if (arr[i] == '\n') {
			line_count++;
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
			else if (arr[i+1] == '\"')	str.push_back('\"');

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
INCOP ("++")
DECOP ("--")
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
BREAK "break"
CASE "case"
CONTINUE "continue"
DEFAULT "default"
RETURN "return"
SWITCH "switch"

DO "do"
WHILE "while"
FOR "for"

IF "if"
ELSE "else"

VOID "void"
CHAR "char"
DOUBLE "double"
FLOAT "float"
INT "int"

PRINTLN "println"

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

ID [a-zA-Z_][a-zA-Z0-9_]*

STRING \"([^\"\n]|(\\[\n])|(\"))*\"


/* Comments */
SLASH_FOLLOWED_BY_NEWLINE ([\\]+([\n])?)?
NO_NEWLINE [^\n]*

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

STAR_COMMENT_START "/*"
/**/

ANYTHING_EXCEPT_STAR [^\*]
UNFINISHED_STAR_COMMENT {STAR_COMMENT_START}({ANYTHING_EXCEPT_STAR}|([\*]+[^*/]))*

UNFINISHED_COMMENT {UNFINISHED_STAR_COMMENT}

UNFINISHED_STRING \"([^\"\n]|(\\[\n]))*

%%

{WHITESPACE} {}
{NEWLINE} { line_count++; }

{BREAK} { return BREAK; }
{CASE} { return CASE; }
{CONTINUE} { return CONTINUE; }
{DEFAULT} { return DEFAULT; }
{RETURN} { return RETURN; }
{SWITCH} { return SWITCH; }

{DO} { return DO; }
{WHILE} { return WHILE; }
{FOR} { return FOR; }

{IF} { return IF; }
{ELSE} { return ELSE; }

{VOID} { return VOID; }
{CHAR} { return CHAR; }
{DOUBLE} { return DOUBLE; }
{FLOAT} { return FLOAT; }
{INT} { return INT; }

{PRINTLN} { return PRINTLN; }


{COMMENT} {
	/* string temp(yytext);
	fprintf(logFile, "\nLine no %d: Token <COMMENT> Lexeme %s found\n", line_count, temp.c_str());
	countLine(yytext); */
}

{ADDOP} {
	/* fprintf(tokenFile, "<ADDOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <ADDOP> Lexeme %s found\n", line_count, yytext); */

	string temp(yytext);
	SymbolInfo* apiId = new SymbolInfo(temp, "ID");

	yylval.syminfo = (YYSTYPE) apiId;
	return ADDOP;
}

{MULOP} {
	/* fprintf(tokenFile, "<MULOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <MULOP> Lexeme %s found\n", line_count, yytext); */

	string temp(yytext);
	SymbolInfo* apiId = new SymbolInfo(temp, "ID");

	yylval.syminfo = (YYSTYPE) apiId;
	return MULOP;
}

{INCOP} {
	/* fprintf(tokenFile, "<INCOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <INCOP> Lexeme %s found\n", line_count, yytext); */

	return INCOP;
}

{DECOP} {
	/* fprintf(tokenFile, "<DECOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <DECOP> Lexeme %s found\n", line_count, yytext); */

	return DECOP;
}

{RELOP} {
	/* fprintf(tokenFile, "<RELOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <RELOP> Lexeme %s found\n", line_count, yytext); */

	string temp(yytext);
	SymbolInfo* apiId = new SymbolInfo(temp, "ID");

	yylval.syminfo = (YYSTYPE) apiId;
	return RELOP;
}

{ASSIGNOP} {
	/* fprintf(tokenFile, "<ASSIGNOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <ASSIGNOP> Lexeme %s found\n", line_count, yytext); */
	return ASSIGNOP;
}

{LOGICOP} {
	/* fprintf(tokenFile, "<LOGICOP, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <LOGICOP> Lexeme %s found\n", line_count, yytext); */

	string temp(yytext);
	SymbolInfo* apiId = new SymbolInfo(temp, "ID");

	yylval.syminfo = (YYSTYPE) apiId;
	return LOGICOP;
}

{NOT} {
	/* fprintf(tokenFile, "<NOT, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <NOT> Lexeme %s found\n", line_count, yytext); */
	return NOT;
}

{LPAREN} {
	/* fprintf(tokenFile, "<LPAREN, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <LPAREN> Lexeme %s found\n", line_count, yytext); */
	return LPAREN;
}

{RPAREN} {
	/* fprintf(tokenFile, "<RPAREN, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <RPAREN> Lexeme %s found\n", line_count, yytext); */
	return RPAREN;
}

{LCURL} {
	/* fprintf(tokenFile, "<LCURL, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <LCURL> Lexeme %s found\n", line_count, yytext);
	st.enterScope(); */

	return LCURL;
}

{RCURL} {
	/* fprintf(tokenFile, "<RCURL, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <RCURL> Lexeme %s found\n", line_count, yytext);
	st.exitScope(); */

	return RCURL;
}

{LTHIRD} {
	/* fprintf(tokenFile, "<LTHIRD, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <LTHIRD> Lexeme %s found\n", line_count, yytext); */
	return LTHIRD;
}

{RTHIRD} {
	/* fprintf(tokenFile, "<RTHIRD, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <RTHIRD> Lexeme %s found\n", line_count, yytext); */
	return RTHIRD;
}

{COMMA} {
	/* fprintf(tokenFile, "<COMMA, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <COMMA> Lexeme %s found\n", line_count, yytext); */
	return COMMA;
}

{SEMICOLON} {
	/* fprintf(tokenFile, "<SEMICOLON, %s> ", yytext);
	fprintf(logFile, "\nLine no %d: Token <SEMICOLON> Lexeme %s found\n", line_count, yytext); */

	return SEMICOLON;
}

{CONST_INT} {
	/* string temp(yytext);
	fprintf(tokenFile, "<CONST_INT, %s> ", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <CONST_INT> Lexeme %s found\n", line_count, yytext);

	st.insert(temp, "CONST_INT");
	st.printAllScope_(logFile);
 */

	string temp(yytext);
	SymbolInfo* apiId = new SymbolInfo(temp, "int");

	yylval.syminfo = (YYSTYPE) apiId;
	return CONST_INT;
}

{CONST_FLOAT} {
	/* string temp(yytext);
	fprintf(tokenFile, "<CONST_FLOAT, %s> ", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <CONST_FLOAT> Lexeme %s found\n", line_count, yytext);

	st.insert(temp, "CONST_FLOAT");
	st.printAllScope_(logFile);
*/

	string temp(yytext);
	SymbolInfo* apiId = new SymbolInfo(temp, "float");

	yylval.syminfo = (YYSTYPE) apiId;
	return CONST_FLOAT;
}

{CONST_CHAR} {
	/* char ch = processCharacter(yytext);
	fprintf(tokenFile, "<CONST_CHAR, %c> ", ch);
	fprintf(logFile, "\nLine no %d: Token <CONST_CHAR> Lexeme %s found", line_count, yytext);
	fprintf(logFile, " --> <CHAR_CONST, %c>\n", ch);

	string temp(yytext);
	st.insert(temp, "CONST_CHAR");
	st.printAllScope_(logFile); */

	return CONST_CHAR;
}

{ID} {
	/* string temp(yytext);
	fprintf(tokenFile, "<ID, %s> ", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <ID> Lexeme %s found\n", line_count, yytext);

	if (st.lookup(temp) == nullptr)	{
		st.insert(temp, "ID");
		st.printAllScope_(logFile);
	}
	else {
		fprintf(logFile, " \n%s already exists in current ScopeTable\n", temp.c_str());
	} */

	string temp(yytext);
	SymbolInfo* apiId = new SymbolInfo(temp, "ID");

	yylval.syminfo = (YYSTYPE) apiId;
	return ID;
}

{STRING} {
	/* string temp = processString(yytext);
	fprintf(tokenFile, "<STRING, %s> ", temp.c_str());
	fprintf(logFile, "\nLine no %d: Token <STRING> Lexeme %s found", line_count, yytext);
	fprintf(logFile, " --> <STRING, %s>\n", temp.c_str());
	countLine(yytext); */
}

{TOO_MANY_DECIMAL_POINTS_ERROR} {
	/* fprintf(logFile, "\nError at line no %d: ", line_count);
	fprintf(logFile, "Too many decimal point error for character sequence like %s\n", yytext);
	error_count++; */
}

{ILL_FORMED_NUM_ERROR} {
	/* fprintf(logFile, "\nError at line no %d: ", line_count);
	fprintf(logFile, "Ill formed number such as %s\n", yytext);
	error_count++; */
}

{INVALID_IDENTIFIER_ERROR} {
	/* fprintf(logFile, "\nError at line no %d: ", line_count);
	fprintf(logFile, "Invalid Suffix on numeric constant or invalid prefix on identifier for character sequence like %s\n", yytext);
	error_count++; */
}

{EMPTY_CHAR_ERROR} {
	/* fprintf(logFile, "\nError at line no %d: ", line_count);
	fprintf(logFile, "Empty character constant %s\n", yytext);
	error_count++; */
}

{MULTI_CHAR_ERROR} {
	/* fprintf(logFile, "\nError at line no %d: ", line_count);
	fprintf(logFile, "Multi character constant error for character sequence like %s\n", yytext);
	error_count++; */
}

{UNFINISHED_CHAR_ERROR} {
	/* fprintf(logFile, "\nError at line no %d: ", line_count);
	fprintf(logFile, "Unfinished character such as %s\n", yytext);
	error_count++; */
}

{UNFINISHED_COMMENT} {
	/* fprintf(logFile, "\nError at line no %d: ", line_count);
	fprintf(logFile, "Unfinished comment at %s\n", yytext);
	error_count++;
	countLine(yytext); */
}

{UNFINISHED_STRING} {
	/* fprintf(logFile, "\nError at line no %d: ", line_count);
	fprintf(logFile, "Unfinished string at %s\n", yytext);
	error_count++;
	countLine(yytext); */
}

. {
	/* fprintf(logFile, "\nError at line no %d: ", line_count);
	fprintf(logFile, "Unrecognized character at %s\n", yytext);
	error_count++; */
}

%%
