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

    private boolean loggedIn;

    public Client()
    {
        this.loggedIn = false;
        this.sc = new Scanner(System.in);
    }


    public void start()
    {
        System.out.println("Enter 'login' to log in.");
        String input = sc.nextLine();

        if ((input.equals("login") && !loggedIn ))
        {
            loggedIn = true;
            try
            {
                this.socket = new Socket("localhost", 7777);
                this.din  = new DataInputStream(this.socket.getInputStream());
                this.dout = new DataOutputStream(this.socket.getOutputStream());

                System.out.println("New client started! Client port: " + this.socket.getLocalPort());
            }
            catch (Exception e)
            {
                System.err.println("Error in connecting socket !");
            }

            Sender sender = new Sender(dout, sc);
            Thread senderThread = new Thread(sender);

            Receiver receiver = new Receiver(din);
            Thread receiverThread = new Thread(receiver);

            senderThread.start();
            receiverThread.start();

            System.out.println("Sender & Receiver started !");
        }
        else
        {
            return;
        }
    }

}
