package offline2.problem2;

public class Lang_C extends Language {

    Lang_C() {
        this.parser = new Parser_C();
        this.aesthetics = new Aesthetics_C();
    }

    @Override
    public String toString() {
        return "C";
    }

}
