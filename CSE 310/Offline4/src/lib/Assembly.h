#include <iostream>
#include <vector>
using namespace std;

#ifndef ASSEMBLY
#define ASSEMBLY


void optimizeCode()
{
    cout << "Nothing here yet" << endl;
}

void appendLine(FILE *asmFile, string line)
{
    fprintf(asmFile, "%s\n", line.c_str());
}

void initAsmFile(FILE *asmFile, vector<pair<string, int>> globalVarList)
{
    appendLine(asmFile, ".MODEL SMALL");
    appendLine(asmFile, ".STACK 100h");
    appendLine(asmFile, "");
    appendLine(asmFile, ".DATA");
    appendLine(asmFile, "print_var DW ?");

    for (int i = 0; i < globalVarList.size(); i++) {
        if (globalVarList[i].second == 0) {
            appendLine(asmFile, globalVarList[i].first + " DW ?");
        }
        else {
            appendLine(asmFile, globalVarList[i].first + " DW " + to_string(globalVarList[i].second) + " DUP(?)");
        }
    }

    appendLine(asmFile, "");
    appendLine(asmFile, ".CODE");
}

void addPrintProc(FILE *asmFile)
{
    appendLine(asmFile, "; storing the print value in AX");
    appendLine(asmFile, "PRINTLN PROC NEAR");
    appendLine(asmFile, "\tPUSH AX");
    appendLine(asmFile, "\tPUSH BX");
    appendLine(asmFile, "\tPUSH CX");
    appendLine(asmFile, "\tPUSH DX");
    appendLine(asmFile, "\t");

    appendLine(asmFile, "\tMOV AX, print_var");
    appendLine(asmFile, "\tOR AX, AX");
    appendLine(asmFile, "\tJGE @END_IF1");
    appendLine(asmFile, "\tPUSH AX");
    appendLine(asmFile, "\tMOV DL, '-'");
    appendLine(asmFile, "\tMOV AH, 2");
    appendLine(asmFile, "\tINT 21H");
    appendLine(asmFile, "\tPOP AX");
    appendLine(asmFile, "\tNEG AX");
    appendLine(asmFile, "");

    appendLine(asmFile, "@END_IF1:");
    appendLine(asmFile, "\tXOR CX, CX");
    appendLine(asmFile, "\tMOV BX, 10D");
    appendLine(asmFile, "");

    appendLine(asmFile, "@REPEAT:");
    appendLine(asmFile, "\tXOR DX, DX");
    appendLine(asmFile, "\tDIV BX");
    appendLine(asmFile, "\tPUSH DX");
    appendLine(asmFile, "\tINC CX");
    appendLine(asmFile, "\tOR AX, AX");
    appendLine(asmFile, "\tJNE @REPEAT");
    appendLine(asmFile, "\tMOV AH, 2");
    appendLine(asmFile, "");

    appendLine(asmFile, "@PRINT_LOOP:");
    appendLine(asmFile, "\tPOP DX");
    appendLine(asmFile, "\tOR DL, 30H");
    appendLine(asmFile, "\tINT 21H");
    appendLine(asmFile, "\tLOOP @PRINT_LOOP");

    appendLine(asmFile, "\tMOV DL, 0DH");
    appendLine(asmFile, "\tMOV AH, 2");
    appendLine(asmFile, "\tINT 21H");

    appendLine(asmFile, "\tMOV DL, 0AH");
    appendLine(asmFile, "\tMOV AH, 2");
    appendLine(asmFile, "\tINT 21H");

    appendLine(asmFile, "\tPOP DX");
    appendLine(asmFile, "\tPOP CX");
    appendLine(asmFile, "\tPOP BX");
    appendLine(asmFile, "\tPOP AX");
    
    appendLine(asmFile, "\tRET");
    appendLine(asmFile, "");

    appendLine(asmFile, "PRINTLN ENDP");
}

#endif