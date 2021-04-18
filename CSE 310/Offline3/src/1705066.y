%{

#include "bits/stdc++.h"
#include "lib/SymbolTable.h"
#include "lib/util.h"

#define yydebug 1


SymbolTable st(30);
FILE *inputFile, *logFile, *errorFile;

extern FILE* yyin;

int lineCount = 1;
int errorCount = 0;

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
%token INCOP DECOP ASSIGNOP NOT LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD
%token COMMA SEMICOLON PRINTLN

%token <syminfo> ID
%token <syminfo> CONST_INT
%token <syminfo> CONST_FLOAT
%token <syminfo> CONST_CHAR

%token <syminfo> ADDOP MULOP RELOP LOGICOP

%type <syminfo> start program unit var_declaration variable type_specifier declaration_list
%type <syminfo> expression_statement func_declaration parameter_list func_definition
%type <syminfo> compound_statement statements unary_expression factor statement arguments
%type <syminfo> expression logic_expression simple_expression rel_expression term argument_list


%%

start	: program
		{
			$$ = $1;
		}
	;

program : program unit
		{
			$$ = new SymbolInfo($1->getName() + "\n" + $2->getName(), "program");
			printLog(logFile, "program: program unit", $$->getName(), lineCount);
		}
		| unit
		{
			$$ = $1;
			printLog(logFile, "program: unit", $$->getName(), lineCount);
		}
	;

unit :	var_declaration
		{
			$$ = $1;
			printLog(logFile, "unit: var_declaration", $$->getName(), lineCount);
		}
    	| func_declaration
		{
			$$ = $1;
			printLog(logFile, "unit: func_declaration", $$->getName(), lineCount);
		}
		| func_definition
		{
			$$ = $1;
			printLog(logFile, "unit: func_definition", $$->getName(), lineCount);
		}
    ;


func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
				{
					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "(" + $4->getName() + ");", "func_declaration");
					printLog(logFile, "func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON", $$->getName(), lineCount);
				}
                | type_specifier ID LPAREN RPAREN SEMICOLON
				{
					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "();", "func_declaration");
					printLog(logFile, "func_declaration: type_specifier ID LPAREN RPAREN SEMICOLON", $$->getName(), lineCount);
				}
            ;


func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement
				{
					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "(" + $4->getName() + ")" + $6->getName(), "func_definition");
					printLog(logFile, "func_definition: type_specifier ID LPAREN parameter_list RPAREN compound_statement", $$->getName(), lineCount);
				}
				| type_specifier ID LPAREN RPAREN compound_statement
				{
					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "()" + $5->getName(), "func_definition"); 
					printLog(logFile, "func_definition: type_specifier ID LPAREN RPAREN compound_statement", $$->getName(), lineCount);
				}
 			;


parameter_list  : parameter_list COMMA type_specifier ID
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName() + " " + $4->getName(), "parameter_list");
					printLog(logFile, "parameter_list: parameter_list COMMA type_specifier ID", $$->getName(), lineCount);
				}
				| parameter_list COMMA type_specifier
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName(), "parameter_list");
					printLog(logFile, "parameter_list: parameter_list COMMA type_specifier", $$->getName(), lineCount);
				}
				| type_specifier ID
				{
					$$ = new SymbolInfo($1->getName() + " " + $2->getName(), "parameter_list");
					printLog(logFile, "parameter_list: type_specifier ID", $$->getName(), lineCount);
				}
				| type_specifier
				{
					$$ = $1;
					printLog(logFile, "parameter_list: type_specifier", $$->getName(), lineCount);
				}
			;


compound_statement 	: LCURL statements RCURL
					{
						$$ = new SymbolInfo("{\n"+ $2->getName() + "}", "compound_statement");
						printLog(logFile, "compound_statement: LCURL statements RCURL", $$->getName(), lineCount);
					}
				    //| LCURL RCURL
				;


var_declaration : type_specifier declaration_list SEMICOLON
				{
					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + ";", "var_declaration");
					printLog(logFile, "var_declaration: type_specifier declaration_list SEMICOLON", $$->getName(), lineCount);
				}
			;


type_specifier	: INT
				{
					$$ = new SymbolInfo("int", "type_specifier");
					printLog(logFile, "type_specifier: INT", $$->getName(), lineCount);
				}
 				| FLOAT
				{
					$$ = new SymbolInfo("float", "type_specifier");
					printLog(logFile, "type_specifier: FLOAT", $$->getName(), lineCount);
				}
		 		| VOID
				{
					$$ = new SymbolInfo("void", "type_specifier");
					printLog(logFile, "type_specifier: VOID", $$->getName(), lineCount);
				}
			;


declaration_list : declaration_list COMMA ID
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName(), "declaration_list");
					printLog(logFile, "declaration_list: declaration_list COMMA ID", $$->getName(), lineCount);
				}
		 		| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName() + "[" + $5->getName() + "]",	"declaration_list");
					printLog(logFile, "declaration_list: declaration_list COMMA ID LTHIRD CONST_INT RTHIRD", $$->getName(), lineCount);	
				}
				| ID
				{
					$$ = $1;
					printLog(logFile, "declaration_list: ID", $$->getName(), lineCount);
				}
		 		| ID LTHIRD CONST_INT RTHIRD
				{
					$$ = new SymbolInfo($1->getName() + "[" + $3->getName() + "]",	"declaration_list");
					printLog(logFile, "declaration_list: ID LTHIRD CONST_INT RTHIRD", $$->getName(), lineCount);	
				}
			;


statements : statement
			{
				$$ = $1;
				printLog(logFile, "statements: statement", $$->getName(), lineCount);
			}
		   | statements statement
		   {
			   $$ = new SymbolInfo($1->getName() + $2->getName() + "\n", "statements");
			   printLog(logFile, "statements: statements statement", $$->getName(), lineCount);
		   }
		;


statement : var_declaration
			{
				$$ = $1;
				printLog(logFile, "statement: var_declaration", $$->getName(), lineCount);
			}
			| expression_statement
			{
				$$ = $1;
				printLog(logFile, "statement: expression_statement", $$->getName(), lineCount);
			}
		//   | compound_statement
		//   | FOR LPAREN expression_statement expression_statement expression RPAREN statement
		//   | IF LPAREN expression RPAREN statement
		//   | IF LPAREN expression RPAREN statement ELSE statement
		//   | WHILE LPAREN expression RPAREN statement
		//   | PRINTLN LPAREN ID RPAREN SEMICOLON 
			| RETURN expression SEMICOLON
			{
				$$ = new SymbolInfo("return " + $2->getName() + ";", "statement");
				printLog(logFile, "statement: RETURN expression SEMICOLON", $$->getName(), lineCount);
			}
		;


expression_statement : SEMICOLON
					{
						$$ = new SymbolInfo(";", "SEMICOLON");
					}
					| expression SEMICOLON
					{
						$$ = new SymbolInfo($1->getName() + ";", "expression_statement");
						printLog(logFile, "expression_statement: expression SEMICOLON", $$->getName(), lineCount);
					}
				;


variable :	ID
			{
				$$ = yylval.syminfo;
				printLog(logFile, "variable: ID", $$->getName(), lineCount);
				//	printf("This is the thing: %s \n\n", yylval.syminfo->getName().c_str());
			}
			| ID LTHIRD expression RTHIRD
			{
				// error check
				if ($3->getType() != "CONST_INT") {
					errorCount++;
					printError(errorFile, "Non-integer array index", lineCount);
				}
				//	error check done

				$$ = new SymbolInfo($1->getName() + "[" + $3->getName() + "]",	"variable");
				printLog(logFile, "variable: ID LTHIRD expression RTHIRD", $$->getName(), lineCount);
			}
		;


expression: logic_expression
			{
				$$ = $1;
				printLog(logFile, "expression: logic_expression", $$->getName(), lineCount);
			}
		    | variable ASSIGNOP logic_expression
			{

				if ($1->getType() != $3->getType()) {
					errorCount++;
					printError(errorFile, "Type mismatch", lineCount);
				}

				$$ = new SymbolInfo($1->getName() + "=" + $3->getName(), "expression");
				printLog(logFile, "expression: variable ASSIGNOP logic_expression", $$->getName(), lineCount);
			}
		;

logic_expression :	rel_expression
					{
						$$ = $1;
						printLog(logFile, "logic_expression: rel_expression", $$->getName(), lineCount);
					}
					| rel_expression LOGICOP rel_expression
					{
						$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(),	"logic_expression");
						printLog(logFile, "logic_expression: rel_expression LOGICOP rel_expression", $$->getName(), lineCount);
					}
				;

rel_expression	: simple_expression
				{
					$$ = $1;
					printLog(logFile, "rel_expression: simple_expression", $$->getName(), lineCount);
				}
				| simple_expression RELOP simple_expression
				{
					$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(),	"rel_expression");
					printLog(logFile, "rel_expression: simple_expression RELOP simple_expression", $$->getName(), lineCount);
				}
				;

simple_expression :	term
					{
						$$ = $1;
						printLog(logFile, "simple_expression: term", $$->getName(), lineCount);
					}
					| simple_expression ADDOP term
					{
						$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(), "simple_expression");
						printLog(logFile, "simple_expression: simple_expression ADDOP term", $$->getName(), lineCount);
					}
				;

term :	unary_expression
		{
			$$ = $1;
			printLog(logFile, "term: unary_expression", $$->getName(), lineCount);
		}
		|  term MULOP unary_expression
		{
			//	error check
			if (($2->getName() == "%") && ($1->getType()!="CONST_INT" || $3->getType()!="CONST_INT")) {
				errorCount++;
				printError(errorFile, "Non-integer operand on modulus operator", lineCount);
			}
			// check done

			$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(), "term");
			printLog(logFile, "term: term MULOP unary_expression", $$->getName(), lineCount);
		}
	;

unary_expression: ADDOP unary_expression
				{
					$$ = new SymbolInfo($1->getName() + $2->getName(),	"unary_expression");
					printLog(logFile, "unary_expression: ADDOP unary_expression", $$->getName(), lineCount);
				}
				| NOT unary_expression
				{
					$$ = new SymbolInfo("!" + $2->getName(),	"unary_expression");
					printLog(logFile, "unary_expression: NOT unary_expression", $$->getName(), lineCount);	
				}
				| factor
				{
					$$ = $1;
					printLog(logFile, "unary_expression: factor", $$->getName(), lineCount);
				}
			;

factor: variable
		{
			$$ = $1;
			printLog(logFile, "factor: variable", $$->getName(), lineCount);
		}
		| ID LPAREN argument_list RPAREN
		{
			$$ = new SymbolInfo($1->getName() + "(" + $3->getName() + ")",	"factor");
			printLog(logFile, "factor: ID LPAREN argument_list RPAREN", $$->getName(), lineCount);
		}
		| LPAREN expression RPAREN
		{
			$$ = new SymbolInfo("(" + $2->getName() + ")",	"factor");
			printLog(logFile, "factor: LPAREN expression RPAREN", $$->getName(), lineCount);
		}
		| CONST_INT
		{
			$$ = yylval.syminfo;
			printLog(logFile, "factor: CONST_INT", $$->getName(), lineCount);
		}
		| CONST_FLOAT
		{
			$$ = yylval.syminfo;
			printLog(logFile, "factor: CONST_FLOAT", $$->getName(), lineCount);	
		}
		| variable INCOP
		{
			$$ = new SymbolInfo($1->getName() + "++",	"factor");
			printLog(logFile, "factor: variable INCOP", $$->getName(), lineCount);
		}
		| variable DECOP
		{
			$$ = new SymbolInfo($1->getName() + "--",	"factor");
			printLog(logFile, "factor: variable DECOP", $$->getName(), lineCount);	
		}
	;


argument_list :	arguments
				{
					$$ = $1;
					printLog(logFile, "argument_list: arguments", $$->getName(), lineCount);
				}
				|
				{
					// nothing
				}
			;


arguments : arguments COMMA logic_expression
			{
				$$ = new SymbolInfo($1->getName() + "," + $3->getName(),	"arguments");
				printLog(logFile, "arguments: arguments COMMA logic_expression", $$->getName(), lineCount);
			}
			| logic_expression
			{
				$$ = $1;
				printLog(logFile, "arguments: logic_expression", $$->getName(), lineCount);
			}
		;


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

	fprintf(errorFile, "Total Errors: %d", errorCount);

	fclose(logFile);
	fclose(errorFile);

	return 0;
}
