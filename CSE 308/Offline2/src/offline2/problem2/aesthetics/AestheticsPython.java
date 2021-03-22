package offline2.problem2.aesthetics;

import offline2.problem2.font.Font;
import offline2.problem2.font.Consolas;

public class AestheticsPython implements Aesthetics {

    @Override
    public Font getFont() {
        return new Consolas();
    }

    @Override
    public String getStyle() {
        return "normal";
    }

    @Override
    public String getColor() {
        return "blue";
    }

}
