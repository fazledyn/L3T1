package offline2.problem2.language;

import offline2.problem2.aesthetics.Aesthetics;
import offline2.problem2.parser.Parser;

public abstract class Language {

    protected Parser parser;
    protected Aesthetics aesthetics;

    public abstract String toString();

    public void loadSettings() {
        System.out.println("\nCurrent Language: " + toString());
        parser.parse();
        System.out.println("Font: " + aesthetics.getFont());
        System.out.println("Style: " + aesthetics.getStyle() + ", Color: " + aesthetics.getColor() + "\n");
    }

}
