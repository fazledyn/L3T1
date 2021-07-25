#include "bits/stdc++.h"
using namespace std;

#ifndef ASSEMBLY
#define ASSEMBLY

void print_to_file(FILE *asm_file, string line)
{
    fprintf(asm_file, "%s\n", line.c_str());
}

void optimize_code(FILE *asm_file)
{
    vector<string> code_list;
    vector<string> token_up;
    vector<string> token_down;

    ifstream file_in("code.asm");
    string temp;

    while (getline(file_in, temp))
    {
        code_list.push_back(temp);
    }

    int line_count = code_list.size();

    for (int i = 0; i < line_count - 1; i++)
    {
        if ((code_list[i].size() < 4) || (code_list[i + 1].size() < 4))
        {
            print_to_file(asm_file, code_list[i]);
        }
        else if ((code_list[i].substr(1, 3) == "MOV") && (code_list[i + 1].substr(1, 3) == "MOV"))
        {
            stringstream ss_up(code_list[i]);
            stringstream ss_down(code_list[i + 1]);

            while (getline(ss_up, temp, ' '))
            {
                token_up.push_back(temp);
            }

            while (getline(ss_down, temp, ' '))
            {
                token_down.push_back(temp);
            }

            if ((token_up[1].substr(0, token_up[1].size() - 1) == token_down[2]) && (token_down[1].substr(0, token_down[1].size() - 1) == token_up[2]))
            {
                print_to_file(asm_file, code_list[i]);
                i++;
            }
            else
            {
                print_to_file(asm_file, code_list[i]);
            }

            token_up.clear();
            token_down.clear();
        }
        else
        {
            print_to_file(asm_file, code_list[i]);
        }
    }
}

void init_asm_file(FILE *asm_file, vector<pair<string, int>> globalVarList)
{
    string code = "";

    code += ".MODEL SMALL\n";
    code += ".STACK 100h\n";
    code += "\n";
    code += ".DATA\n";
    code += "print_var DW ?\n";

    print_to_file(asm_file, code);

    for (int i = 0; i < globalVarList.size(); i++)
    {
        if (globalVarList[i].second == 0)
        {
            print_to_file(asm_file, globalVarList[i].first + " DW ?");
        }
        else
        {
            print_to_file(asm_file, globalVarList[i].first + " DW " + to_string(globalVarList[i].second) + " DUP(?)");
        }
    }

    print_to_file(asm_file, "");
    print_to_file(asm_file, ".CODE");
}

void add_print_proc(FILE *asm_file)
{
    string code = "";

    code += "PRINTLN PROC NEAR\n";
    code += "\tPUSH AX\n";
    code += "\tPUSH BX\n";
    code += "\tPUSH CX\n";
    code += "\tPUSH DX\n";
    code += "\t\n";

    code += "\tMOV AX, print_var\n";
    code += "\tOR AX, AX\n";
    code += "\tJGE @END_IF1\n";
    code += "\tPUSH AX\n";
    code += "\tMOV DL, '-'\n";
    code += "\tMOV AH, 2\n";
    code += "\tINT 21H\n";
    code += "\tPOP AX\n";
    code += "\tNEG AX\n";
    code += "\n";

    code += "@END_IF1:\n";
    code += "\tXOR CX, CX\n";
    code += "\tMOV BX, 10D\n";
    code += "\n";

    code += "@REPEAT:\n";
    code += "\tXOR DX, DX\n";
    code += "\tDIV BX\n";
    code += "\tPUSH DX\n";
    code += "\tINC CX\n";
    code += "\tOR AX, AX\n";
    code += "\tJNE @REPEAT\n";
    code += "\tMOV AH, 2\n";
    code += "\n";

    code += "@PRINT_LOOP:\n";
    code += "\tPOP DX\n";
    code += "\tOR DL, 30H\n";
    code += "\tINT 21H\n";
    code += "\tLOOP @PRINT_LOOP\n";

    code += "\tMOV DL, 0DH\n";
    code += "\tMOV AH, 2\n";
    code += "\tINT 21H\n";

    code += "\tMOV DL, 0AH\n";
    code += "\tMOV AH, 2\n";
    code += "\tINT 21H\n";

    code += "\tPOP DX\n";
    code += "\tPOP CX\n";
    code += "\tPOP BX\n";
    code += "\tPOP AX\n";

    code += "\tRET\n";
    code += "\n";
    code += "PRINTLN ENDP\n";

    print_to_file(asm_file, code);
}

#endif