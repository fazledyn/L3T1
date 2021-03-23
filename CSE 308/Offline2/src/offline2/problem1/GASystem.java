package offline2.problem1;

import offline2.problem1.chipset.Chipset;
import offline2.problem1.webserver.WebServer;
import offline2.problem1.weight.WeightMeasurer;


public class GASystem {

    private final Chipset chipset;
    private final WebServer webServer;
    private final WeightMeasurer weightMeasurer;

    public GASystem(Chipset chipset, WebServer webServer, WeightMeasurer weightMeasurer) {
        this.chipset = chipset;
        this.webServer = webServer;
        this.weightMeasurer = weightMeasurer;
    }

    public Chipset getChipset() {
        return chipset;
    }

    public void printInfo() {
        System.out.println(" - - TeaGAS System Info - - ");
        chipset.printChipsetInfo();
        System.out.println("Webserver: " + webServer.serverName());
        System.out.println("Weight Measurer: " + weightMeasurer.measurerType());
    }

}
