package tester;

import method.Method;
import java.util.HashMap;


public class TestDriver {

    public static final String ANSI_RESET = "\u001B[0m";
    public static final String ANSI_RED = "\u001B[31m";
    public static final String ANSI_GREEN = "\u001B[32m";

    private int totalTest;
    private int passedTest;
    private final Method method;
    private final TestGenerator generator;


    public TestDriver(Method method, int bound) {
        this.totalTest = 0;
        this.passedTest = 0;
        this.generator = new TestGenerator(bound);
        this.method = method;
    }

    private void printTestSummary() {
        System.out.println("----------------");
        System.out.println("Testing summary:");
        System.out.println("Total passed test: " + passedTest + "/" + totalTest);
        this.totalTest = 0;
        this.passedTest = 0;
    }

    private void printList(int[] list) {
        System.out.println("Current list:");
        for (int i=0; i < list.length; i++) {
            if (i != list.length - 1) {
                System.out.print(list[i] + ", ");
            }
            else {
                System.out.println(list[i]);
            }
        }
    }

    private boolean isSorted(int[] list) {
        int errorCount = 0;
        for (int i = 0; i < list.length - 1; i++) {
            if (list[i] > list[i+1]) {
                System.out.println(".... " + list[i] + ", " + list[i+1] + " ....");
                System.out.println("^ List not sorted at index: " + i + ":" + (i+1));
                errorCount++;
            }
        }
        if (errorCount > 0) {
            // printList(list);
            return false;
        }
        else {
            return true;
        }
    }

    private boolean isNotAltered(int[] inputList, int[] outputList) {
        HashMap<Integer, Integer> inputFreq  = new HashMap<>();
        HashMap<Integer, Integer> outputFreq = new HashMap<>();

        for (int item : inputList) {
            if (inputFreq.get(item) == (null)) {
                inputFreq.put(item, 1);
            } else {
                inputFreq.put(item, inputFreq.get(item) + 1);
            }
        }

        for (int item : outputList) {
            if (outputFreq.get(item) == (null)) {
                outputFreq.put(item, 1);
            } else {
                outputFreq.put(item, outputFreq.get(item) + 1);
            }
        }

        for (int item : outputList) {
            if (!inputFreq.get(item).equals(outputFreq.get(item))) {
                System.out.println("List has been altered by sort function.");
                return false;
            }
        }
        return true;
    }

    private void runSingleTest(int[] inputList) {
        int[] outputList = method.run(inputList);

        if (isSorted(outputList) && isNotAltered(inputList, outputList) ) {
            passedTest++;
            System.out.println(ANSI_GREEN + "Test passed at test case: " + (totalTest+1) + ANSI_RESET);
        } else {
            System.out.println(ANSI_RED + "Test failed at test case: " + (totalTest+1) + ANSI_RESET);
        }
        totalTest++;
    }

    public void runUnitTest() {
        int[] inputList;

        inputList = generator.generateBlankList();
        runSingleTest(inputList);

        inputList = generator.generateOneNumberList();
        runSingleTest(inputList);

        inputList = generator.generateTwoNumberList();
        runSingleTest(inputList);

        inputList = generator.generateRandomSizedList();
        runSingleTest(inputList);

        inputList = generator.generateEqualItemList();
        runSingleTest(inputList);

        inputList = generator.generateAscendingSortedList();
        runSingleTest(inputList);

        inputList = generator.generatedDescendingSortedList();
        runSingleTest(inputList);

        inputList = generator.generateMaxSizedList();
        runSingleTest(inputList);

        printTestSummary();
    }

}
