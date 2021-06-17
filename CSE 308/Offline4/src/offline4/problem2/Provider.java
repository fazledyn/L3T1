package offline4.problem2;

import java.util.LinkedList;
import java.util.Queue;

abstract class Provider {

    private Queue<String> consumerQueue;
    Provider() {  consumerQueue = new LinkedList<>(); }

    void addRequest(String consumerName)
    {
        consumerQueue.add(consumerName);
    }

    String serveRequest()
    {
        if (consumerQueue.size() == 0)
        {
            System.err.println("No consumer to SERVE!");
            return "NULL";
        }
        else
        {
            return consumerQueue.remove();
        }
    }

}
