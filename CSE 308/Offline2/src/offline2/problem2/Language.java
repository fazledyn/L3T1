package offline2.problem2;

public abstract class Language {

    protected Parser parser;
    protected Aesthetics aesthetics;

    public abstract String toString();

    public void loadSettings() {
        System.out.println("\nCurrent Language: " + toString());
        parser.parse();
        aesthetics.load();
        System.out.println();
    }

}
