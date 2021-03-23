package offline2.problem1.chipset;

import offline2.problem1.controller.*;
import offline2.problem1.identification.*;
import offline2.problem1.internet.*;
import offline2.problem1.storage.*;


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
