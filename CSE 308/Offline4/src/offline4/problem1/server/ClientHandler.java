package offline4.problem1.server;

import java.io.*;
import java.net.*;
import java.util.*;


public class ClientHandler implements Runnable {

    ArrayList<Stock> stockList;
    Socket socket;
    DataInputStream din;
    DataOutputStream dout;
    boolean handlerIsActive;

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

    @Override
    public void run() {

        while (handlerIsActive) {
            try {
                String input = din.readUTF();
                String[] inputArray = input.split(" ");

                String choice = inputArray[0];
                String inputStockName = inputArray[1];

                if (choice.equals("S"))
                {
                    for (Stock stock : stockList)
                    {
                        if (stock.name.equals(inputStockName))
                        {
                            stock.addSubscriber(this.socket);
                        }
                    }
                }
                else if (choice.equals("U"))
                {
                    for (Stock stock : stockList)
                    {
                        if (stock.name.equals(inputStockName))
                        {
                            stock.removeSubscriber(this.socket);
                        }
                    }
                }
            }
            catch (IOException e) {
                e.printStackTrace();
                handlerIsActive = false;
            }
        }

    }
}
