#include <iostream>
#include "1705066_ScopeTable.h"

using namespace std;


class SymbolTable {

    private:
        ScopeTable* currentScope;
    
    public:

        void enterScope(int bucketSize) {
            ScopeTable* newScope;
            newScope = new ScopeTable(bucketSize);

            newScope->setParentScope(currentScope);
            currentScope = newScope;
        }

        void exitScope() {
            ScopeTable *temp = currentScope;
            currentScope = temp->getParentScope();
            // ??? should I ?
            delete temp;
        }

        bool insert(string symbol, string type) {
            return currentScope->insert(symbol, type);
        }

        bool remove(string symbol) {
            return currentScope->deleteSymbol(symbol);
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
            return ret;
        }


};