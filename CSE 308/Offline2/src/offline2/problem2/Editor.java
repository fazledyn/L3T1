package offline2.problem2;

import offline2.problem2.language.C;
import offline2.problem2.language.Cpp;
import offline2.problem2.language.Python;
import offline2.problem2.language.Language;

import java.util.Scanner;

public class Editor {

    private static final Editor instance = new Editor();
    public static Editor getInstance() { return instance; }

    LanguageFactory factory;
    Language currentLang;

    public void run(String fileExt) {

        factory = new LanguageFactory();
        currentLang = factory.setupLanguage(fileExt);

        if (currentLang == null) {
            System.out.println("This file type is not supported. \n");
        }
        else {
            currentLang.loadSettings();
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.print("Enter file name (q to quit): ");
            String fileName = sc.nextLine();

            if (fileName.equals("q")) {
                break;
            }

            String[] namePart = fileName.split("\\.", 0);
            String fileExt = namePart[namePart.length - 1];

            instance.run(fileExt);
        }
    }
}
