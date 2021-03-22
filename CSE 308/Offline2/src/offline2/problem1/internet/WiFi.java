package offline2.problem1.internet;

public class WiFi implements InternetConnection {

    @Override
    public String connectionType() {
        return "WiFi";
    }
}
