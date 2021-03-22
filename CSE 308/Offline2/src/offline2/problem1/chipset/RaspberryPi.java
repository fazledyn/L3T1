package offline2.problem1.chipset;

import offline2.problem1.controller.Buttons;
import offline2.problem1.controller.Controller;
import offline2.problem1.controller.TouchScreen;
import offline2.problem1.display.LCD;
import offline2.problem1.identification.RFID;
import offline2.problem1.internet.Ethernet;
import offline2.problem1.internet.GSM;
import offline2.problem1.internet.WiFi;
import offline2.problem1.storage.SDCard;
import offline2.problem1.storage.Storage;

public class RaspberryPi extends Chipset implements Storage {
    @Override
    public String chipName() {
        return "Raspberry Pi";
    }

    @Override
    public String storageName() { return "Raspberry Pi Storage"; }

    public RaspberryPi(String internet) throws Exception {

        storage = this;
        idCard = new RFID();
        display = new TouchScreen();
        controller = (Controller) display;

        switch (internet.toLowerCase()) {
            case "wifi":
                connection = new WiFi();
                break;

            case "gsm":
                connection = new GSM();
                break;

            case "ethernet":
                connection = new Ethernet();
                break;

            default:
                connection = null;
                throw new Exception(internet + " is not available with " + this.chipName());
        }

    }
}
