/*
This file has been modified for
C styled output format and the 
command output has been commented.
*/

#include <iostream>
using namespace std;

class SymbolInfo {

    private:
        string name, type;
        SymbolInfo *next;

    public:
        SymbolInfo() {
            name = "";
            type = "";
            next = nullptr;
        }

        SymbolInfo(string _name, string _type) {
            name = _name;
            type = _type;
            next = nullptr;
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

        void setNext(SymbolInfo* _next) {
            next = _next;
        }

        SymbolInfo* getNext() {
            return next;
        }

        void print() {
            cout << "< " << name << " : " << type << " >";
        }

        void print_(FILE *fp) {
            fprintf(fp, "< %s : %s>", name.c_str(), type.c_str());
        } 

};

/*
    Written by @fazledyn at 00:21 - 14-03-2020
*/