package offline2.problem2;

public class Lang_Python extends Language {

    Lang_Python() {
        this.parser = new Parser_Python();
        this.aesthetics = new Aesthetics_Python();
    }

    @Override
    public String toString() {
        return "Python";
    }

}
