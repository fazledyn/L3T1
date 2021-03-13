#include <iostream>
#include "1705066_ScopeTable.h"

using namespace std;


class SymbolTable {

    private:
        ScopeTable* currentScope;
        int bucketSize;
    
    public:

        SymbolTable(int _bucketSize) {
            bucketSize = _bucketSize;
            currentScope = new ScopeTable(bucketSize);
        }

        void enterScope() {
            ScopeTable* newScope;
            
            newScope = new ScopeTable(bucketSize, currentScope->numberOfChild());
            currentScope->increaseChild();
            newScope->setParentScope(currentScope);
            
            currentScope = newScope;
            cout << "New ScopeTable with id " << currentScope->getId() << " created" << endl;
            cout << endl;
        }

        void exitScope() {
            ScopeTable *temp = currentScope;
            currentScope = temp->getParentScope();
            cout << "ScopeTable with id " << temp->getId() << " removed" << endl;
            cout << endl;
            delete temp;
        }

        bool insert(string symbol, string type) {
            return currentScope->insert(symbol, type);
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
            cout << "Not found" << endl << endl;
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

};