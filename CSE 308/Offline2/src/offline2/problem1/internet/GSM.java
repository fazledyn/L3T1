package offline2.problem1.internet;

public class GSM implements InternetConnection {

    @Override
    public String connectionType() {
        return "GSM";
    }
}
