package offline4.problem1.server;

import java.io.File;


public class Main {

    public static void main(String[] args) {

        File stockFile = new File("./src/offline4/problem1/server/stock.txt");
        Server server = new Server(stockFile);

        server.start();
    }

}
