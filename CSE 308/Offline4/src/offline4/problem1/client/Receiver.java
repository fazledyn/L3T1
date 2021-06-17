package offline4.problem1.client;

import java.io.DataInputStream;


public class Receiver implements Runnable {

    private DataInputStream din;
    private boolean receiverIsActive;

    Receiver(DataInputStream din)
    {
        this.din = din;
        this.receiverIsActive = true;
    }


    @Override
    public void run()
    {
        while (receiverIsActive)
        {
            try
            {
                String input = din.readUTF();
                System.out.println(input);
            }
            catch (Exception e)
            {
                System.err.println("Error in reading input stream");
                receiverIsActive = false;
            }
        }
    }
}
