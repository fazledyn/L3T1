package offline2.problem2.language;

import offline2.problem2.aesthetics.AestheticsCpp;
import offline2.problem2.parser.ParserCpp;

public class Cpp extends Language {

    public Cpp() {
        this.parser = new ParserCpp();
        this.aesthetics = new AestheticsCpp();
    }

    @Override
    public String toString() {
        return "C++";
    }

}
