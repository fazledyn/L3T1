%{

#include "bits/stdc++.h"
#include "lib/SymbolTable.h"
#include "lib/Parameter.h"
#include "lib/util.h"
#include "lib/Assembly.h"

#define yydebug 1
#define ERROR "error"

SymbolTable st(30);

FILE *inputFile;
FILE *log_file;
FILE *error_file;
FILE *asm_file;
FILE *optimized_asm_file;

/*
	This list is used to store all variable across different scopes.
	the <int> in the pair represents the number of element inside it.

	array: arraySize (>0)
	variable: 0
*/

vector<pair<string, int>> global_var_list;

extern FILE* yyin;

int tempCount = 0;
int labelCount = 0;
int line_count = 1;
int error_count = 0;

string current_func_ret_type   = ERROR;
string parameter_retrieve_code = ERROR;


int yyparse(void);
int yylex(void);


void yyerror(const char* str) {
	fprintf(error_file, "Syntax error at line: %d : \"%s\" \n", line_count, str);
}

string new_temp() {
	string temp = "temp_" + to_string(tempCount++);
	global_var_list.push_back({ temp, 0 });
	return temp;
}

string new_label() {
	return "label_" + to_string(labelCount++);
}

string get_global_name(string var_name, SymbolTable st) {
    return var_name + "_" + st.getCurrentScopeId();
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
			string total_code = $1->getCode();

			if (error_count == 0)
			{	
				asm_file 			= fopen("code.asm", "w");
				optimized_asm_file 	= fopen("optimized_code.asm", "w");

				init_asm_file(asm_file, global_var_list);
				add_print_proc(asm_file);
				print_to_file(asm_file, total_code);
				fclose(asm_file);

				optimize_code(optimized_asm_file);
				fclose(optimized_asm_file);
			}

			$$ = $1;
			printLog(log_file, "start : program", "", line_count);			
		}
	;

program : program unit
		{
			$$ = new SymbolInfo($1->getName() + "\n" + $2->getName(), "program");
			$$->setCode($1->getCode() + $2->getCode());
			
			printLog(log_file, "program : program unit", $$->getName(), line_count);
		}
		| unit
		{
			$$ = $1;
			printLog(log_file, "program : unit", $$->getName(), line_count);
		}
	;

unit :	var_declaration
		{
			$$ = $1;
			printLog(log_file, "unit : var_declaration", $$->getName(), line_count);
		}
    	| func_declaration
		{
			$$ = $1;
			printLog(log_file, "unit : func_declaration", $$->getName(), line_count);
		}
		| func_definition
		{
			$$ = $1;
			printLog(log_file, "unit : func_definition", $$->getName(), line_count);
		}
    ;	


func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
				{
					string funcType = $1->getName();
					string funcName = $2->getName();

					vector<string> paramTypeList = extractParameterType($4->getName());
					SymbolInfo* curr_func = st.lookup(funcName);
						
					if (curr_func != nullptr)	//	 Already declared
					{
						error_count++;
						string msg = "Multiple declaration of function '" + funcName + "'";
						printError(error_file, log_file,  msg, line_count);
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
					printLog(log_file, "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON", $$->getName(), line_count);
				}
                | type_specifier ID LPAREN RPAREN SEMICOLON
				{
					string funcType = $1->getName();
					string funcName = $2->getName();

					SymbolInfo* curr_func = st.lookup(funcName);

					if (curr_func != nullptr)	//	 Already declared
					{
						error_count++;
						string msg = "Multiple declaration of function '" + funcName + "'";
						printError(error_file, log_file,  msg, line_count);
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
					printLog(log_file, "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON", $$->getName(), line_count);
				}
            ;


func_definition : type_specifier ID LPAREN parameter_list RPAREN 
				{
					string funcType = $1->getName();
					string funcName = $2->getName();
					vector<Parameter> paramList = extractParameters($4->getName());

					SymbolInfo* curr_func = st.lookup(funcName);
					current_func_ret_type = funcType;
					
					if (curr_func != nullptr) // Function is declared
					{
						if (curr_func->isFunction())
						{
							if (curr_func->isDefined()) // Declared and Defined
							{
								error_count++;
								string msg = "Re-definition of function '" + funcName + "'";
								printError(error_file, log_file,  msg, line_count);
							}
							else	// Declared, but not defined
							{
								bool definitionIsConsistent = true;

								int declaredParamSize = curr_func->getParamList().size();
								int  definedParamSize = paramList.size();

								if (declaredParamSize != definedParamSize)	//	ERROR - ParamList size doesnt match
								{
									definitionIsConsistent = false;
									error_count++;
									printError(error_file, log_file,  "Number of parameters isn't consistent with declaration", line_count);
								}

								string declaredType = curr_func->getType();
								if (declaredType != funcType)		//	ERROR - Return type doesn't match
								{
									definitionIsConsistent = false;
									error_count++;
									printError(error_file, log_file,  "Function return type doesn't match with declaration", line_count);	
								}

								vector<Parameter> declaredParamList = curr_func->getParamList();
								
								if ((declaredParamSize != 0) && (declaredParamSize == definedParamSize))
								{
									for (int i=0; i < declaredParamSize; i++)
									{
										string declaredType = declaredParamList[i].type;
										string currentType = paramList[i].type;

										if (declaredType != currentType)	//	ERROR - Type mismatch in function parameter
										{
											definitionIsConsistent = false;
											error_count++;
											string msg = "Type mismatch of function parameter '" + paramList[i].name + "'";
											printError(error_file, log_file,  msg, line_count);
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

								string param_retrieve_code = "";

								for (int i=0; i < paramList.size(); i++)
								{

									string global_name = get_global_name(paramList[i].name, st);
									global_var_list.push_back( {global_name, 0} );

									inserted = st.insert(paramList[i].name, paramList[i].type, global_name);
									
									// Pop the value of the stacks and store in the local variables
									param_retrieve_code += "\tPOP " + global_name + "\n";
							
									if (!inserted)
									{
										error_count++;
										string msg = "Multiple declaration of variable '" + paramList[i].name + "' in parameter";
										printError(error_file, log_file,  msg, line_count);
									}
								}

								parameter_retrieve_code = param_retrieve_code;
							}
						}
						else
						{
							st.enterScope();

							error_count++;
							string msg = "Identifier '" + curr_func->getName() + "' is not a function.";
							printError(error_file, log_file,  msg, line_count);
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

						string param_retrieve_code = "";

						for (int i=0; i < paramList.size(); i++)
						{
							string global_name = get_global_name(paramList[i].name, st);
							global_var_list.push_back( {global_name, 0} );

							inserted = st.insert(paramList[i].name, paramList[i].type, global_name);

							// Pop the value of the stacks and store in the local variables
							param_retrieve_code += "\tPOP " + global_name + "\n";

							if (!inserted)
							{
								error_count++;
								string msg = "Multiple declaration of variable '" + paramList[i].name + "' in parameter";
								printError(error_file, log_file,  msg, line_count);
							}
						}

						parameter_retrieve_code = param_retrieve_code;
					}
				}
				compound_statement
				{
					// $1 - type $2 - id
					string code = "";
					string func_name = $2->getName();

					SymbolInfo* curr_func = st.lookup(func_name);
					vector<Parameter> param_list = curr_func->getParamList();

					if (func_name == "main") {
						code += "MAIN PROC\n";
						code += "\tMOV AX, @DATA\n";
						code += "\tMOV DS, AX\n";

						code += $7->getCode();

						code += "\tMOV AX, 4CH\n";
						code += "\tINT 21H\n";
						code += "MAIN ENDP\n";
						code += "END MAIN\n\n";
					}
					else {
						code += $2->getName() + " PROC\n";

						code += "\tPOP BP		; storing the return pointer in BP\n";
						code += parameter_retrieve_code;
						code += "\tPUSH BP		; retrieving the return pointer\n";

						code += $7->getCode();
						code += "\tPUSH BP\n";
						code += "\tRET\n";

						code += $2->getName() + " ENDP\n\n";
					}

					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "(" + $4->getName() + ")" + $7->getName() + "\n", "func_definition");
					$$->setCode(code);
					printLog(log_file, "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement", $$->getName(), line_count);
				}
				| type_specifier ID LPAREN RPAREN
				{
					string funcType = $1->getName();
					string funcName = $2->getName();
					
					SymbolInfo* curr_func = st.lookup(funcName);
				
					if (curr_func != nullptr) // Function is declared
					{
						if (curr_func->isDefined()) // Declared and Defined
						{
							error_count++;
							string msg = "Re-definition of function '" + funcName + "'";
							printError(error_file, log_file,  msg, line_count);
						}
						else	// Declared, but not defined
						{
							bool definitionIsConsistent = true;

							int declaredParamSize = curr_func->getParamList().size();
							int  definedParamSize = 0;

							if (declaredParamSize != definedParamSize)	//	ERROR - ParamList size doesnt match
							{
								definitionIsConsistent = false;
								error_count++;
								printError(error_file, log_file,  "Number of parameters isn't consistent with declaration", line_count);
							}

							string declaredType = curr_func->getType();

							if (declaredType != funcType)		//	ERROR - Return type doesn't match
							{
								definitionIsConsistent = false;
								error_count++;
								printError(error_file, log_file,  "Function return type doesn't match with declaration", line_count);	
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
					string code = "";
					
					if ($2->getName() == "main") {
						code += "MAIN PROC\n";
						code += "\tMOV AX, @DATA\n";
						code += "\tMOV DS, AX\n";

						code += $6->getCode();

						code += "\tMOV AX, 4CH\n";
						code += "\tINT 21H\n";
						code += "MAIN ENDP\n";
						code += "END MAIN\n\n";
					}
					else {
						code += $2->getName() + " PROC\n";
						
						code += "\tPOP BP		; storing the return pointer in BP\n";
						code += $6->getCode();
						code += "\tPUSH BP		; retrieving the return pointer\n";
						code += "\tRET\n";

						code += $2->getName() + " ENDP\n\n";
					}

					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + "()" + $6->getName() + "\n", "func_definition");
					$$->setCode(code);

					printLog(log_file, "func_definition : type_specifier ID LPAREN RPAREN compound_statement", $$->getName(), line_count);
				}
 			;


parameter_list  : parameter_list COMMA type_specifier ID
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName() + " " + $4->getName(), "parameter_list");
					printLog(log_file, "parameter_list : parameter_list COMMA type_specifier ID", $$->getName(), line_count);
				}
				| parameter_list COMMA type_specifier
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName(), "parameter_list");
					printLog(log_file, "parameter_list : parameter_list COMMA type_specifier", $$->getName(), line_count);
				}
				| type_specifier ID
				{
					$$ = new SymbolInfo($1->getName() + " " + $2->getName(), "parameter_list");
					printLog(log_file, "parameter_list : type_specifier ID", $$->getName(), line_count);
				}
				| type_specifier
				{
					$$ = $1;
					printLog(log_file, "parameter_list : type_specifier", $$->getName(), line_count);
				}
			;


compound_statement 	: LCURL statements RCURL
					{
						$$ = new SymbolInfo("{\n"+ $2->getName() + "\n}", "compound_statement");
						$$->setCode($2->getCode());

						printLog(log_file, "compound_statement : LCURL statements RCURL", $$->getName(), line_count);
						
						st.printAllScope_(log_file);
						st.exitScope();
					}
				    | LCURL RCURL
					{
						$$ = new SymbolInfo("{\n}", "compound_statement");
						printLog(log_file, "compound_statement : LCURL RCURL", $$->getName(), line_count);
					}
				;


var_declaration : type_specifier declaration_list SEMICOLON
				{
					string varName = $2->getName();
					string varType = $1->getName();

					//	ERROR REPORTING - Void type variable
					if (varType == "void")
					{
						error_count++;
						printError(error_file, log_file,  "Variable type can't be void", line_count);
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

								string global_name = get_global_name(arrayName, st);
								global_var_list.push_back( {global_name, arraySize} );
							
								temp.setAsArray(arrayName, varType, arraySize);
								temp.setAsm(global_name);
							}
							else
							{
								string global_name = get_global_name(current, st);
								global_var_list.push_back( {global_name, 0} );

								temp = SymbolInfo(current, varType);
								temp.setAsm(global_name);
							}

							//	ERROR REPORTING - Multiple declaration of variable
							if ( !st.insertSymbolInfo(temp) ) {
								error_count++;
								string msg = "Multiple declaration of variable '" + temp.getName() + "'";
								printError(error_file, log_file,  msg, line_count);
							} // ERROR DONE

						}
					}

					$$ = new SymbolInfo($1->getName() + " " + $2->getName() + ";", "var_declaration");
					printLog(log_file, "var_declaration : type_specifier declaration_list SEMICOLON", $$->getName(), line_count);
				}
			;


type_specifier 	: INT
				{
					$$ = new SymbolInfo("int", "int");
					printLog(log_file, "type_specifier : INT", $$->getName(), line_count);
				}
 				| FLOAT
				{
					$$ = new SymbolInfo("float", "int");
					printLog(log_file, "type_specifier : FLOAT", $$->getName(), line_count);
				}
		 		| VOID
				{
					$$ = new SymbolInfo("void", "void");
					printLog(log_file, "type_specifier : VOID", $$->getName(), line_count);
				}
			;


declaration_list : declaration_list COMMA ID
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName(), "declaration_list");
					printLog(log_file, "declaration_list : declaration_list COMMA ID", $$->getName(), line_count);
				}
		 		| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
				{
					$$ = new SymbolInfo($1->getName() + "," + $3->getName() + "[" + $5->getName() + "]",	"declaration_list");
					printLog(log_file, "declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD", $$->getName(), line_count);
				}
				| ID
				{
					$$ = $1;
					printLog(log_file, "declaration_list : ID", $$->getName(), line_count);
				}
		 		| ID LTHIRD CONST_INT RTHIRD
				{
					$$ = new SymbolInfo($1->getName() + "[" + $3->getName() + "]",	"declaration_list");
					printLog(log_file, "declaration_list : ID LTHIRD CONST_INT RTHIRD", $$->getName(), line_count);
				}
			;


statements : statement
			{
				$$ = $1;
				printLog(log_file, "statements : statement", $$->getName(), line_count);
			}
			| statements statement
			{
				$$ = new SymbolInfo($1->getName() + "\n" + $2->getName(), "statements");
				$$->setCode($1->getCode() + $2->getCode());

				printLog(log_file, "statements : statements statement", $$->getName(), line_count);
			}
		;


statement : var_declaration
			{
				$$ = $1;
				printLog(log_file, "statement : var_declaration", $$->getName(), line_count);
			}
			| expression_statement
			{
				$$ = $1;
				printLog(log_file, "statement : expression_statement", $$->getName(), line_count);
			}
			| { st.enterScope(); } compound_statement
			{
				$$ = $2;
				printLog(log_file, "statement : compound_statement", $$->getName(), line_count);
			}
			| FOR LPAREN expression_statement expression_statement expression RPAREN statement
			{
				string code = "";
				string cond_asm = $4->getAsm();

				string init_code = $3->getCode();
				string cond_code = $4->getCode();
				string incr_code = $5->getCode();
				string body_code = $7->getCode();

				string first_statement = $3->getName();
				string second_statement = $4->getName();

				code += "; code segment for FOR loop rule \n";
				code += init_code;

				if (first_statement != ";" && second_statement != ";")
				{
					string label_1 = new_label();
					string label_2 = new_label();

					code += label_1 + ":\n";
					code += cond_code;
					code += "\tMOV AX, " + cond_asm + "\n";
					code += "\tCMP AX, 0\n";
					code += "\tJE " + label_2 + "\n";

					code += body_code;
					code += incr_code;
					code += "\tJMP " + label_1 + "\n";
					code += label_2 + ":\n";
				}

				$$ = new SymbolInfo("for(" + $3->getName() + $4->getName() + $5->getName() + ")" + $7->getName(),	"statement");
				$$->setCode(code);

				printLog(log_file, "statement : IF LPAREN expression_statement expression_statement expression RPAREN statement", $$->getName(), line_count);
			}
			| IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE
			{
				string cond_code = $3->getCode();
				string body_code = $5->getCode();

				string cond_asm = $3->getAsm();
				string label = new_label();

				string code = "";

				code += "; code segment for IF rule\n";

				code += cond_code;
				code += "\tMOV AX, " + cond_asm + "\n";
				code += "\tCMP AX, 0\n";
				code += "\tJE " + label + "\n";
				code += body_code;
				code += label + ":\n";

				$$ = new SymbolInfo("if(" + $3->getName() + ")" + $5->getName(),	"statement");
				$$->setCode(code);

				printLog(log_file, "statement : IF LPAREN expression RPAREN statement", $$->getName(), line_count);
			}
			| IF LPAREN expression RPAREN statement ELSE statement
			{
				string cond_code = $3->getCode();
				string cond_asm = $3->getAsm();

				string if_body_code = $5->getCode();
				string else_body_code = $7->getCode();

				string label_1 = new_label();
				string label_2 = new_label();

				string code = "";

				code += "; code segment for IF ELSE rule\n";

				code += cond_code;
				code += "\tMOV AX, " + cond_asm + "\n";
				code += "\tCMP AX, 0\n";
				code += "\tJE " + label_1 + "\n";
				code += if_body_code;
				code += "\tJMP " + label_2 + "\n";
				code += label_1 + ":\n";
				code += else_body_code;
				code += label_2 + ":\n";

				$$ = new SymbolInfo("if(" + $3->getName() + ")" + $5->getName() + "else" + $7->getName(),	"statement");
				$$->setCode(code);

				printLog(log_file, "statement : IF LPAREN expression RPAREN statement ELSE statement", $$->getName(), line_count);
			}
			| WHILE LPAREN expression RPAREN statement
			{
				string body_code = $5->getCode();
				string cond_code = $3->getCode();

				string cond_asm = $3->getAsm();
				string code = "";

				string label_1 = new_label();
				string label_2 = new_label();

				code += "; code segment for WHILE rule\n";

				code += label_1 + ":\n";
				code += cond_code;
				code += "\tMOV AX, " + cond_asm + "\n";
				code += "\tCMP AX, 0\n";
				code += "\tJE " + label_2 + "\n";

				code += body_code;
				code += "\tJMP " + label_1 + "\n";
				code += label_2 + ":\n";

				$$ = new SymbolInfo("while(" + $3->getName() + ")" + $5->getName(),	"statement");
				$$->setCode(code);

				printLog(log_file, "statement : WHILE LPAREN expression RPAREN statement", $$->getName(), line_count);
			}
			| PRINTLN LPAREN ID RPAREN SEMICOLON
			{
				string idName = $3->getName();
				SymbolInfo* curr_id = st.lookup(idName);

				if (curr_id == nullptr)
				{
					error_count++;
					string msg = "Variable '" + idName + "' undeclared";
					printError(error_file, log_file,  msg, line_count);
				}
				else
				{
					if ( !curr_id->isVariable() )
					{
						error_count++;
						string msg = "A function can't be inside printf";
						printError(error_file, log_file,  msg, line_count);
					}
				}
				
				// assembly code
				string code = "";
				string currentVar = curr_id->getAsm();

				code += "\tMOV AX, " + currentVar + "\n";
				code += "\tMOV print_var, AX\n";
				code += "\tCALL PRINTLN\n";

				$$ = new SymbolInfo("println(" + $3->getName() + ");",	"statement");
				$$->setCode(code);

				printLog(log_file, "statement : PRINTLN LPAREN ID RPAREN SEMICOLON", $$->getName(), line_count);
			}
			| RETURN expression SEMICOLON
			{
				string currentReturnType = $2->getName();
				string code = "";

				if (current_func_ret_type == "void")
				{
					error_count++;
					string msg = "Function type void can't have a return statement";
					printError(error_file, log_file,  msg, line_count);

					current_func_ret_type = ERROR;
				}

				code += $2->getCode();

				code += "\tPOP BP\n";
				code += "\tPUSH " + $2->getAsm() + "\n";

				$$ = new SymbolInfo("return " + $2->getName() + ";", "statement");
				$$->setCode(code);

				printLog(log_file, "statement : RETURN expression SEMICOLON", $$->getName(), line_count);
			}
		;


expression_statement : SEMICOLON
					{
						$$ = new SymbolInfo(";", "SEMICOLON");
					}
					| expression SEMICOLON
					{
						$$ = new SymbolInfo($1->getName() + ";", "expression_statement");
						$$->setCode($1->getCode());
						$$->setAsm($1->getAsm());

						printLog(log_file, "expression_statement : expression SEMICOLON", $$->getName(), line_count);
					}
				;


variable :	ID
			{
				string _returnType;
				SymbolInfo* curr_id = st.lookup($1->getName());
				
				if (curr_id == nullptr)
				{
					error_count++;
					string msg = "Undeclared variable '" + $1->getName() + "' referred";
					printError(error_file, log_file,  msg, line_count);
					$$ = new SymbolInfo($1->getName(), ERROR);
				}
				else
				{
					if (curr_id->isArray())
					{
						$$ = new SymbolInfo();
						$$->setAsArray(curr_id->getName(), ERROR, curr_id->getSize());
					}
					else
					{
						$$ = new SymbolInfo(curr_id->getName(), curr_id->getType());
						$$->setAsm(curr_id->getAsm());
					}

				}
				printLog(log_file, "variable : ID", $$->getName(), line_count);
			}
			| ID LTHIRD expression RTHIRD
			{
				SymbolInfo* curr_id = st.lookup($1->getName());

				string code = "";
				string temp = new_temp();

				string expr_code = $3->getCode();
				string expr_asm  = $3->getAsm();

				if (curr_id == nullptr)
				{
					error_count++;
					string msg = "Undeclared variable '" + $1->getName() + "' referred";
					printError(error_file, log_file,  msg, line_count);

					$$ = new SymbolInfo($1->getName() + "[" + $3->getName() + "]",	ERROR);
				}
				else
				{
					if ( curr_id->isArray() )	//		Array Type variable
					{	
						string _returnType = curr_id->getType();
						string currName = curr_id->getName();

						//	ERROR REPORTING - Non-integer array index
						if ($3->getType() != "int")
						{
							error_count++;
							printError(error_file, log_file,  "Non-integer array index of '" + $1->getName() + "'", line_count);
						}

						string global_name = curr_id->getAsm();

						code += expr_code;
						code += "\tMOV SI, " + expr_asm + "\n";
						code += "\tADD SI, SI\n";
						code += "\tMOV AX, " + global_name + "[SI]\n";
					//	code += "\tMOV " + temp + ", AX\n";
						temp = global_name + "[" + expr_asm + "]";

					}
					else
					{
						error_count++;
						string msg = "Type mismatch. Variable '" + curr_id->getName() + "' is not an array";
						printError(error_file, log_file,  msg, line_count);

						$$ = new SymbolInfo($1->getName() + "[" + $3->getName() + "]",	ERROR);
					}
				}

				$$ = new SymbolInfo($1->getName() + "[" + $3->getName() + "]", curr_id->getType());
				$$->setCode(code);
				$$->setAsm(temp);

				printLog(log_file, "variable : ID LTHIRD expression RTHIRD", $$->getName(), line_count);
			}
		;


expression: logic_expression
			{
				$$ = $1;
				printLog(log_file, "expression : logic_expression", $$->getName(), line_count);
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
							
							error_count++;
							printError(error_file, log_file,  msg, line_count);
						}
					}
					else if (leftVar->getType() == "float" && rightVar->getType() == "int")
					{
						// it's okay
					}
					else
					{
						error_count++;
						string msg = "Warning: Type mismatch of variable '" + leftVar->getName() + "'";
						printError(error_file, log_file,  msg, line_count);
					}
				}

				string left_asm = $1->getAsm();
				string right_asm = $3->getAsm();
				
				string left_code = $1->getCode();
				string right_code = $3->getCode();

				string code = "";

				code += left_code;
				code += right_code;

				code += "\tMOV AX, " + right_asm + "\n";
				code += "\tMOV " + left_asm + ", AX\n";

				$$ = new SymbolInfo($1->getName() + "=" + $3->getName(), "expression");
				$$->setCode(code);
				$$->setAsm(left_asm);

				printLog(log_file, "expression : variable ASSIGNOP logic_expression", $$->getName(), line_count);
			}
		;


logic_expression :	rel_expression
					{
						$$ = $1;
						printLog(log_file, "logic_expression : rel_expression", $$->getName(), line_count);
					}
					| rel_expression LOGICOP rel_expression
					{
						//	The result of RELOP and LOGICOP should be "int""
						string _returnType = "int";
						string leftType = $1->getType();
						string rightType = $3->getType();
						
						if ((leftType != "int") || (rightType != "int"))
						{
							error_count++;
							string msg = "Both operand of " + $2->getName() + " should be int type";
							printError(error_file, log_file,  msg, line_count);
							_returnType = ERROR;
						}

						string symbol = $2->getName();

						string left_asm = $1->getAsm();
						string right_asm = $3->getAsm();

						string left_code = $1->getCode();
						string right_code = $3->getCode();

						string code = "";
						string temp = new_temp();

						string return_0 = new_label();
						string return_1 = new_label();

						code += left_code;
						code += right_code;

						if (symbol == "&&")
						{	
							code += "\tMOV AX, " + left_asm + "\n";
							code += "\tCMP AX, 0\n";
							code += "\tJE " + return_0 + "\n";
							code += "\tMOV AX, " + right_asm + "\n";
							code += "\tCMP AX, 0\n";
							code += "\tJE " + return_0 + "\n";
							code += "\tMOV AX, 1\n";
							code += "\tMOV " + temp + ", AX\n";
							code += "\tJMP " + return_1 + "\n";
							code += return_0 + ":\n";
							code += "\tMOV AX, 0\n";
							code += "\tMOV " + temp + ", AX\n";
							code += return_1 + ":\n";
						}
						else
						{
							code += "\tMOV AX, " + left_asm + "\n";
							code += "\tCMP AX, 0\n";
							code += "\tJNE " + return_0 + "\n";
							code += "\tMOV AX, " + right_asm + "\n";
							code += "\tCMP AX, 0\n";
							code += "\tJNE " + return_0 + "\n";
							code += "\tMOV AX, 1\n";
							code += "\tMOV " + temp + ", AX\n";
							code += "\tJMP " + return_1 + "\n";
							code += return_0 + ":\n";
							code += "\tMOV AX, 0\n";
							code += "\tMOV " + temp + ", AX\n";
							code += return_1 + ":\n";
						}

						$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(),	_returnType);
						$$->setCode(code);
						$$->setAsm(temp);

						printLog(log_file, "logic_expression : rel_expression LOGICOP rel_expression", $$->getName(), line_count);
					}
				;

rel_expression	: simple_expression
				{
					$$ = $1;
					printLog(log_file, "rel_expression : simple_expression", $$->getName(), line_count);
				}
				| simple_expression RELOP simple_expression
				{
					//	The result of RELOP and LOGICOP should be "int"

					string left_asm  = $1->getAsm();
					string right_asm = $3->getAsm();

					string left_code  = $1->getCode();
					string right_code = $3->getCode();

					string code = "";
					string temp = new_temp();

					string return_0 = new_label();
					string return_1 = new_label();

					string symbol = $2->getName();

					code += left_code;
					code += right_code;

					code += "\tMOV AX, " + left_asm  + "\n";
					code += "\tCMP AX, " + right_asm + "\n";

					if (symbol == "<")
					{
						code += "\tJL " + return_1 + "\n";
						code += "\tMOV AX, 0\n";
						code += "\tMOV " + temp + ", AX\n";
						code += "\tJMP " + return_0 + "\n";
						code += return_1 + ":\n";
						code += "\tMOV AX, 1\n";
						code += "\tMOV " + temp + ", AX\n";
						code += return_0 + ":\n";
					}
					else if (symbol == ">")
					{
						code += "\tJG " + return_1 + "\n";
						code += "\tMOV AX, 0\n";
						code += "\tMOV " + temp + ", AX\n";
						code += "\tJMP " + return_0 + "\n";
						code += return_1 + ":\n";
						code += "\tMOV AX, 1\n";
						code += "\tMOV " + temp + ", AX\n";
						code += return_0 + ":\n";
					}
					else if (symbol == "<=")
					{
						code += "\tJLE " + return_1 + "\n";
						code += "\tMOV AX, 0\n";
						code += "\tMOV " + temp + ", AX\n";
						code += "\tJMP " + return_0 + "\n";
						code += return_1 + ":\n";
						code += "\tMOV AX, 1\n";
						code += "\tMOV " + temp + ", AX\n";
						code += return_0 + ":\n";
					}
					else if (symbol == ">=")
					{
						code += "\tJGE " + return_1 + "\n";
						code += "\tMOV AX, 0\n";
						code += "\tMOV " + temp + ", AX\n";
						code += "\tJMP " + return_0 + "\n";
						code += return_1 + ":\n";
						code += "\tMOV AX, 1\n";
						code += "\tMOV " + temp + ", AX\n";
						code += return_0 + ":\n";
					}
					else if (symbol == "==")
					{
						code += "\tJE " + return_1 + "\n";
						code += "\tMOV AX, 0\n";
						code += "\tMOV " + temp + ", AX\n";
						code += "\tJMP " + return_0 + "\n";
						code += return_1 + ":\n";
						code += "\tMOV AX, 1\n";
						code += "\tMOV " + temp + ", AX\n";
						code += return_0 + ":\n";
					}
					else
					{
						code += "\tJNE " + return_1 + "\n";
						code += "\tMOV AX, 0\n";
						code += "\tMOV " + temp + ", AX\n";
						code += "\tJMP " + return_0 + "\n";
						code += return_1 + ":\n";
						code += "\tMOV AX, 1\n";
						code += "\tMOV " + temp + ", AX\n";
						code += return_0 + ":\n";
					}
					
					$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(),	"int");
					$$->setCode(code);
					$$->setAsm(temp);

					printLog(log_file, "rel_expression : simple_expression RELOP simple_expression", $$->getName(), line_count);
				}
			;

simple_expression :	term
					{
						$$ = $1;
						printLog(log_file, "simple_expression : term", $$->getName(), line_count);
					}
					| simple_expression ADDOP term
					{
						string finalType = "int";
						
						if (($1->getType() == "float") || ($3->getType() == "float")) {
							finalType = "float";
						}

						string temp;
						string code = "";

						string left_code  = $1->getCode();
						string right_code = $3->getCode();

						string left_asm  = $1->getAsm();
						string right_asm = $3->getAsm();

						code += left_code;
						code += right_code;

						if ($2->getName() == "+") {
							// simple ADD operation

							code += "\tMOV AX, " + left_asm  + "\n";
							code += "\tADD AX, " + right_asm + "\n";
							temp = new_temp();
							code += "\tMOV " + temp + ", AX\n";

						}
						else {
							// simple SUB operation

							code += "\tMOV AX, " + left_asm  + "\n";
							code += "\tSUB AX, " + right_asm + "\n";
							temp = new_temp();
							code += "\tMOV "  + temp + ", AX\n";
						}

						$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(), finalType);
						$$->setCode(code);
						$$->setAsm(temp);
						
						printLog(log_file, "simple_expression : simple_expression ADDOP term", $$->getName(), line_count);
					}
				;


term :	unary_expression
		{
			$$ = $1;
			printLog(log_file, "term : unary_expression", $$->getName(), line_count);
		}
		|  term MULOP unary_expression
		{
			string leftType = $1->getType();
			string rightType = $3->getType();

			string _returnType = ERROR;
			string symbol = $2->getName();

			if (symbol == "%")
			{	
				//	ERROR REPORTING - Non-integer operand on MOD (%)
				if (leftType != "int" || rightType != "int")
				{
					error_count++;
					printError(error_file, log_file,  "Non-integer operand on modulus operator", line_count);
					_returnType = ERROR;
				}
				else
				{
					string rightSymbol = $3->getName();
					if (rightSymbol == "0")
					{
						error_count++;
						string msg = "Modulus by zero";
						printError(error_file, log_file,  msg, line_count);
					}
					_returnType = "int";
				}
			}
			else if (symbol == "*" || symbol == "/")
			{
				if (leftType == "float" || rightType == "float")	_returnType = "float";
				else												_returnType = "int";

				if (symbol == "/")
				{
					string rightSymbol = $3->getName();
					if (rightSymbol == "0")
					{
						error_count++;
						string msg = "Divided by zero not possible";
						printError(error_file, log_file,  msg, line_count);

						_returnType = ERROR;
					}
				}
			}
			else
			{
				_returnType = "undeclared";
			}

			// Assembly code
			string code = "";
			string temp = new_temp();

			string left_asm  = $1->getAsm();
			string right_asm = $3->getAsm();

			string left_code  = $1->getCode();
			string right_code = $3->getCode();

			code += left_code;
			code += right_code;

			if (symbol == "*") {
				
				code += "\tMOV AX, " + left_asm + "\n";
				code += "\tMOV BX, " + right_asm + "\n";
				code += "\tIMUL BX\n";
				code += "\tMOV " + temp + ", AX\n";

			}
			else {
				
				code += "\tMOV AX, " + left_asm + "\n";
				code += "\tCWD\n";
				code += "\tMOV BX, " + right_asm + "\n";
				code += "\tIDIV BX\n";

				if (symbol == "/") {
					code += "\tMOV " + temp + ", AX\n";
				}
				else {
					code += "\tMOV " + temp + ", DX\n";
				}
			}

			$$ = new SymbolInfo($1->getName() + $2->getName() + $3->getName(), _returnType);
			$$->setCode(code);
			$$->setAsm(temp);

			printLog(log_file, "term : term MULOP unary_expression", $$->getName(), line_count);
		}
	;


unary_expression: ADDOP unary_expression
				{
					string temp;
					string code = "";
					string sign = $1->getName();

					string right_asm  = $2->getAsm();
					string right_code = $2->getCode();

					if (sign == "-"){
						temp = new_temp();
						code += right_code;
						code += "\tMOV AX, " + right_asm + "\n";
						code += "\tMOV " + temp + ", AX\n";
						code += "\tNEG " + temp + "\n";
					}
					else {
						temp = right_asm;
						code = right_code;
					}

					$$ = new SymbolInfo($1->getName() + $2->getName(),	$2->getType());
					$$->setCode(code);
					$$->setAsm(temp);

					printLog(log_file, "unary_expression : ADDOP unary_expression", $$->getName(), line_count);
				}
				| NOT unary_expression
				{
					string temp;
					string code = "";
					string right_asm  = $2->getAsm();
					string right_code = $2->getCode();

					string return_0 = new_label();
					string return_1 = new_label();

					code += right_code;

					code += "\tMOV AX, " + right_asm + "\n";
					code += "\tCMP AX, 0\n";
					code += "\tJE " + return_1 + "\n";
					code += "\tMOV AX, 0\n";
					code += "\tMOV " +  temp + ", AX\n";
					code += "\tJMP " + return_0 + "\n";

					code += return_1 + ":\n";
					code += "\tMOV AX, 1\n";
					code += "\tMOV " + temp + ", AX\n";
					code += return_0 + ":\n";

					$$ = new SymbolInfo("!" + $2->getName(),	$2->getType());
					$$->setCode(code);
					$$->setAsm(temp);

					printLog(log_file, "unary_expression : NOT unary_expression", $$->getName(), line_count);
				}
				| factor
				{
					$$ = $1;
					printLog(log_file, "unary_expression : factor", $$->getName(), line_count);
				}
			;


factor: variable
		{
			$$ = $1;
			printLog(log_file, "factor : variable", $$->getName(), line_count);
		}
		| ID LPAREN argument_list RPAREN
		{
			SymbolInfo *curr_func;
			curr_func = st.lookup($1->getName());
			
			string _returnType = "undeclared";
			string funcName = curr_func->getName();
			string temp;
			string code = "";

			if (curr_func == nullptr)
			{
				error_count++;
				string msg = "Undeclared function '" + $1->getName() + "' referred";
				printError(error_file, log_file,  msg, line_count);
			}
			else
			{
				// whether we're accessing a function or a variable
				if (curr_func->isFunction())
				{
					_returnType = curr_func->getType();
					string argNameString = $3->getName();
					string argTypeString = $3->getType();
					string asmNameString = $3->getAsm();

					vector<string> argNames = splitString(argNameString, ',');
					vector<string> argTypes = splitString(argTypeString, ',');
					vector<string> asmNames = splitString(asmNameString, ',');

					vector<Parameter> paramList = curr_func->getParamList();

					if (_returnType == "void")
					{
						error_count++;
						string msg = "Void function can't be used as factor";
						printError(error_file, log_file,  msg, line_count);
					}
					else if (paramList.size() != argNames.size())	//	Numbers of arguments don't match
					{
						error_count++;
						string msg = "Number of arguments isn't consistent with function '" + curr_func->getName() + "'";
						printError(error_file, log_file,  msg, line_count);
					}
					else	//	Numbers of arguments match. Now let's match the types
					{
						for (int i=0; i < argNames.size(); i++)
						{
							if (argTypes[i] != paramList[i].type)
							{
								error_count++;
								string msg = "Type mismatch on function '" + curr_func->getName() + "'s argument '" + paramList[i].name + "'";
								printError(error_file, log_file,  msg, line_count);
							}
						}

						code += "\tPUSH AX\n";
						code += "\tPUSH BX\n";
						code += "\tPUSH CX\n";
						code += "\tPUSH DX\n";

						// Pushing the value of arguments in the stack
						// to get back in the PROC later.

						int count = asmNames.size();
						while(count--) {
							code += "\tPUSH " + asmNames[count] + "\n";
						}

						code += "\tCALL " + funcName + "\n";
						temp = new_temp();
						code += "\tPOP " + temp + "\n";

						code += "\tPOP DX\n";
						code += "\tPOP CX\n";
						code += "\tPOP BX\n";
						code += "\tPOP AX\n";
						
						/*
							Need to collect the return value and store it in a new_temp.
							Then the new_temp is going to be passed as setAsm();
						*/
					}
				}
				else
				{
					error_count++;
					string msg = "Non function Identifier '" + curr_func->getName() + "' accessed";
					printError(error_file, log_file,  msg, line_count);
				}
			}

			$$ = new SymbolInfo($1->getName() + "(" + $3->getName() + ")",	_returnType);
			$$->setCode(code);
			$$->setAsm(temp);

			printLog(log_file, "factor : ID LPAREN argument_list RPAREN", $$->getName(), line_count);
		}
		| LPAREN expression RPAREN
		{
			$$ = new SymbolInfo("(" + $2->getName() + ")",	$2->getType() );
			$$->setCode($2->getCode());
			$$->setAsm($2->getAsm());

			printLog(log_file, "factor : LPAREN expression RPAREN", $$->getName(), line_count);
		}
		| CONST_INT
		{
			$$ = yylval.syminfo;
			$$->setAsm(yylval.syminfo->getName());
			
			printLog(log_file, "factor : CONST_INT", $$->getName(), line_count);
		}
		| CONST_FLOAT
		{
			$$ = yylval.syminfo;
			$$->setAsm(yylval.syminfo->getName());

			printLog(log_file, "factor : CONST_FLOAT", $$->getName(), line_count);
		}
		| variable INCOP
		{
			$$ = new SymbolInfo($1->getName() + "++",	$1->getType());

			string code = "";
			string temp = new_temp();
			string var_code = $1->getCode();
			string var_asm = $1->getAsm();

			code += var_code;
			code += "\tMOV AX, " + var_asm + "\n";
			code += "\tMOV " + temp + ", AX\n";
			code += "\tINC " + var_asm + "\n";

			$$->setCode(code);
			$$->setAsm(temp);

			printLog(log_file, "factor : variable INCOP", $$->getName(), line_count);
		}
		| variable DECOP
		{
			$$ = new SymbolInfo($1->getName() + "--",	$1->getType());

			string code = "";
			string temp = new_temp();
			string var_code = $1->getCode();
			string var_asm = $1->getAsm();

			code += var_code;
			code += "\tMOV AX, " + var_asm + "\n";
			code += "\tMOV " + temp + ", AX\n";
			code += "\tDEC " + var_asm + "\n";

			$$->setCode(code);
			$$->setAsm(temp);

			printLog(log_file, "factor : variable DECOP", $$->getName(), line_count);
		}
	;


argument_list :	arguments
				{
					$$ = $1;
					printLog(log_file, "argument_list : arguments", $$->getName(), line_count);
				}
				|
				{
					$$ = new SymbolInfo("", "void");
					$$->setAsm("");
					printLog(log_file, "argument_list : ", $$->getName(), line_count);
				}
			;


arguments : arguments COMMA logic_expression
			{
				string argNames = $1->getName() + "," + $3->getName();
				string argTypes = $1->getType() + "," + $3->getType();
				string asmNames = $1->getAsm()	+ "," + $3->getAsm();

				string code = $1->getCode() + $3->getCode();

				$$ = new SymbolInfo(argNames, argTypes);
				$$->setCode(code);
				$$->setAsm(asmNames);

				printLog(log_file, "arguments : arguments COMMA logic_expression", $$->getName(), line_count);
			}
			| logic_expression
			{
				$$ = $1;
				printLog(log_file, "arguments : logic_expression", $$->getName(), line_count);
			}
		;


%%
int main(int argc,char *argv[])
{
    inputFile = fopen(argv[1], "r");

	if(inputFile == nullptr) 
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}

    log_file = fopen("log.txt", "w");
    error_file = fopen("error.txt", "w");

	yyin = inputFile;
	yyparse();

	st.printAllScope_(log_file);
	fprintf(log_file, "Total lines: %d\n", line_count);
	fprintf(log_file, "Total errors: %d\n", error_count);

	fclose(log_file);
	fclose(error_file);

	return 0;
}
