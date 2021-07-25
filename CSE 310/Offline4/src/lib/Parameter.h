#include <iostream>
using namespace std;

#ifndef PARAMETER
#define PARAMETER

class Parameter
{
public:
    string name, type, global_name;

    Parameter(string _name, string _type)
    {
        name = _name;
        type = _type;
        global_name = "";
    }
};

#endif