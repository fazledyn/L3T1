package offline4.problem1.server;


import java.net.Socket;
import java.util.ArrayList;


public abstract class Publisher {

    ArrayList<Subscriber> subscribers;
    Publisher() {
        //..
        subscribers = new ArrayList<>();
    }

    public abstract void notifySubscribers(String message) throws Exception;

    public void addSubscriber(Socket socketOfSubscriber) {

        for (Subscriber each : subscribers)
        {
            if (each.socket.equals(socketOfSubscriber)) {
                System.out.println("Subscriber already added !");
                return;
            }
        }
        subscribers.add(new Subscriber(socketOfSubscriber));
        System.out.println("Subscriber " + socketOfSubscriber + " added !");
    }

    public void removeSubscriber(Socket socketOfSubscriber) {
        for (int i=0; i < subscribers.size(); i++) {
            if (subscribers.get(i).socket.equals(socketOfSubscriber)) {
                subscribers.remove(i);
            }
        }
        System.out.println("Subscriber " + socketOfSubscriber + " removed !" );
    }

}
