%{

#include "bits/stdc++.h"
#include "lib/SymbolTable.h"
#include "lib/Parameter.h"
#include "lib/util.h"

#define yydebug 1
#define ERROR "error"


SymbolTable st(30);
FILE *inputFile, *logFile, *errorFile;

extern FILE* yyin;

int lineCount = 1;
int errorCount = 0;

bool inSingleStatementScope = false;

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
			printLog(logFile, "start : program", "", lineCount);
		}
	;

program : program unit
		{
			$$ = new SymbolInfo($1->getName() + "\n" + $2->getName(), "program");
			printLog(logFile, "program : program unit", $$->getName(), lineCount);
		}
		| unit
		{
			$$ = $1;
			printLog(logFile, "program : unit", $$->getName(), lineCount);
		}
	;

unit :	var_declaration
		{
			$$ = $1;
			printLog(logFile, "unit : var_declaration", $$->getName(), lineCount);
		}
    	| func_declaration
		{
			$$ = $1;
			printLog(logFile, "unit : func_declaration", $$->getName(), lineCount);
		}
		| func_definition
		{
			$$ = $1;
			printLog(logFile, "unit : func_definition", $$->getName(), lineCount);
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
						printError(errorFile, msg, lineCount);
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

					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "(" + $4->getName() + ");", "func_declaration");
					printLog(logFile, "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON", $$->getName(), lineCount);
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
						printError(errorFile, msg, lineCount);
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
					printLog(logFile, "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON", $$->getName(), lineCount);
				}
            ;


func_definition : type_specifier ID LPAREN parameter_list RPAREN 
				{
					string funcType = $1->getName();
					string funcName = $2->getName();
					vector<Parameter> paramList = extractParameters($4->getName());

					SymbolInfo* currFunc = st.lookup(funcName);
					
					if (currFunc != nullptr) // Function is declared
					{
						if (currFunc->isFunction())
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
									printError(errorFile, "Number of parameters isn't consistent with declaration", lineCount);
								}

								string declaredType = currFunc->getType();
								if (declaredType != funcType)		//	ERROR - Return type doesn't match
								{
									definitionIsConsistent = false;
									errorCount++;
									printError(errorFile, "Function return type doesn't match with declaration", lineCount);	
								}

								vector<Parameter> declaredParamList = currFunc->getParamList();
								
								if ((declaredParamSize != 0) && (declaredParamSize == definedParamSize))
								{
									for (int i=0; i < declaredParamSize; i++)
									{
										string declaredType = declaredParamList[i].type;
										string currentType = paramList[i].type;

										if (declaredType != currentType)	//	ERROR - Type mismatch in function parameter
										{
											definitionIsConsistent = false;
											errorCount++;
											string msg = "Type mismatch of function parameter '" + paramList[i].name + "'";
											printError(errorFile, msg, lineCount);
										}
									}
								}

								st.remove(funcName);

								SymbolInfo temp;
								temp.setAsFunction(funcName, funcType, paramList);
								temp.setDefined(true);

								st.insertSymbolInfo(temp);

								st.enterScope();

								bool inserted = false;
								for (int i=0; i < paramList.size(); i++)
								{
									inserted = st.insert(paramList[i].name, paramList[i].type);

									if (!inserted)
									{
										errorCount++;
										string msg = "Multiple declaration of variable '" + paramList[i].name + "' in parameter";
										printError(errorFile, msg, lineCount);
									}
								}

							}
						}
						else
						{
							st.enterScope();

							errorCount++;
							string msg = "Identifier '" + currFunc->getName() + "' is not a function.";
							printError(errorFile, msg, lineCount);
						}						
					}
					else	// The Function isn't even declared.
					{
						SymbolInfo temp;
						temp.setAsFunction(funcName, funcType, paramList);
						temp.setDefined(true);
						st.insertSymbolInfo(temp);
						
						st.enterScope();

						bool inserted = false;

						for (int i=0; i < paramList.size(); i++)
						{
							inserted = st.insert(paramList[i].name, paramList[i].type);
							if (!inserted)
							{
								errorCount++;
								string msg = "Multiple declaration of variable '" + paramList[i].name + "' in parameter";
								printError(errorFile, msg, lineCount);
							}
						}
					}
				}
				compound_statement
				{
					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "(" + $4->getName() + ")" + $7->getName() + "\n", "func_definition");
					printLog(logFile, "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement", $$->getName(), lineCount);
				}
				| type_specifier ID LPAREN RPAREN
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
								printError(errorFile, "Number of parameters isn't consistent with declaration", lineCount);
							}

							string declaredType = currFunc->getType();

							if (declaredType != funcType)		//	ERROR - Return type doesn't match
							{
								definitionIsConsistent = false;
								errorCount++;
								printError(errorFile, "Function return type doesn't match with declaration", lineCount);	
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
					st.enterScope();
				}
				compound_statement
				{
					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "()" + $6->getName() + "\n", "func_definition");
					printLog(logFile, "func_definition : type_specifier ID LPAREN RPAREN compound_statement", $$->getName(), lineCount);
				}
 			;


parameter_list  : parameter_list COMMA type_specifier ID
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName() + " " + $4->getName(), "parameter_list");
					printLog(logFile, "parameter_list : parameter_list COMMA type_specifier ID", $$->getName(), lineCount);
				}
				| parameter_list COMMA type_specifier
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName(), "parameter_list");
					printLog(logFile, "parameter_list : parameter_list COMMA type_specifier", $$->getName(), lineCount);
				}
				| type_specifier ID
				{
					$$ = new SymbolInfo($1->getName() + " " + $2->getName(), "parameter_list");
					printLog(logFile, "parameter_list : type_specifier ID", $$->getName(), lineCount);
				}
				| type_specifier
				{
					$$ = $1;
					printLog(logFile, "parameter_list : type_specifier", $$->getName(), lineCount);
				}
			;


compound_statement 	: LCURL statements RCURL
					{
						$$ = new SymbolInfo("{\n"+ $2->getName() + "\n}", "compound_statement");
						printLog(logFile, "compound_statement : LCURL statements RCURL", $$->getName(), lineCount);
						
						st.printAllScope_(logFile);

						if ( !inSingleStatementScope ){
							st.exitScope();
						}
					}
				    | LCURL RCURL
					{
						$$ = new SymbolInfo("{\n}", "compound_statement");
						printLog(logFile, "compound_statement : LCURL RCURL", $$->getName(), lineCount);
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
					printLog(logFile, "var_declaration : type_specifier declaration_list SEMICOLON", $$->getName(), lineCount);
				}
			;


type_specifier 	: INT
				{
					$$ = new SymbolInfo("int", "int");
					printLog(logFile, "type_specifier : INT", $$->getName(), lineCount);
				}
 				| FLOAT
				{
					$$ = new SymbolInfo("float", "int");
					printLog(logFile, "type_specifier : FLOAT", $$->getName(), lineCount);
				}
		 		| VOID
				{
					$$ = new SymbolInfo("void", "void");
					printLog(logFile, "type_specifier : VOID", $$->getName(), lineCount);
				}
			;


declaration_list : declaration_list COMMA ID
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName(), "declaration_list");
					printLog(logFile, "declaration_list : declaration_list COMMA ID", $$->getName(), lineCount);
				}
		 		| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName() + "[" + $5->getName() + "]",	"declaration_list");
					printLog(logFile, "declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD", $$->getName(), lineCount);
				}
				| ID
				{
					$$ = $1;
					printLog(logFile, "declaration_list : ID", $$->getName(), lineCount);
				}
		 		| ID LTHIRD CONST_INT RTHIRD
				{
					$$ = new SymbolInfo($1->getName() + "[" + $3->getName() + "]",	"declaration_list");
					printLog(logFile, "declaration_list : ID LTHIRD CONST_INT RTHIRD", $$->getName(), lineCount);
				}
			;


statements : statement
			{
				$$ = $1;
				printLog(logFile, "statements : statement", $$->getName(), lineCount);
			}
			| statements statement
			{
				$$ = new SymbolInfo($1->getName() + "\n" + $2->getName(), "statements");
				printLog(logFile, "statements : statements statement", $$->getName(), lineCount);
			}
		;


statement : var_declaration
			{
				$$ = $1;
				printLog(logFile, "statement : var_declaration", $$->getName(), lineCount);
			}
			| expression_statement
			{
				$$ = $1;
				printLog(logFile, "statement : expression_statement", $$->getName(), lineCount);
			}
			| {
				if ( !inSingleStatementScope ) {
					st.enterScope();
				}
			}
			compound_statement
			{
				$$ = $2;
				printLog(logFile, "statement : compound_statement", $$->getName(), lineCount);
			}
			| FOR LPAREN expression_statement expression_statement expression RPAREN 
				{
					st.enterScope();
					inSingleStatementScope = true;
				}
			statement
				{
					st.exitScope();
					inSingleStatementScope = false;
				}
			{
				$$ = new SymbolInfo("for(" + $3->getName() + $4->getName() + $5->getName() + ")" + $8->getName(),	"statement");
				printLog(logFile, "statement : IF LPAREN expression_statement expression_statement expression RPAREN statement", $$->getName(), lineCount);
			}
			| IF LPAREN expression RPAREN
				{
					st.enterScope();
					inSingleStatementScope = true;
				}
			statement
				{
					st.exitScope();
					inSingleStatementScope = false;
				}
			%prec LOWER_THAN_ELSE
			{
				$$ = new SymbolInfo("if(" + $3->getName() + ")" + $6->getName(),	"statement");
				printLog(logFile, "statement : IF LPAREN expression RPAREN statement", $$->getName(), lineCount);
			}
			| IF LPAREN expression RPAREN
				{
					st.enterScope();
					inSingleStatementScope = true;
				}
			statement
				{
					st.exitScope();
					inSingleStatementScope = false;
				}
			ELSE
				{
					st.enterScope();
					inSingleStatementScope = true;
				}
			statement
				{
					st.exitScope();
					inSingleStatementScope = false;
				}
			{
				$$ = new SymbolInfo("if(" + $3->getName() + ")" + $6->getName() + "else" + $10->getName(),	"statement");
				printLog(logFile, "statement : IF LPAREN expression RPAREN statement ELSE statement", $$->getName(), lineCount);
			}
			| WHILE LPAREN expression RPAREN
				{
					st.enterScope();
					inSingleStatementScope = true;
				}
			statement
				{
					st.exitScope();
					inSingleStatementScope = false;
				}
			{
				$$ = new SymbolInfo("while(" + $3->getName() + ")" + $6->getName(),	"statement");
				printLog(logFile, "statement : WHILE LPAREN expression RPAREN statement", $$->getName(), lineCount);
			}
			| PRINTLN LPAREN ID RPAREN SEMICOLON
			{
				$$ = new SymbolInfo("printf(" + $3->getName() + ");",	"statement");
				printLog(logFile, "statement : PRINTLN LPAREN ID RPAREN SEMICOLON", $$->getName(), lineCount);
			}
			| RETURN expression SEMICOLON
			{
				$$ = new SymbolInfo("return " + $2->getName() + ";", "statement");
				printLog(logFile, "statement : RETURN expression SEMICOLON", $$->getName(), lineCount);
			}
		;


expression_statement : SEMICOLON
					{
						$$ = new SymbolInfo(";", "SEMICOLON");
					}
					| expression SEMICOLON
					{
						$$ = new SymbolInfo($1->getName() + ";", "expression_statement");
						printLog(logFile, "expression_statement : expression SEMICOLON", $$->getName(), lineCount);
					}
				;


variable :	ID
			{
				string _returnType;
				SymbolInfo* currId = st.lookup($1->getName());
				
				if (currId == nullptr)
				{
					errorCount++;
					string msg = "Undeclared variable '" + $1->getName() + "' referred";
					printError(errorFile, msg, lineCount);
					$$ = new SymbolInfo($1->getName(), ERROR);
				}
				else
				{
					if (currId->isArray())
					{
						$$ = new SymbolInfo();
						$$->setAsArray(currId->getName(), ERROR, currId->getSize());
					}
					else
					{
						$$ = new SymbolInfo(currId->getName(), currId->getType());
					}
				}
				printLog(logFile, "variable : ID", $$->getName(), lineCount);
			}
			| ID LTHIRD expression RTHIRD
			{
				SymbolInfo* currId = st.lookup($1->getName());

				if (currId == nullptr)
				{
					errorCount++;
					string msg = "Undeclared variable '" + $1->getName() + "' referred";
					printError(errorFile, msg, lineCount);

					$$ = new SymbolInfo($1->getName() + "[" + $3->getName() + "]",	"error");
				}
				else
				{
					if ( currId->isArray() )	//		Array Type variable
					{	
						string _returnType = currId->getType();
						//	ERROR REPORTING - Non-integer array index
						if ($3->getType() != "int")
						{
							errorCount++;
							printError(errorFile, "Non-integer array index of '" + $1->getName() + "'", lineCount);
						}	//	ERROR REPORTING END

						$$ = new SymbolInfo($1->getName() + "[" + $3->getName() + "]", currId->getType());
					}
					else
					{
						errorCount++;
						string msg = "Type mismatch. Variable '" + currId->getName() + "' is not an array";
						printError(errorFile, msg, lineCount);

						$$ = new SymbolInfo($1->getName() + "[" + $3->getName() + "]",	"error");
					}
				}
				printLog(logFile, "variable : ID LTHIRD expression RTHIRD", $$->getName(), lineCount);
			}
		;


expression: logic_expression
			{
				$$ = $1;
				printLog(logFile, "expression : logic_expression", $$->getName(), lineCount);
			}
		    | variable ASSIGNOP logic_expression
			{
				SymbolInfo* leftVar  = $1;
				SymbolInfo* rightVar = $3;

				if (leftVar->getType() == rightVar->getType())
				{
					// ... all good
				}
				else
				{
					
					if (leftVar->getType() == ERROR || rightVar->getType() == ERROR)
					{
					
						if (leftVar->isArray() || rightVar->isArray())
						{
							string msg;
							
							if (leftVar->isArray())
								msg = "Type mismatch. Variable '" + leftVar->getName() + "' is an array";
							else if (rightVar->isArray())
								msg = "Type mismatch. Variable '" + rightVar->getName() + "' is an array";						
							
							errorCount++;
							printError(errorFile, msg, lineCount);
						}
					
					}
					else if (leftVar->getType() == "float" && rightVar->getType() == "int")
					{
						// it's okay
					}
					else
					{
						errorCount++;
						string msg = "Warning: Type mismatch of variable '" + leftVar->getName() + "'";
						printError(errorFile, msg, lineCount);
					}

				}
				
				$$ = new SymbolInfo($1->getName() + "=" + $3->getName(), "expression");
				printLog(logFile, "expression : variable ASSIGNOP logic_expression", $$->getName(), lineCount);
			}
		;


logic_expression :	rel_expression
					{
						$$ = $1;
						printLog(logFile, "logic_expression : rel_expression", $$->getName(), lineCount);
					}
					| rel_expression LOGICOP rel_expression
					{
						string _returnType = "int";
						//	The result of RELOP and LOGICOP should be "int""
						string leftType = $1->getType();
						string rightType = $3->getType();
						
						if ((leftType != "int") || (rightType != "int"))
						{
							errorCount++;
							string msg = "Both operand of " + $2->getName() + " should be int type";
							printError(errorFile, msg, lineCount);

							_returnType = ERROR;
						}

						$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(),	_returnType);
						printLog(logFile, "logic_expression : rel_expression LOGICOP rel_expression", $$->getName(), lineCount);
					}
				;

rel_expression	: simple_expression
				{
					$$ = $1;
					printLog(logFile, "rel_expression : simple_expression", $$->getName(), lineCount);
				}
				| simple_expression RELOP simple_expression
				{
					//	The result of RELOP and LOGICOP should be "int"
					$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(),	"int");
					printLog(logFile, "rel_expression : simple_expression RELOP simple_expression", $$->getName(), lineCount);
				}
			;

simple_expression :	term
					{
						$$ = $1;
						printLog(logFile, "simple_expression : term", $$->getName(), lineCount);
					}
					| simple_expression ADDOP term
					{
						string finalType = "int";
						if (($1->getType() == "float") || ($3->getType() == "float"))
						{
							finalType = "float";
						}

						$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(), finalType);
						printLog(logFile, "simple_expression : simple_expression ADDOP term", $$->getName(), lineCount);
					}
				;


term :	unary_expression
		{
			$$ = $1;
			printLog(logFile, "term : unary_expression", $$->getName(), lineCount);
		}
		|  term MULOP unary_expression
		{
			string leftType = $1->getType(), rightType = $3->getType();

			string _returnType = "error";
			string operatorSymbol = $2->getName();

			if (operatorSymbol == "%")
			{	//	ERROR REPORTING - Non-integer operand on MOD (%)
				if (leftType != "int" || rightType != "int")
				{
					errorCount++;
					printError(errorFile, "Non-integer operand on modulus operator", lineCount);
					_returnType = ERROR;
				}	// ERROR REPORTING END
				else
				{
					_returnType = "int";
				}
			}
			else if (operatorSymbol == "*" || operatorSymbol == "/")
			{
				if (leftType == "float" || rightType == "float")	_returnType = "float";
				else												_returnType = "int";
			}
			else
			{
				_returnType = "undeclared";
			}

			$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(), _returnType);
			printLog(logFile, "term : term MULOP unary_expression", $$->getName(), lineCount);
		}
	;


unary_expression: ADDOP unary_expression
				{
					$$ = new SymbolInfo($1->getName() + $2->getName(),	$2->getType());
					printLog(logFile, "unary_expression : ADDOP unary_expression", $$->getName(), lineCount);
				}
				| NOT unary_expression
				{
					$$ = new SymbolInfo("!" + $2->getName(),	$2->getType());
					printLog(logFile, "unary_expression : NOT unary_expression", $$->getName(), lineCount);
				}
				| factor
				{
					$$ = $1;
					printLog(logFile, "unary_expression : factor", $$->getName(), lineCount);
				}
			;


factor: variable
		{
			$$ = $1;
			printLog(logFile, "factor : variable", $$->getName(), lineCount);
		}
		| ID LPAREN argument_list RPAREN
		{
			string _returnType = "undeclared";

			SymbolInfo *currFunc;
			currFunc = st.lookup($1->getName());
			
			if (currFunc == nullptr)
			{
				errorCount++;
				string msg = "Undeclared function '" + $1->getName() + "' referred";
				printError(errorFile, msg, lineCount);
			}
			else
			{
				// whether we're accessing a function or a variable
				if (currFunc->isFunction())
				{
					_returnType = currFunc->getType();
					string argNameString = $3->getName();
					string argTypeString = $3->getType();
					
					vector<string> argNames = splitString(argNameString, ',');
					vector<string> argTypes = splitString(argTypeString, ',');
					
					vector<Parameter> paramList = currFunc->getParamList();

					if (paramList.size() != argNames.size())	//	Numbers of arguments don't match
					{
						errorCount++;
						string msg = "Number of arguments isn't consistent with function '" + currFunc->getName() + "'";
						printError(errorFile, msg, lineCount);
					}
					else	//	Numbers of arguments don't match. Now let's match the types
					{
						for (int i=0; i < argNames.size(); i++)
						{
							if (argTypes[i] != paramList[i].type)
							{
								errorCount++;
								string msg = "Type mismatch on function '" + currFunc->getName() + "'s argument '" + paramList[i].name + "'";
								printError(errorFile, msg, lineCount);
							}
						}
					}
				}
				else
				{
					errorCount++;
					string msg = "Non function Identifier '" + currFunc->getName() + "' accessed";
					printError(errorFile, msg, lineCount);
				}

			}
			// arg_list check left
			$$ = new SymbolInfo($1->getName() + "(" + $3->getName() + ")",	_returnType);
			printLog(logFile, "factor : ID LPAREN argument_list RPAREN", $$->getName(), lineCount);
		}
		| LPAREN expression RPAREN
		{
			$$ = new SymbolInfo("(" + $2->getName() + ")",	$2->getType() );
			printLog(logFile, "factor : LPAREN expression RPAREN", $$->getName(), lineCount);
		}
		| CONST_INT
		{
			$$ = yylval.syminfo;
			printLog(logFile, "factor : CONST_INT", $$->getName(), lineCount);
		}
		| CONST_FLOAT
		{
			$$ = yylval.syminfo;
			printLog(logFile, "factor : CONST_FLOAT", $$->getName(), lineCount);
		}
		| variable INCOP
		{
			$$ = new SymbolInfo($1->getName() + "++",	$1->getType());
			printLog(logFile, "factor : variable INCOP", $$->getName(), lineCount);
		}
		| variable DECOP
		{
			$$ = new SymbolInfo($1->getName() + "--",	$1->getType());
			printLog(logFile, "factor : variable DECOP", $$->getName(), lineCount);
		}
	;


argument_list :	arguments
				{
					$$ = $1;
					printLog(logFile, "argument_list : arguments", $$->getName(), lineCount);
				}
				|
				{
					$$ = new SymbolInfo("", "void");
					printLog(logFile, "argument_list : ", $$->getName(), lineCount);
				}
			;


arguments : arguments COMMA logic_expression
			{
				string argNames = $1->getName() + "," + $3->getName();
				string argTypes = $1->getType() + "," + $3->getType();

				$$ = new SymbolInfo(argNames, argTypes);
				printLog(logFile, "arguments : arguments COMMA logic_expression", $$->getName(), lineCount);
			}
			| logic_expression
			{
				$$ = $1;
				printLog(logFile, "arguments : logic_expression", $$->getName(), lineCount);
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

	// Logfile print
	st.printAllScope_(logFile);
	fprintf(logFile, "Total lines: %d\n", lineCount);
	fprintf(logFile, "Total errors: %d\n", errorCount);

	// Console Print
	cout << "\nTotal Lines: "  << lineCount << endl;
	cout << "Total Errors: " << errorCount << endl;

	fclose(logFile);
	fclose(errorFile);

	return 0;
}
