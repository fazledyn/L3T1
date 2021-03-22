package offline2.problem2.language;

import offline2.problem2.aesthetics.AestheticsPython;
import offline2.problem2.parser.ParserPython;

public class Python extends Language {

    public Python() {
        this.parser = new ParserPython();
        this.aesthetics = new AestheticsPython();
    }

    @Override
    public String toString() {
        return "Python";
    }

}
