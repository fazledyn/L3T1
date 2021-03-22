package offline2.problem1;

import offline2.problem1.chipset.ATMega32;
import offline2.problem1.chipset.ArduinoMega;
import offline2.problem1.chipset.Chipset;
import offline2.problem1.chipset.RaspberryPi;

import java.util.Locale;


public class ChipsetFactory {

    public Chipset makeChipset(String chipsetName, String internet) throws Exception {

        chipsetName = chipsetName.toLowerCase(Locale.ROOT);

        if (chipsetName.equals("atmega32")) {
            return new ATMega32(internet);
        }
        else if (chipsetName.equals("arduinomega")) {
            return new ArduinoMega(internet);
        }
        else if (chipsetName.equals("raspberrypi")) {
            return new RaspberryPi(internet);
        }
        else {
            throw new Exception("Invalid Chipset");
        }
    }
}
