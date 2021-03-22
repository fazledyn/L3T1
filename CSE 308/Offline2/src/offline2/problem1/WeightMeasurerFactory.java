package offline2.problem1;

import offline2.problem1.weight.LoadSensor;
import offline2.problem1.weight.WeightMeasurer;
import offline2.problem1.weight.WeightModule;

import java.util.Locale;


public class WeightMeasurerFactory {

    public WeightMeasurer selectMeasurer(String measurerType) {

        measurerType = measurerType.toLowerCase(Locale.ROOT);

        if (measurerType.equals("sensor")) {
            return new LoadSensor();
        }
        else if (measurerType.equals("module")) {
            return new WeightModule();
        }
        else {
            return null;
        }
    }

}
