package offline2.problem2;

public class Aesthetics_C extends Aesthetics {

    Aesthetics_C() {
        font = new Font_CourierNew();
        style = "normal";
        color = "blue";
    }

    public void loadAesthetics() {
        System.out.println("Font used: " + font.toString());

    }

}
