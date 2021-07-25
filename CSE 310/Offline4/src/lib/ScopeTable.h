/*
This file has been modified for
C styled output format and the
command output has been commented.
*/

#include <iostream>
#include "SymbolInfo.h"

using namespace std;

class ScopeTable
{

private:
    SymbolInfo *hashTable;
    ScopeTable *parentScope;

    int bucketSize;
    int id, nChild;

    int hash(string key)
    {
        int sum = 0;
        for (int i = 0; i < key.length(); i++)
        {
            sum += int(key.at(i));
        }
        return sum % bucketSize;
    }

public:
    /*
            For inner scopes, the number of existing child of parent must be passed
            to the newScope. This will generate the ID for currentScope.

            And then, the increaseChild() method of parent must be called. Since the
            currentScope has now become the parent's newest child. And then, the parent
            pointer must be set.
        */
    ScopeTable(int _bucketSize, int _nSibling = 0)
    {
        id = _nSibling + 1, nChild = 0;
        parentScope = nullptr;

        bucketSize = _bucketSize;
        hashTable = new SymbolInfo[_bucketSize];
    }

    ~ScopeTable() {}

    void setParentScope(ScopeTable *_parentScope) { parentScope = _parentScope; }
    ScopeTable *getParentScope() { return parentScope; }

    void increaseChild() { ++nChild; }
    int numberOfChild() { return nChild; }

    string getId()
    {
        if (parentScope != nullptr)
        {
            return parentScope->getId() + "." + to_string(id);
        }
        return to_string(id);
    }

    string getId_()
    {
        if (parentScope != nullptr)
        {
            return parentScope->getId_() + to_string(id);
        }
        return to_string(id);
    }

    bool insert(string symbol, string type, string gname)
    {
        int index = hash(symbol);
        int col = 0;
        if (lookup(symbol) == nullptr)
        {
            if (hashTable[index].getName() == "")
            {
                hashTable[index].setName(symbol);
                hashTable[index].setType(type);
                hashTable[index].setAsm(gname);
            }
            else
            {
                SymbolInfo *curr = &hashTable[index];
                col++;
                while (curr->getNext() != nullptr)
                {
                    col++;
                    curr = curr->getNext();
                }
                SymbolInfo *temp;
                temp = new SymbolInfo(symbol, type);
                temp->setAsm(gname);
                curr->setNext(temp);
            }
            //    cout << "Inserted in ScopeTable# " << getId() << " at position " << index << ", " << col << endl;
            //    cout << endl;
            return true;
        }
        else
        {
            //    cout << "<" << symbol << " ," << type << "> already exists in current ScopeTable" << endl << endl;
            return false;
        }
    }

    bool insertSymbolInfo(SymbolInfo symbol)
    {

        int index = hash(symbol.getName());
        int col = 0;

        if (lookup(symbol.getName()) == nullptr)
        {
            if (hashTable[index].getName() == "")
            {
                hashTable[index] = symbol;
            }
            else
            {
                SymbolInfo *curr = &hashTable[index];
                col++;
                while (curr->getNext() != nullptr)
                {
                    col++;
                    curr = curr->getNext();
                }
                SymbolInfo *temp;
                temp = new SymbolInfo(symbol);
                curr->setNext(temp);
            }
            //    cout << "Inserted in ScopeTable# " << getId() << " at position " << index << ", " << col << endl;
            //    cout << endl;
            return true;
        }
        else
        {
            //    cout << "<" << symbol << " ," << type << "> already exists in current ScopeTable" << endl << endl;
            return false;
        }
    }

    SymbolInfo *lookup(string symbol)
    {

        SymbolInfo *ret = nullptr;
        int index = hash(symbol);
        int col = 0;

        if (hashTable[index].getName() == symbol)
        {
            return &hashTable[index];
        }
        else
        {
            SymbolInfo *curr = &hashTable[index];
            while (curr->getNext() != nullptr)
            {
                curr = curr->getNext();
                col++;
                if (curr->getName() == symbol)
                {
                    return curr;
                }
            }
            return ret;
        }
    }

    /*
            During removable/deletion, it's advisable to look for the symbol beforehand.
            It solves two problem- if the element doesn't exist, it doesn't need to do
            much. And also, works as a protective wrapper.
        */

    bool remove(string symbol)
    {
        int index = hash(symbol);
        int col = 0;

        if (lookup(symbol) == nullptr)
        {
            return false;
        }
        else
        {
            SymbolInfo *curr = &hashTable[index];
            SymbolInfo *prev = nullptr;

            if (hashTable[index].getName() == symbol)
            {
                hashTable[index].setName("");
                hashTable[index].setType("");
            }
            else
            {
                while (curr->getName() != symbol)
                {
                    prev = curr;
                    curr = prev->getNext();
                    col++;
                }
                prev->setNext(curr->getNext());
                delete curr;
            }
            return true;
        }
    }

    void print()
    {
        cout << endl
             << "ScopeTable # " << this->getId() << endl;
        for (int i = 0; i < bucketSize; i++)
        {
            cout << i << " -->  ";
            SymbolInfo *curr = &hashTable[i];

            while (curr != nullptr)
            {
                if (curr->getName() != "")
                    curr->print();
                if (curr->getNext() != nullptr)
                    cout << "  ";
                curr = curr->getNext();
            }
            cout << endl;
        }
        cout << endl;
    }

    void print_(FILE *fp)
    {
        fprintf(fp, "\nScopeTable # %s", this->getId().c_str());

        for (int i = 0; i < bucketSize; i++)
        {
            SymbolInfo *curr = &hashTable[i];

            if (curr->getName() != "")
                fprintf(fp, "\n%d -->  ", i);

            while (curr != nullptr)
            {
                if (curr->getName() != "")
                {
                    curr->print_(fp);
                }
                if (curr->getNext() != nullptr)
                {
                    fprintf(fp, " ");
                }
                curr = curr->getNext();
            }
        }
        fprintf(fp, "\n");
    }
};

/*
    Written by @fazledyn at 00:21 - 14-03-2020
*/
