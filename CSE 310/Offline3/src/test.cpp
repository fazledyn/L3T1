#include "bits/stdc++.h"
#include "lib/util.h"

using namespace std;


int main() {

    string str = "int,float,char";
    vector <string> vec = splitString(str, ' ');

    cout << "vec: " << vec[0] << endl;
    return 0;
}