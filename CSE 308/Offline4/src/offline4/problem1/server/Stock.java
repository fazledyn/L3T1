package offline4.problem1.server;

import java.io.DataOutputStream;

public class Stock extends Publisher {

    private String name;
    private int count;
    private double price;

    public Stock(String name, int count, double price) {
        this.name = name;
        this.count = count;
        this.price = price;
    }

    public String getName() {
        return this.name;
    }
    public int getCount() { return this.count; }
    public double getPrice() { return this.price; }

    @Override
    public String toString() {
        return name;
    }

    public void updatePrice(double newPrice) throws Exception {
        this.price = newPrice;

        String message = "Stock price for " + this.name + " has been changed to " + newPrice;
        this.notifySubscribers(message);
    }

    public void updateCount(int newCount) throws Exception {
        this.count += newCount;

        String message = "New " + newCount + " stocks has been issued for " + this.name;
        this.notifySubscribers(message);
    }

    @Override
    public void notifySubscribers(String message) throws Exception {
        for (Subscriber sub : super.subscribers) {
            DataOutputStream dout = new DataOutputStream(sub.getSocket().getOutputStream());
            dout.writeUTF(message);
            dout.flush();
        }
    }
}
