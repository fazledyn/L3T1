package offline2.problem2;

public class Lang_Cpp extends Language {

    Lang_Cpp() {
        this.parser = new Parser_Cpp();
        this.aesthetics = new Aesthetics_Cpp();
    }

    @Override
    public String toString() {
        return "C++";
    }

}
