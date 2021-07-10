import method.FaultySortMethod;
import method.SortMethod;
import tester.TestDriver;

public class Main {
    public static void main(String[] args) {

        SortMethod sortMethod = new SortMethod();
        FaultySortMethod faultyMethod = new FaultySortMethod();

        TestDriver testDriver = new TestDriver(sortMethod, 20000);
        testDriver.runUnitTest();

    }
}
