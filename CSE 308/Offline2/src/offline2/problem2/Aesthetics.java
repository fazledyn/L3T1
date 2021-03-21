package offline2.problem2;

public abstract class Aesthetics {

    protected Font font;
    protected String style;
    protected String color;

    public void load() {
        System.out.println("Font: " + font.toString());
        System.out.println("Style: " + style);
        System.out.println("Color: " + color);
    }

}
