#include "bits/stdc++.h"
using namespace std;


void printLog(FILE* file, string rule, string token, int lineCount)
{
    fprintf(file, "At line no: %d %s", lineCount, rule.c_str());
    fprintf(file, "\n\n%s\n\n", token.c_str());
}


void printError(FILE* file, string errorText, int lineCount) {
    fprintf(file, "Error at line %d: %s\n\n", lineCount, errorText.c_str());
}