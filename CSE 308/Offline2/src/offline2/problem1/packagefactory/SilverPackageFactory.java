package offline2.problem1.packagefactory;

import offline2.problem1.chipset.ATMega32;
import offline2.problem1.chipset.Chipset;
import offline2.problem1.weight.LoadSensor;
import offline2.problem1.weight.WeightMeasurer;

public class SilverPackageFactory implements PackageFactory {
    @Override
    public Chipset makeChipset(String internet) throws Exception {
        return new ATMega32(internet);
    }

    @Override
    public WeightMeasurer buildWeightMeasurer() {
        return new LoadSensor();
    }
}
