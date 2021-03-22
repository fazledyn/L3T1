package offline2.problem1;

import offline2.problem1.chipset.Chipset;
import offline2.problem1.webserver.WebServer;
import offline2.problem1.weight.WeightMeasurer;

import java.util.Locale;


public class SystemFactory {

    public GASystem buildSystem(String packageName, String internet, String webServerName) throws Exception {

        packageName = packageName.toLowerCase(Locale.ROOT);

        ChipsetFactory csf = new ChipsetFactory();
        WebServerFactory wsf = new WebServerFactory();
        WeightMeasurerFactory wmf = new WeightMeasurerFactory();

        Chipset chipset;
        WebServer webServer;
        WeightMeasurer weightMeasurer;

        if (packageName.equals("silver")) {
            chipset = csf.makeChipset("ATMega32", internet);
            weightMeasurer = wmf.selectMeasurer("sensor");
        }
        else if (packageName.equals("gold")) {
            chipset = csf.makeChipset("ArduinoMega", internet);
            weightMeasurer = wmf.selectMeasurer("module");
        }
        else if (packageName.equals("diamond")) {
            chipset = csf.makeChipset("RaspberryPi", internet);
            weightMeasurer = wmf.selectMeasurer("sensor");
        }
        else if (packageName.equals("platinum")) {
            chipset = csf.makeChipset("RaspberryPi", internet);
            weightMeasurer = wmf.selectMeasurer("module");
        }
        else {
            chipset = null;
            weightMeasurer = null;
        }

        webServer = wsf.makeWebServer(webServerName);
        return new GASystem(chipset, webServer, weightMeasurer);
    }

}
