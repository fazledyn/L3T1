package offline2.problem2.language;

import offline2.problem2.aesthetics.AestheticsC;
import offline2.problem2.parser.ParserC;

public class C extends Language {

    public C() {
        this.parser = new ParserC();
        this.aesthetics = new AestheticsC();
    }

    @Override
    public String toString() {
        return "C";
    }

}
