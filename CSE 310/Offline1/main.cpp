#include <iostream>
#include "1705066_ScopeTable.h"

using namespace std;


int main(int argc, char const *argv[]) {

    ScopeTable st(10);

    st.insert("a", "int");
    st.insert("num", "float");
    st.insert("mun", "str");
    st.insert("nChild", "int");
    st.insert("popeye", "str");
    st.insert("abba", "str");
    st.insert("baba", "int");

    st.print();
    st.deleteSymbol("nChild");
    st.print();

    return 0;
}
