package offline4.problem1.server;

import java.util.*;


public class AdminHandler implements Runnable {

    private ArrayList<Stock> stockList;
    private Scanner sc;
    private boolean handlerIsActive;

    AdminHandler(ArrayList<Stock> stockList)
    {
        this.stockList = stockList;
        sc = new Scanner(System.in);
        handlerIsActive = true;
    }

    @Override
    public void run()
    {
        while (handlerIsActive)
        {
            String command = sc.nextLine();
            String[] commandArray = command.split(" ");

            String choice = commandArray[0];


            if (choice.equals("I"))
            {
                String stockName = commandArray[1];
                double newPrice = Double.parseDouble(commandArray[2]);

                for (Stock eachStock : stockList)
                {
                    if (eachStock.getName().equals(stockName))
                    {
                        try {
                            eachStock.updatePrice(newPrice);
                        }
                        catch (Exception e) {
                            System.err.println("There was an error in updating price");
                        }
                    }
                }
            }
            else if (choice.equals("D"))
            {
                String stockName = commandArray[1];
                double newPrice = Double.parseDouble(commandArray[2]);

                for (Stock eachStock : stockList)
                {
                    if (eachStock.getName().equals(stockName))
                    {
                        try {
                            eachStock.updatePrice(newPrice);
                        }
                        catch (Exception e) {
                            System.err.println("There was error in updating stock price");
                        }
                    }
                }
            }
            else if (choice.equals("C"))
            {
                String stockName = commandArray[1];
                int newCount = Integer.parseInt(commandArray[2]);

                for (Stock eachStock : stockList)
                {
                    if (eachStock.getName().equals(stockName))
                    {
                        try {
                            eachStock.updateCount(newCount);
                        }
                        catch (Exception e) {
                            System.err.println("There was error in updating count");
                        }
                    }
                }
            }
            else if (choice.equals("P"))
            {
                for (Stock eachStock : stockList)
                {
                    System.out.println(eachStock.getName() + " : " + eachStock.getCount() + " : " + eachStock.getPrice());
                }
            }
            else if (choice.equals("EXIT"))
            {
                handlerIsActive = false;
            }

        }

    }
}
