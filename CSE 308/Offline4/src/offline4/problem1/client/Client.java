package offline4.problem1.client;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.Socket;
import java.util.Scanner;


public class Client {

    private Scanner sc;
    private Socket socket;
    private DataInputStream din;
    private DataOutputStream dout;

    public Client()
    {
        try
        {
            this.sc = new Scanner(System.in);
            this.socket = new Socket("localhost", 7777);
            this.din  = new DataInputStream(this.socket.getInputStream());
            this.dout = new DataOutputStream(this.socket.getOutputStream());

            System.out.println("New client started! Client port: " + this.socket.getLocalPort());
        }
        catch (Exception e)
        {
            System.err.println("Error in connecting socket !");
        }
    }


    public void start()
    {
        Sender sender = new Sender(dout, sc);
        Thread senderThread = new Thread(sender);

        Receiver receiver = new Receiver(din);
        Thread receiverThread = new Thread(receiver);

        senderThread.start();
        receiverThread.start();

        System.out.println("Sender & Receiver started !");
    }

}
