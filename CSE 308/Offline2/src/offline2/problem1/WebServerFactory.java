package offline2.problem1;

import offline2.problem1.webserver.*;
import java.util.Locale;


public class WebServerFactory {

    public WebServer makeWebServer(String webserverName) {
        webserverName = webserverName.toLowerCase(Locale.ROOT);

        if (webserverName.equals("django")) {
            return new Django();
        }
        else if (webserverName.equals("laravel")) {
            return new Laravel();
        }
        else if (webserverName.equals("spring")) {
            return new Spring();
        }
        else {
            System.out.println("Invalid webserver selected.");
            System.exit(0);
            return null;
        }
    }

}
