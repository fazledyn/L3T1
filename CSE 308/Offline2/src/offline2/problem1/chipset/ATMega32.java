package offline2.problem1.chipset;

import offline2.problem1.controller.Buttons;
import offline2.problem1.display.LCD;
import offline2.problem1.identification.RFID;
import offline2.problem1.internet.GSM;
import offline2.problem1.internet.WiFi;
import offline2.problem1.storage.SDCard;

public class ATMega32 extends Chipset {

    @Override
    public String chipName() {
        return "ATMega32";
    }

    public ATMega32(String internet) throws Exception {
        display = new LCD();
        idCard = new RFID();
        storage = new SDCard();
        controller = new Buttons();

        switch (internet.toLowerCase()) {

            case "wifi":
                connection = new WiFi();
                break;

            case "gsm":
                connection = new GSM();
                break;

            default:
                connection = null;
                throw new Exception(internet + " is not available with " + this.chipName());
        }
    }

}
