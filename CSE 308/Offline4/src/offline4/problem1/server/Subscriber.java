package offline4.problem1.server;

import java.net.Socket;

public class Subscriber {

    Socket socket;

    public Subscriber(Socket socket) {
        this.socket = socket;
    }

    public Socket getSocket() {
        return this.socket;
    }

}
