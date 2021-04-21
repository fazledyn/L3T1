%{

#include "bits/stdc++.h"
#include "lib/SymbolTable.h"
#include "lib/Parameter.h"
#include "lib/util.h"

#define yydebug 1


SymbolTable st(30);
FILE *inputFile, *logFile, *errorFile;

extern FILE* yyin;

int lineCount = 1;
int errorCount = 0;

int cacheParamLine = -1;
int cacheReturnTypeLine = -1;

int yyparse(void);
int yylex(void);


void yyerror(const char* str) {
	fprintf(errorFile, "Syntax error at line: %d : \"%s\" \n", lineCount, str);
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


%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

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
					string funcType = $1->getName();
					string funcName = $2->getName();
					vector<string> paramTypeList = extractParameterType($4->getName());

					SymbolInfo* currFunc = st.lookup(funcName);

					if (currFunc != nullptr)	//	 Already declared
					{
						errorCount++;
						string msg = "Multiple declaration of function '" + funcName + "'";
						printError(errorFile, msg, cacheParamLine);
					}
					else		//	Is not declared yet
					{
						vector<Parameter> paramList;
						for (string paramType: paramTypeList) {	
							paramList.push_back(Parameter(" ", paramType));
						}

						SymbolInfo temp;
						temp.setAsFunction(funcName, funcType, paramList);
						temp.setDefined(false);

						st.insertSymbolInfo(temp);
					}

					st.printAllScope();

					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "(" + $4->getName() + ");", "func_declaration");
					printLog(logFile, "func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON", $$->getName(), lineCount);
				}
                | type_specifier ID LPAREN RPAREN SEMICOLON
				{
					string funcType = $1->getName();
					string funcName = $2->getName();

					SymbolInfo* currFunc = st.lookup(funcName);

					if (currFunc != nullptr)	//	 Already declared
					{
						errorCount++;
						string msg = "Multiple declaration of function '" + funcName + "'";
						printError(errorFile, msg, cacheParamLine);
					}
					else		//	Is not declared yet
					{
						vector<Parameter> paramList;

						SymbolInfo temp;
						temp.setAsFunction(funcName, funcType, paramList);
						temp.setDefined(false);

						st.insertSymbolInfo(temp);
					}

					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "();", "func_declaration");
					printLog(logFile, "func_declaration: type_specifier ID LPAREN RPAREN SEMICOLON", $$->getName(), lineCount);
				}
            ;


func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement
				{
					string funcType = $1->getName();
					string funcName = $2->getName();
					vector<Parameter> paramList = extractParameters($4->getName());
					
					SymbolInfo* currFunc = st.lookup(funcName);

					if (currFunc != nullptr) // Function is declared
					{
						if (currFunc->isDefined()) // Declared and Defined
						{
							errorCount++;
							string msg = "Re-definition of function '" + funcName + "'";
							printError(errorFile, msg, lineCount);
						}
						else	// Declared, but not defined
						{
							bool definitionIsConsistent = true;

							int declaredParamSize = currFunc->getParamList().size();
							int  definedParamSize = paramList.size();

							if (declaredParamSize != definedParamSize)	//	ERROR - ParamList size doesnt match
							{
								definitionIsConsistent = false;
								errorCount++;
								printError(errorFile, "Number of parameters isn't consistent with declaration", cacheParamLine);
							}

							string declaredType = currFunc->getType();

							if (declaredType != funcType)		//	ERROR - Return type doesn't match
							{
								definitionIsConsistent = false;
								errorCount++;
								printError(errorFile, "Function return type doesn't match with declaration", cacheReturnTypeLine);	
							}

							vector<Parameter> declaredParamList = currFunc->getParamList();
							
							if (declaredParamSize != 0)
							{
								for (int i=0; i < definedParamSize; i++)
								{
									string declaredType = declaredParamList[i].type;
									string currentType = paramList[i].type;

									if (declaredType != currentType)	//	ERROR - Type mismatch in function parameter
									{
										definitionIsConsistent = false;
										errorCount++;
										string msg = "Type mismatch of function parameter '" + paramList[i].name + "'";
										printError(errorFile, msg, cacheParamLine);
									}
								}
							}

							if (definitionIsConsistent)
							{
								st.remove(funcName);

								SymbolInfo temp;
								temp.setAsFunction(funcName, funcType, paramList);
								temp.setDefined(true);
								st.insertSymbolInfo(temp);
							}
						}
					}
					else	// The Function isn't even declared.
					{
						SymbolInfo temp;
						temp.setAsFunction(funcName, funcType, paramList);
						temp.setDefined(true);
						st.insertSymbolInfo(temp);
					}

					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "(" + $4->getName() + ")" + $6->getName(), "func_definition");
					printLog(logFile, "func_definition: type_specifier ID LPAREN parameter_list RPAREN compound_statement", $$->getName(), lineCount);
				}
				| type_specifier ID LPAREN RPAREN compound_statement
				{
					string funcType = $1->getName();
					string funcName = $2->getName();
					
					SymbolInfo* currFunc = st.lookup(funcName);
				
					if (currFunc != nullptr) // Function is declared
					{
						if (currFunc->isDefined()) // Declared and Defined
						{
							errorCount++;
							string msg = "Re-definition of function '" + funcName + "'";
							printError(errorFile, msg, lineCount);
						}
						else	// Declared, but not defined
						{
							bool definitionIsConsistent = true;

							int declaredParamSize = currFunc->getParamList().size();
							int  definedParamSize = 0;

							if (declaredParamSize != definedParamSize)	//	ERROR - ParamList size doesnt match
							{
								definitionIsConsistent = false;
								errorCount++;
								printError(errorFile, "Number of parameters isn't consistent with declaration", cacheReturnTypeLine);
							}

							string declaredType = currFunc->getType();

							if (declaredType != funcType)		//	ERROR - Return type doesn't match
							{
								definitionIsConsistent = false;
								errorCount++;
								printError(errorFile, "Function return type doesn't match with declaration", cacheReturnTypeLine);	
							}

							if (definitionIsConsistent)
							{
								st.remove(funcName);

								SymbolInfo temp;
								vector<Parameter> paramList;

								temp.setAsFunction(funcName, funcType, paramList);
								temp.setDefined(true);
								st.insertSymbolInfo(temp);
							}
						}
					}
					else	// The Function isn't even declared.
					{
						SymbolInfo temp;
						vector<Parameter> paramList;

						temp.setAsFunction(funcName, funcType, paramList);
						temp.setDefined(true);
						st.insertSymbolInfo(temp);
					}

					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "()" + $5->getName(), "func_definition");
					printLog(logFile, "func_definition: type_specifier ID LPAREN RPAREN compound_statement", $$->getName(), lineCount);
				}
 			;


parameter_list  : parameter_list COMMA type_specifier ID
				{
					cacheParamLine = lineCount;
					//	Caching function line no for error reporting .....
					$$ = new SymbolInfo($1->getName() + "," + $3->getName() + " " + $4->getName(), "parameter_list");
					printLog(logFile, "parameter_list: parameter_list COMMA type_specifier ID", $$->getName(), lineCount);
				}
				| parameter_list COMMA type_specifier
				{
					cacheParamLine = lineCount;
					//	Caching function line no for error reporting .....
					$$ = new SymbolInfo($1->getName() + "," + $3->getName(), "parameter_list");
					printLog(logFile, "parameter_list: parameter_list COMMA type_specifier", $$->getName(), lineCount);
				}
				| type_specifier ID
				{
					cacheParamLine = lineCount;
					//	Caching function line no for error reporting .....
					$$ = new SymbolInfo($1->getName() + " " + $2->getName(), "parameter_list");
					printLog(logFile, "parameter_list: type_specifier ID", $$->getName(), lineCount);
				}
				| type_specifier
				{
					cacheParamLine = lineCount;
					//	Caching function line no for error reporting .....
					$$ = $1;
					printLog(logFile, "parameter_list: type_specifier", $$->getName(), lineCount);
				}
			;


compound_statement 	: LCURL statements RCURL
					{
						$$ = new SymbolInfo("{\n"+ $2->getName() + "}", "compound_statement");
						printLog(logFile, "compound_statement: LCURL statements RCURL", $$->getName(), lineCount);
					}
				    | LCURL RCURL
					{
						$$ = new SymbolInfo("{}", "compound_statement");
						printLog(logFile, "compound_statement: LCURL RCURL", $$->getName(), lineCount);
					}
				;


var_declaration : type_specifier declaration_list SEMICOLON
				{
					string varName = $2->getName();
					string varType = $1->getName();

					//	ERROR REPORTING - Void type variable
					if (varType == "void")
					{
						errorCount++;
						printError(errorFile, "Variable type can't be void", lineCount);
					} // ERROR DONE
					else
					{
						vector<string> strList = splitString(varName, ',');
						for (string current: strList)
						{
							SymbolInfo temp;

							if ( isArray(current) )
							{
								int arraySize = extractArraySize(current);
								string arrayName = extractArrayName(current);

								temp.setAsArray(arrayName, varType, arraySize);
							}
							else
							{
								temp = SymbolInfo(current, varType);
							}

							//	ERROR REPORTING - Multiple declaration of variable
							if ( !st.insertSymbolInfo(temp) ) {
								errorCount++;
								string msg = "Multiple declaration of variable '" + temp.getName() + "'";
								printError(errorFile, msg, lineCount);
							} // ERROR DONE

						}
					}

					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + ";", "var_declaration");
					printLog(logFile, "var_declaration: type_specifier declaration_list SEMICOLON", $$->getName(), lineCount);
				}
			;


type_specifier 	: INT
				{
					cacheReturnTypeLine = lineCount;
					// Caching function return type line here ...
					$$ = new SymbolInfo("int", "int");
					printLog(logFile, "type_specifier: INT", $$->getName(), lineCount);
				}
 				| FLOAT
				{
					cacheReturnTypeLine = lineCount;
					// Caching function return type line here ...
					$$ = new SymbolInfo("float", "int");
					printLog(logFile, "type_specifier: FLOAT", $$->getName(), lineCount);
				}
		 		| VOID
				{
					cacheReturnTypeLine = lineCount;
					// Caching function return type line here ...
					$$ = new SymbolInfo("void", "void");
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
			| compound_statement
			{
				$$ = $1;
				printLog(logFile, "statement: compound_statement", $$->getName(), lineCount);
			}
			| FOR LPAREN expression_statement expression_statement expression RPAREN statement
			{
				$$ = new SymbolInfo("for(" + $3->getName() + $4->getName() + $5->getName() + ")" + $5->getName(),	"statement");
				printLog(logFile, "statement: IF LPAREN expression_statement expression_statement expression RPAREN statement", $$->getName(), lineCount);
			}
			| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE
			{
				$$ = new SymbolInfo("if(" + $3->getName() + ")" + $5->getName(),	"statement");
				printLog(logFile, "statement: IF LPAREN expression RPAREN statement", $$->getName(), lineCount);
			}
			| IF LPAREN expression RPAREN statement ELSE statement
			{
				$$ = new SymbolInfo("if(" + $3->getName() + ")" + $5->getName() + "else" + $7->getName(),	"statement");
				printLog(logFile, "statement: IF LPAREN expression RPAREN statement ELSE statement", $$->getName(), lineCount);
			}
			| WHILE LPAREN expression RPAREN statement
			{
				$$ = new SymbolInfo("while(" + $3->getName() + ")" + $5->getName(),	"statement");
				printLog(logFile, "statement: WHILE LPAREN expression RPAREN statement", $$->getName(), lineCount);
			}
			| PRINTLN LPAREN ID RPAREN SEMICOLON
			{
				$$ = new SymbolInfo("printf(" + $3->getName() + ");",	"statement");
				printLog(logFile, "statement: PRINTLN LPAREN ID RPAREN SEMICOLON", $$->getName(), lineCount);
			}
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
				// $$ = yylval.syminfo;
				$$ = $1;
				printLog(logFile, "variable: ID", $$->getName(), lineCount);
			}
			| ID LTHIRD expression RTHIRD
			{
				//	ERROR REPORTING - Non-integer array index
				if ($3->getType() != "int") {
					errorCount++;
					printError(errorFile, "Non-integer array index of '" + $1->getName() + "'", lineCount);
				}
				//	ERROR REPORTING END

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
				string leftVarName = $1->getName();
				string _returnType = "expression";

				if ( isArray(leftVarName) )
					leftVarName = extractArrayName(leftVarName);

				SymbolInfo* leftVar = st.lookup(leftVarName);
				//	ERROR REPORTING - Multiple declaration of variable
				if (leftVar == nullptr)
				{
					errorCount++;
					printError(errorFile, "Undeclared variable '" + leftVarName + "'", lineCount);
				}	//	ERROR REPORTING DONE
				else
				{
					_returnType = leftVar->getType();
					//	ERROR REPORTING - Type Mismatch of Variable
					if (leftVar->getType() != $3->getType()) {

						//	ERROR REPORTING - Type Mismatch of Variable
						if ($3->getType() == "void")
						{
							errorCount++;
							printError(errorFile, "Void type of value can't be assigned to '" + $1->getName() + "'", lineCount);
						}	//	ERROR REPORTING DONE
						else
						{
							errorCount++;
							printError(errorFile, "Type mismatch of variable '" + $1->getName() + "'", lineCount);
						}
					}
					//	ERROR DONE
				}

				$$ = new SymbolInfo($1->getName() + "=" + $3->getName(), _returnType);
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
						//	The result of RELOP and LOGICOP should be "int""
						$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(),	"int");
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
					//	The result of RELOP and LOGICOP should be "int"
					$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(),	"int");
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
			//	ERROR REPORTING - Non-integer operand on MOD (%)
			if (($2->getName() == "%") && ($1->getType()!="int" || $3->getType()!="int")) {
				errorCount++;
				printError(errorFile, "Non-integer operand on modulus operator", lineCount);
			}
			// ERROR REPORTING END

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

	cout << "\nTotal Errors: " << errorCount << endl;
	fprintf(errorFile, "Total Errors: %d", errorCount);

	fclose(logFile);
	fclose(errorFile);

	return 0;
}
