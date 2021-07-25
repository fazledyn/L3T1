#include "bits/stdc++.h"
#include "Parameter.h"
using namespace std;


void printLog(FILE *file, string rule, string token, int lineCount)
{
    fprintf(file, "Line %d: %s", lineCount, rule.c_str());
    fprintf(file, "\n\n%s\n\n", token.c_str());
}

void printError(FILE *file1, FILE *file2, string errorText, int lineCount)
{
    fprintf(file1, "Error at line %d: %s\n\n", lineCount, errorText.c_str());
    fprintf(file2, "Error at line %d: %s\n\n", lineCount, errorText.c_str());
}

vector<string> splitString(string line, char delim)
{
    stringstream ss(line);
    vector<string> tokens;
    string intermediate;

    while (getline(ss, intermediate, delim))
    {
        tokens.push_back(intermediate);
    }
    return tokens;
}

bool isArray(string line)
{
    if ((line.find("[") != string::npos) || (line.find("]") != string::npos))
    {
        return true;
    }
    return false;
}

string extractArrayName(string line)
{
    stringstream ss(line);
    string arrayName;

    getline(ss, arrayName, '[');
    return arrayName;
}

int extractArraySize(string line)
{
    stringstream ss(line);
    string token;

    while (getline(ss, token, '['))
    {
    }
    stringstream ss2(token);
    getline(ss2, token, ']');

    return stoi(token);
}

bool isInvalidArrayElement(string line)
{
    stringstream ss(line);
    string token;

    while (getline(ss, token, '[')) {}

    stringstream ss2(token);
    getline(ss2, token, ']');

    float arraySizeFloat = stof(token);
    int arraySizeInt = extractArraySize(line);

    return (arraySizeFloat != arraySizeInt);
}

vector<Parameter> extractParameters(string line)
{
    vector<Parameter> returnList;
    vector<string> paramPair = splitString(line, ',');
    vector<string> typeAndName;

    for (string currentParam : paramPair)
    {
        typeAndName = splitString(currentParam, ' ');
        Parameter p(typeAndName[1], typeAndName[0]);
        returnList.push_back(p);
    }
    return returnList;
}

vector<string> extractParameterType(string line)
{
    vector<string> typeAndName, returnList;
    vector<string> paramPair = splitString(line, ',');

    for (string currentParam : paramPair)
    {
        typeAndName = splitString(currentParam, ' ');
        returnList.push_back(typeAndName[0]);
    }
    return returnList;
}
