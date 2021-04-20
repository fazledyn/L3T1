/*
    This file has been modified for
    C styled output format and the 
    command output has been commented.
*/

#include <iostream>
#include "ScopeTable.h"

using namespace std;

#ifndef SYMBOL_TABLE
#define SYMBOL_TABLE

class SymbolTable {

    private:
        ScopeTable* currentScope;
        int bucketSize;
    
    public:

        SymbolTable(int _bucketSize) {
            bucketSize = _bucketSize;
            currentScope = new ScopeTable(bucketSize);
        }

        /*
            For this enterScope() method, it's important to follow the procedure for
            newScope constructing method- described in its header file. First we create
            the newScope by passing the currrent number of siblings, increasing siblings,
            and assinging itself under new parent.
        */

        void enterScope() {
            ScopeTable* newScope;
            
            newScope = new ScopeTable(bucketSize, currentScope->numberOfChild());
            currentScope->increaseChild();
            newScope->setParentScope(currentScope);
            
            currentScope = newScope;
        //    cout << "New ScopeTable with id " << currentScope->getId() << " created" << endl;
        //    cout << endl;
        }

        void exitScope() {
            ScopeTable *temp = currentScope;
            currentScope = temp->getParentScope();
        //    cout << "ScopeTable with id " << temp->getId() << " removed" << endl;
        //    cout << endl;
            delete temp;
        }

        bool insert(string symbol, string type) {
            return currentScope->insert(symbol, type);
        }

        bool insertSymbolInfo(SymbolInfo symbol) {
            return currentScope->insertSymbolInfo(symbol);
        }

        bool remove(string symbol) {
            return currentScope->remove(symbol);
        }

        SymbolInfo* lookup(string symbol) {
            ScopeTable* curr = currentScope;
            SymbolInfo* ret = curr->lookup(symbol);
            
            if (ret != nullptr) {
                return ret;
            }
            else {
                while (curr->getParentScope() != nullptr) {
                    curr = curr->getParentScope();
                    ret = curr->lookup(symbol);
                    if (ret != nullptr) {
                        return ret;
                    }
                }
            }
        //    cout << "Not found" << endl << endl;
            return ret;
        }

        void printCurrentScope() {
            currentScope->print();          
        }

        void printAllScope() {
            ScopeTable *curr;
            curr = currentScope;

            while (curr != nullptr) {
                curr->print();
                curr = curr->getParentScope();
            }
        }

        void printAllScope_(FILE *fp) {
            ScopeTable *curr;
            curr = currentScope;

            while (curr != nullptr) {
                curr->print_(fp);
                curr = curr->getParentScope();
            }
        }

};

#endif // SYMBOL_TABLE

/*
    Written by @fazledyn at 00:21 - 14-03-2020
*/