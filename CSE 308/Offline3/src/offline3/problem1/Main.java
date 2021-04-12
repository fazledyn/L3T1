package offline3.problem1;

import java.io.File;


public class Main {

    public static void main(String[] args) throws Exception {

        int total = -1;

        File intFile = new File("src/offline3/problem1/input.txt");
        IntegerAdder intAdder = new IntegerAdder();
        total = intAdder.calculateSum(intFile);

        System.out.println("Integer file sum: " + total);


        File charFile = new File("src/offline3/problem1/char.txt");
        CharacterAdder charAdder = new CharacterAdder();
        total = charAdder.calculateSum(charFile);

        System.out.println("Character file sum: " + total);

    }


}
