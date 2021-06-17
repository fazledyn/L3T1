package offline4.problem1.client;


import java.io.DataOutputStream;
import java.util.Scanner;



public class Sender implements Runnable {

    private Scanner sc;
    private DataOutputStream dout;
    private boolean senderIsActive;

    Sender(DataOutputStream dout, Scanner sc)
    {
        this.sc = sc;
        this.dout = dout;
        this.senderIsActive = true;
    }

    @Override
    public void run()
    {
        while (senderIsActive)
        {
            try
            {
                String input = sc.nextLine();
                dout.writeUTF(input);
                dout.flush();
            }
            catch (Exception e)
            {
                senderIsActive = false;
                System.err.println("Can't write to DataOutputStream");
            }
        }

    }
}
