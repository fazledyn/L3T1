package offline2.problem2;

public class Editor {

    private static final Editor instance = new Editor();
    public static Editor getInstance() { return instance; }

    private Language currentLang;

    public void run(String fileExt) {

        if (fileExt.equals("c")) {
            currentLang = new Lang_C();
            currentLang.loadSettings();
        }
        else if (fileExt.equals("cpp")) {
            currentLang = new Lang_Cpp();
            currentLang.loadSettings();
        }
        else if (fileExt.equals("py")) {
            currentLang = new Lang_Python();
            currentLang.loadSettings();
        }
        else {
            System.out.println("> This file type is not supported.");
        }

    }

}
