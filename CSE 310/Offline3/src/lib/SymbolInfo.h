/*
    This file has been modified for
    C styled output format and the
    command output has been commented.
*/

#include <iostream>
#include <vector>
#include "Parameter.h"
using namespace std;


class SymbolInfo {

    private:
        string name, type;
        SymbolInfo *next;
        
        int size;                       // Size variable for Array
        vector<Parameter> paramList;    // Function identifier fields
        bool defined;

    public:
        SymbolInfo() {
            name = "";
            type = "";
            size = 0;
            next = nullptr;
            defined = false;
        }

        SymbolInfo(string _name, string _type) {
            name = _name;
            type = _type;
            size = 0;
            next = nullptr;
            defined = false;
        }

        SymbolInfo(const SymbolInfo &si) {
            name = si.name;
            type = si.type;
            size = si.size;
            next = si.next;
            paramList = si.paramList;
            defined = si.defined;
        }

        void setAsArray(string _name, string _type, int _size) {
            name = _name;
            type = _type;
            size = _size;
            next = nullptr;
            defined = false;
        }

        void setAsFunction(string _name, string _type, vector<Parameter> _paramList) {
            name = _name;
            type = _type;
            size = -1;
            paramList = _paramList;
        }

        void setName(string _name) {
            name = _name;
        }

        void setType(string _type) {
            type = _type;
        }

        string getName() {
            return name;
        }

        string getType() {
            return type;
        }

        void setSize(int _size) {
            size = _size;
        }

        int getSize() {
            return size;
        }

        void setNext(SymbolInfo* _next) {
            next = _next;
        }

        SymbolInfo* getNext() {
            return next;
        }

        void addParam(string paramName, string paramType) {
            Parameter param(paramName, paramType);
            paramList.push_back(param);
        }

        vector<Parameter> getParamList() {
            return paramList;
        }

        int totalParam() {
            return paramList.size();
        }

        bool isFunction() {
            return (size == -1);
        }

        bool isArray() {
            return (size > 0);
        }

        bool isVariable() {
            return (size == 0);
        }

        void setDefined(bool _defined) {
            defined = _defined;
        }

        bool isDefined() {
            return defined;
        }

        void print() {
            cout << "< " << name << " : " << type << " >";
        }

        void print_(FILE *fp) {
            fprintf(fp, "< %s : %s >", name.c_str(), type.c_str());
        }

};

/*
    Written by @fazledyn at 00:21 - 14-03-2020
*/
