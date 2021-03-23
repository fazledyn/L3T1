package offline2.problem1;

import offline2.problem1.packagefactory.*;

public class PackageFactoryBuilder {

    PackageFactory createPackageFactory(String packageName) {

        if (packageName.equals("silver")) {
            return new SilverPackageFactory();
        } else if (packageName.equals("gold")) {
            return new GoldPackageFactory();
        } else if (packageName.equals("diamond")) {
            return new DiamondPackageFactory();
        } else if (packageName.equals("platinum")) {
            return new PlatinumPackageFactory();
        } else {
            return null;
        }
    }

}
