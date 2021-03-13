#include <iostream>
#include <filesystem>
#include "1705066_SymbolTable.h"

using namespace std;


int main(int argc, char const *argv[]) {

    freopen("input.txt",  "r", stdin);
    freopen("output.txt", "w", stdout);

    int nBucket;
    cin >> nBucket;

    SymbolTable st(nBucket);
    string choice, symbol, type;
    int i = 1;

    while (cin >> choice) {

        if (choice == "I") {
            cin >> symbol >> type;
            cout << choice << " " << symbol << " " << type << endl;
            cout << endl;
            st.insert(symbol, type);
        }
        else if (choice == "L") {
            cin >> symbol;
            cout << choice << " " << symbol << endl;
            cout << endl;
            st.lookup(symbol);
        }
        else if (choice == "D") {
            cin >> symbol;
            cout << choice <<  " " << symbol << endl;
            cout << endl;
            st.remove(symbol);
        }
        else if (choice == "P") {

            string tableOption;
            cin >> tableOption;

            cout << choice << " " << tableOption << endl;
            cout << endl;

            if (tableOption == "A") 
                st.printAllScope();
            else if (tableOption == "C")
                st.printCurrentScope();
        
        }
        else if (choice == "S") {
            cout << choice << endl;
            cout << endl;
            st.enterScope();
        }
        else if (choice == "E") {
            cout << choice << endl;
            cout << endl;
            st.exitScope();
        }
    }

    return 0;
}
