package tester;

import java.util.Arrays;
import java.util.Random;
import static java.lang.Math.abs;

/*  Test Case Generator - 1705066
    This file contains eight unique test case generator methods.

    An extra method has been added along with initial 7 constraints
    that creates an array with the maximum upper bound array size.
*/


class TestGenerator {

    private final int bound;
    private final Random random;

    TestGenerator(int bound) {
        this.bound = bound;
        this.random = new Random();
    }

    private void fillWithRandom(int[] list) {
        for (int i=0; i < list.length; i++) {
            list[i] = random.nextInt();
        }
    }

    int[] generateBlankList() {
        return new int[]{};
    }

    int[] generateOneNumberList() {
        int[] test = new int[1];
        fillWithRandom(test);
        return test;
    }

    int[] generateTwoNumberList() {
        int[] test = new int[2];
        fillWithRandom(test);
        return test;
    }

    int[] generateRandomSizedList() {
        int[] test = new int[abs(random.nextInt(bound))];
        fillWithRandom(test);
        return test;
    }

    int[] generateAscendingSortedList() {
        int[] test = new int[abs(random.nextInt(bound))];
        test[0] = random.nextInt();

        for (int i = 1; i < test.length; i++) {
            test[i] = test[i-1] + abs(random.nextInt());
        }
        return test;
    }

    int[] generatedDescendingSortedList() {
        int[] test = new int[abs(random.nextInt(bound))];
        test[0] = random.nextInt();

        for (int i = 1; i < test.length; i++) {
            test[i] = test[i-1] - abs(random.nextInt());
        }
        return test;
    }

    int[] generateEqualItemList() {
        int[] test = new int[abs(random.nextInt(bound))];
        int randomValue = random.nextInt();
        Arrays.fill(test, randomValue);
        return test;
    }

    // ExtraTestCases
    int[] generateMaxSizedList() {
        int[] test = new int[bound];
        fillWithRandom(test);
        return test;
    }

}
