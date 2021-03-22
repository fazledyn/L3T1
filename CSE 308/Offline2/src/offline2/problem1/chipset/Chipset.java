package offline2.problem1.chipset;

import offline2.problem1.controller.Controller;
import offline2.problem1.display.Display;
import offline2.problem1.identification.IdentificationCard;
import offline2.problem1.internet.InternetConnection;
import offline2.problem1.storage.Storage;

public abstract class Chipset {

    protected InternetConnection connection;
    protected IdentificationCard idCard;
    protected Controller controller;
    protected Storage storage;
    protected Display display;

    public void printChipsetInfo() {
        System.out.println("Chipset: " + chipName());
        System.out.println("Internet: " + connection.connectionType());
        System.out.println("Controller: " + controller.controllerName());
        System.out.println("Storage: " + storage.storageName());
        System.out.println("Display: " + display.displayName());
        System.out.println("Identification: " + idCard.cardType());
    }

    public abstract String chipName();

    public InternetConnection getConnection() {
        return connection;
    }

    public IdentificationCard getIdCard() {
        return idCard;
    }

    public Controller getController() {
        return controller;
    }

    public Storage getStorage() {
        return storage;
    }

    public Display getDisplay() {
        return display;
    }


}
