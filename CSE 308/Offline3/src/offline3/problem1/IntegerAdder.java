package offline3.problem1;

import java.io.*;
import java.util.Scanner;


public class IntegerAdder {

    public int calculateSum(File file) throws FileNotFoundException {

        Scanner sc = new Scanner(file);
        int total = 0;

        while (sc.hasNext()) {
            total += sc.nextInt();
        }
        return total;
    }

}
