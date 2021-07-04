int abc, def;

int foo(int a, int b) {
    int f;
    f = a - b;
    return f;
}

int main(){
    int x, y;
    x = 2;
    y = 3;
    x--;
    println(x);
    println(y);

    int p;
    p = foo(x, y);

    println(p);
}

