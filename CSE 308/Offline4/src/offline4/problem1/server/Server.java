package offline4.problem1.server;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Scanner;


public class Server {

    ServerSocket serverSocket;
    volatile ArrayList<Stock> stockList;
    boolean serverIsActive;

    public Server(File stockFile)
    {
        stockList = new ArrayList<>();
        readStockFile(stockFile);
        serverIsActive = true;

        try {
            serverSocket = new ServerSocket(7777);
        }
        catch (Exception e) {
            System.err.println("There was error in creating server socket");
        }
    }


    private void readStockFile(File stockFile) {
        try {
            Scanner sc = new Scanner(stockFile);
            while (sc.hasNextLine())
            {
                String line = sc.nextLine();
                String[] lineArray = line.split(" ");

                stockList.add(new Stock(
                        lineArray[0],
                        Integer.parseInt(lineArray[1]),
                        Double.parseDouble(lineArray[2])
                ));
            }
        }
        catch (Exception e) {
            System.err.println("Error in reading stock file");
        }
    }

    public void start() {

        AdminHandler adminHandler = new AdminHandler(this.stockList);
        Thread adminHandlerThread = new Thread(adminHandler);
        adminHandlerThread.start();

        while (serverIsActive)
        {
            try
            {
                Socket clientSocket = serverSocket.accept();
                System.out.println("New client : " + clientSocket.getPort());

                ClientHandler clientHandler = new ClientHandler(this.stockList, clientSocket);
                Thread clientHandlerThread = new Thread(clientHandler);
                clientHandlerThread.start();
            }
            catch (Exception e)
            {
                System.err.println("The sever can't start");
            }
        }
    }

}
