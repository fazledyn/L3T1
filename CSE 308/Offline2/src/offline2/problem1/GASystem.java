package offline2.problem1;

import offline2.problem1.chipset.Chipset;
import offline2.problem1.webserver.WebServer;
import offline2.problem1.weight.WeightMeasurer;


public class GASystem {

    private Chipset chipset;
    private WebServer webServer;
    private WeightMeasurer weightMeasurer;

    public GASystem(Chipset chipset, WebServer webServer, WeightMeasurer weightMeasurer) {
        this.chipset = chipset;
        this.webServer = webServer;
        this.weightMeasurer = weightMeasurer;
    }

    public Chipset getChipset() {
        return chipset;
    }

    public WebServer getWebServer() {
        return webServer;
    }

    public WeightMeasurer getWeightMeasurer() {
        return weightMeasurer;
    }

    public void printInfo() {
        System.out.println(" - - TeaGAS System Info - - ");
        chipset.printChipsetInfo();
        System.out.println("Webserver: " + webServer.serverName());
        System.out.println("Weight Measurer: " + weightMeasurer.measurerType());
    }

}
