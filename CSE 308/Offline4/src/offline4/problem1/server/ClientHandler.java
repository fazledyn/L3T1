package offline4.problem1.server;

import java.io.*;
import java.net.*;
import java.util.*;


public class ClientHandler implements Runnable {

    private ArrayList<Stock> stockList;
    private Socket socket;
    private DataInputStream din;
    private DataOutputStream dout;
    private boolean handlerIsActive;

    ClientHandler(ArrayList<Stock> stockList, Socket socket) {

        this.socket = socket;
        this.stockList = stockList;
        this.handlerIsActive = true;

        try
        {
            this.din    = new DataInputStream(this.socket.getInputStream());
            this.dout   = new DataOutputStream(this.socket.getOutputStream());
        }
        catch (Exception e)
        {
            System.err.println("Can't get the I/O streams");
            this.din    = null;
            this.dout   = null;
        }
    }

    private void sendStockData() throws IOException {
        dout.writeUTF("Stock Details:");
        dout.flush();
        for (Stock eachStock : stockList)
        {
            dout.writeUTF("Name: " + eachStock.getName() + " Count: " + eachStock.getCount() + " Price: " + eachStock.getPrice());
            dout.flush();
        }
    }

    @Override
    public void run() {

        try {
            sendStockData();
        }
        catch (Exception e) {
            System.err.println("Client disconnected !");
        }

        while (handlerIsActive) {

            try
            {
                String input = din.readUTF();
                String[] inputArray = input.split(" ");
                String choice = inputArray[0];

                if (choice.equals("S"))
                {
                    String inputStockName = inputArray[1];
                    for (Stock stock : stockList)
                    {
                        if (stock.getName().equals(inputStockName))
                        {
                            stock.addSubscriber(this.socket);
                        }
                    }
                }
                else if (choice.equals("U"))
                {
                    String inputStockName = inputArray[1];
                    for (Stock stock : stockList)
                    {
                        if (stock.getName().equals(inputStockName))
                        {
                            stock.removeSubscriber(this.socket);
                        }
                    }
                }
                else if (choice.equals("P"))
                {
                    sendStockData();
                }
            }
            catch (IOException e) {
                System.out.println("Client has disconnected !");
                handlerIsActive = false;
            }
        }

    }

}
