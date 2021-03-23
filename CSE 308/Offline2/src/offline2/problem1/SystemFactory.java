package offline2.problem1;

import offline2.problem1.chipset.Chipset;
import offline2.problem1.packagefactory.PackageFactory;
import offline2.problem1.webserver.WebServer;
import offline2.problem1.weight.WeightMeasurer;

import java.util.Locale;


public class SystemFactory {

    public GASystem buildSystem(String packageName, String internet, String webServerName) throws Exception {

        packageName = packageName.toLowerCase(Locale.ROOT);

        PackageFactoryBuilder builder = new PackageFactoryBuilder();
        PackageFactory pf = builder.createPackageFactory(packageName);

        Chipset chipset = pf.makeChipset(internet);
        WeightMeasurer weightMeasurer = pf.buildWeightMeasurer();

        WebServerFactory wsf = new WebServerFactory();
        WebServer webServer = wsf.makeWebServer(webServerName);

        return new GASystem(chipset, webServer, weightMeasurer);
    }

}
