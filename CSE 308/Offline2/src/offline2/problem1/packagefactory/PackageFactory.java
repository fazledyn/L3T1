package offline2.problem1.packagefactory;

import offline2.problem1.chipset.Chipset;
import offline2.problem1.weight.WeightMeasurer;

public interface PackageFactory {
    public Chipset makeChipset(String internet) throws Exception;
    public WeightMeasurer buildWeightMeasurer();
}