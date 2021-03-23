package offline2.problem1.packagefactory;

import offline2.problem1.chipset.Chipset;
import offline2.problem1.chipset.RaspberryPi;
import offline2.problem1.weight.WeightMeasurer;
import offline2.problem1.weight.WeightModule;

public class PlatinumPackageFactory implements PackageFactory {

    @Override
    public Chipset makeChipset(String internet) throws Exception {
        return new RaspberryPi(internet);
    }

    @Override
    public WeightMeasurer buildWeightMeasurer() {
        return new WeightModule();
    }
}
