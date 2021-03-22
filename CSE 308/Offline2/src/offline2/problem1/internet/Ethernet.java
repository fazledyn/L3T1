package offline2.problem1.internet;

public class Ethernet implements InternetConnection {

    @Override
    public String connectionType() {
        return "Ethernet";
    }
}
