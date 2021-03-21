package offline2.problem2;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Editor editor = Editor.getInstance();
        Scanner sc = new Scanner(System.in);
        Boolean exit = false;

        while (!exit) {
            System.out.print("Enter file name (q to quit): ");
            String fileName = sc.nextLine();

            if (fileName.equals("q")) {
                exit = true;
            }
            String[] namePart = fileName.split("\\.", 0);
            String fileExt = namePart[namePart.length - 1];

            editor.run(fileExt);
        }
    }

}
