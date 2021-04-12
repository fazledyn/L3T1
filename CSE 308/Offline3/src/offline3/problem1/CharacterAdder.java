package offline3.problem1;

import java.io.*;
import java.util.Scanner;


public class CharacterAdder {

    public int calculateSum(File inputFile) throws Exception {

        writeTempFile(inputFile);
        File file = new File("src/offline3/problem1/temp.txt");
        IntegerAdder adder = new IntegerAdder();

        return adder.calculateSum(file);
    }

    void writeTempFile(File inputFile) throws IOException {

        FileWriter fw = new FileWriter("src/offline3/problem1/temp.txt");
        Scanner sc = new Scanner(inputFile);
        String[] arr = sc.nextLine().split(" ");

        int num;
        for (String item: arr) {
            num = item.charAt(0);
            fw.write(Integer.toString(num));
            fw.write(" ");
        }
        fw.close();
    }

}
