#include <iostream>
#include "1705066_SymbolInfo.h"

using namespace std;

class ScopeTable {

    private:
        SymbolInfo *hashTable;
        ScopeTable *parentScope;

        int bucketSize;
        int id, nChild;

        int hash(string key) {
            int sum = 0;
            for (int i=0; i < key.length(); i++) {
                sum += int(key.at(i));
            }
            return sum % bucketSize;
        }
    
    public:

        ScopeTable(int _bucketSize, int _nSibling = 0) {
            id = _nSibling + 1, nChild = 0;
            parentScope = nullptr;

            bucketSize = _bucketSize;
            hashTable = new SymbolInfo[_bucketSize];
            cout << "ScopeTable cons called\n";
        }

        ~ScopeTable(){
            cout << "ScopeTable dest called\n";
        }

        void setParentScope(ScopeTable* _parentScope) { parentScope = _parentScope; }
        ScopeTable* getParentScope() {return parentScope; }

        void increaseChild() { ++nChild; }
        int numberOfChild() { return nChild; }
        
        string getId() {
            if (parentScope != nullptr) {
                return parentScope->getId() + "." + to_string(id);
            }
            return to_string(id);
        }
        
        bool insert(string symbol, string type) {
            int index = hash(symbol);
            if (lookup(symbol) == nullptr) {
                // Gotta insert
                if (hashTable[index].getName() == "") {
                    hashTable[index].setName(symbol);
                    hashTable[index].setType(type);
                }
                else {
                    SymbolInfo* curr = &hashTable[index];
                    while(curr->getNext() != nullptr) {
                        curr = curr->getNext();
                    }
                    SymbolInfo *temp;
                    temp = new SymbolInfo(symbol, type);
                    curr->setNext(temp);
                }
                return true;
            }
            else {
                return false;
            }
        }

        SymbolInfo* lookup(string symbol) {
            SymbolInfo *ret = nullptr;
            int index = hash(symbol);

            if (hashTable[index].getName() == symbol) {
                return &hashTable[index];
            }
            else {
                SymbolInfo *curr = &hashTable[index];
                while (curr->getNext() != nullptr) {
                    curr = curr->getNext();
                    if (curr->getName() == symbol) {
                        return curr;
                    }
                }
                return ret;
            }
        }

        bool deleteSymbol(string symbol) {
            int index = hash(symbol);

            if (lookup(symbol) == nullptr) {
                return false;
            }
            else {
                SymbolInfo* curr = &hashTable[index];
                SymbolInfo* prev = nullptr;

                if (hashTable[index].getName() == symbol) {
                    hashTable[index].setName("");
                    hashTable[index].setType("");
                }
                else {
                    while (curr->getName() != symbol) {
                        prev = curr;
                        curr = prev->getNext();
                    }
                    prev->setNext(curr->getNext());
                    delete curr;
                }
                return true;
            }
        }

        void print() {
            cout << endl;    
            for (int i = 0; i < bucketSize; i++) {
                cout << i << ": ";
                SymbolInfo *curr = &hashTable[i];
                
                while (curr != nullptr) {
                    cout << curr->getName();
                    if (curr->getNext() != nullptr)
                        cout << ", ";
                    curr = curr->getNext();
                }
                cout << endl;
            }
        }

};