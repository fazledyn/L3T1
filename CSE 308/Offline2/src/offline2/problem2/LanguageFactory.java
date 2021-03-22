package offline2.problem2;

import offline2.problem2.language.C;
import offline2.problem2.language.Cpp;
import offline2.problem2.language.Language;
import offline2.problem2.language.Python;

public class LanguageFactory {

    public Language setupLanguage(String fileExt) {

        if (fileExt.equals("c")) {
            return new C();
        }
        else if (fileExt.equals("cpp")) {
            return new Cpp();
        }
        else if (fileExt.equals("py")) {
            return new Python();
        }
        else {
            return null;
        }
    }
}
