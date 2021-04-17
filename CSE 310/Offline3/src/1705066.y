%{

#include "bits/stdc++.h"
#include "lib/SymbolTable.h"

#define yydebug 1


SymbolTable st(30);
FILE *inputFile, *logFile, *errorFile;

extern FILE* yyin;

int lineCount = 1;
int parserError = 0;

int yyparse(void);
int yylex(void);

void yyerror(const char* s) {
	fprintf(errorFile, "Some error \"%s\" at line %d", s, lineCount);
}

%}

%define parse.error verbose

%union {
	SymbolInfo* syminfo;
}

%token BREAK CASE CONTINUE DEFAULT RETURN SWITCH VOID CHAR DOUBLE FLOAT INT DO WHILE FOR IF ELSE
%token ADDOP MULOP INCOP DECOP RELOP ASSIGNOP LOGICOP NOT LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD
%token COMMA SEMICOLON PRINTLN

%token <syminfo> ID
%token <syminfo> CONST_INT
%token <syminfo> CONST_FLOAT
%token <syminfo> CONST_CHAR

%type <syminfo> start program unit var_declaration variable type_specifier declaration_list
%type <syminfo> expression expression_statement


%%

start	: program
		{
			$$ = $1;
		}
	;

program : program unit
		{
			fprintf(logFile, "At line no: %d program: program unit", lineCount);
			$$ = new SymbolInfo($1->getName() + " " + $2->getName(), "program: program unit");
			fprintf(logFile, "\n\n%s\n\n", $$->getName().c_str());
		}
		| unit
		{
			fprintf(logFile, "At line no: %d program: unit", lineCount);
			$$ = $1;
			fprintf(logFile, "\n\n%s\n\n", $$->getName().c_str());
		}
	;

unit :	var_declaration
		{
			fprintf(logFile, "At line no: %d unit: var_declaration", lineCount);
			$$ = $1;
			fprintf(logFile, "\n\n%s\n\n", $$->getName().c_str());
		}
    	/* | func_declaration
		{
			fprintf(logFile, "Line no %d -> unit: func_declaration \n", lineCount);
			$$ = $1;
		}
		| func_definition
		{
			fprintf(logFile, "Line no %d -> unit: func_definition \n", lineCount);
			$$ = $1;
		} */
    ;

/* func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
                | type_specifier ID LPAREN RPAREN SEMICOLON
                ;


func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement
		| type_specifier ID LPAREN RPAREN compound_statement
 		;


parameter_list  : parameter_list COMMA type_specifier ID
		| parameter_list COMMA type_specifier
 		| type_specifier ID
		| type_specifier
 		;


compound_statement : LCURL statements RCURL
 		    | LCURL RCURL
 		    ; */


var_declaration : type_specifier declaration_list SEMICOLON
				{
					fprintf(logFile, "At line no: %d var_declaration : type_specifier declaration_list SEMICOLON", lineCount);
					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + ";", "var_declaration");
					fprintf(logFile, "\n\n%s\n\n", $$->getName().c_str());
				}
				;


type_specifier	: INT
				{
					fprintf(logFile, "At line no: %d type_specifier : INT", lineCount);
					$$ = new SymbolInfo("int", "type_specifier");
					fprintf(logFile, "\n\n%s\n\n", $$->getName().c_str());
				}
 				| FLOAT
				{
					fprintf(logFile, "At line no: %d type_specifier : FLOAT", lineCount);
					$$ = new SymbolInfo("float", "type_specifier");
					fprintf(logFile, "\n\n%s\n\n", $$->getName().c_str());
				}
		 		| VOID
				{
					fprintf(logFile, "At line no: %d type_specifier : VOID", lineCount);
					$$ = new SymbolInfo("void", "type_specifier");
					fprintf(logFile, "\n\n%s\n\n", $$->getName().c_str());
				}
		 		;

declaration_list : declaration_list COMMA ID
				{
					fprintf(logFile, "At line no: %d declaration_list : declaration_list COMMA ID", lineCount);
					$$ = new SymbolInfo($1->getName() + "," + $3->getName(), "declaration_list");
					fprintf(logFile, "\n\n%s\n\n", $$->getName().c_str());
				}
		 		 //| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
		 		 |
				 ID
				{
					fprintf(logFile, "At line no: %d declaration_list : ID", lineCount);
					$$ = new SymbolInfo(yylval.syminfo->getName(), "variable");
					fprintf(logFile, "\n\n%s\n\n", $$->getName().c_str());
				}
		 		 //| ID LTHIRD CONST_INT RTHIRD
		 		 ;


/* statements : statement
		   | statements statement
		   ;

statement : var_declaration
		  | expression_statement
		  | compound_statement
		  | FOR LPAREN expression_statement expression_statement expression RPAREN statement
		  | IF LPAREN expression RPAREN statement
		  | IF LPAREN expression RPAREN statement ELSE statement
		  | WHILE LPAREN expression RPAREN statement
		  | PRINTLN LPAREN ID RPAREN SEMICOLON
		  | RETURN expression SEMICOLON
		  ; */

expression_statement : SEMICOLON
					{
						$$ = new SymbolInfo(";", "SEMICOLON");
					}
					/* | expression SEMICOLON
					{
						string temp = $1->getName() + ";";
						$$ = new SymbolInfo(temp, "expression SEMICOLON");
					}
					; */

variable : ID
		{
			fprintf(logFile, "At line no: %d variable: ID", lineCount);
			$$ = new SymbolInfo(yylval.syminfo->getName(), "variable");
			fprintf(logFile, "\n\n%s\n\n", $$->getName().c-str());
		}
		 //| ID LTHIRD expression RTHIRD
		 ;

/* expression :// logic_expression
		    //|
			variable ASSIGNOP logic_expression
			{
				$$ = new SymbolInfo($1->getName() + "=" + $3->getName(), "expression");
			}
		    ; */

/* logic_expression : rel_expression
				 | rel_expression LOGICOP rel_expression
				 ;

rel_expression	: simple_expression
				| simple_expression RELOP simple_expression
				;

simple_expression : term
				  | simple_expression ADDOP term
				  ;

term :	unary_expression
     |  term MULOP unary_expression
     ;

unary_expression : ADDOP unary_expression
				 | NOT unary_expression
				 | factor
				 ;

factor	: variable
		| ID LPAREN argument_list RPAREN
		| LPAREN expression RPAREN
		| CONST_INT
		| CONST_FLOAT
		| variable INCOP
		| variable DECOP
		;

argument_list : arguments
			  |
			  ;

arguments : arguments COMMA logic_expression
	      | logic_expression
	      ; */


%%
int main(int argc,char *argv[])
{

    inputFile = fopen(argv[1], "r");

	if(inputFile == nullptr) {
		printf("Cannot Open Input File.\n");
		exit(1);
	}

    logFile = fopen("log.txt", "w");
    errorFile = fopen("error.txt", "w");

	yyin = inputFile;
	yyparse();

	st.printAllScope_(logFile);
	fprintf(errorFile, "\n\nTotal Error: %d", parserError);

	fclose(logFile);
	fclose(errorFile);

	return 0;
}
