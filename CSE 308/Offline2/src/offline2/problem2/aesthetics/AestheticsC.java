package offline2.problem2.aesthetics;

import offline2.problem2.font.Font;
import offline2.problem2.font.CourierNew;

public class AestheticsC implements Aesthetics {

    @Override
    public Font getFont() {
        return new CourierNew();
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
