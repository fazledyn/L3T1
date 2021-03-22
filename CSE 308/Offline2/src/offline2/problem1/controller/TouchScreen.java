package offline2.problem1.controller;

import offline2.problem1.display.Display;

public class TouchScreen implements Display, Controller {
    @Override
    public String controllerName() {
        return "Touch Screen";
    }

    @Override
    public String displayName() {
        return "Touch Screen";
    }
}
