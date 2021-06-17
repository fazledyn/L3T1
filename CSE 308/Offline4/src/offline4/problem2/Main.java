package offline4.problem2;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Provider JPDC = new JPDC();
        Provider JRTA = new JRTA();
        Provider JTRC = new JTRC();
        Provider JWSA = new JWSA();

        JCC mediator = new JCC(JPDC, JRTA, JTRC, JWSA);
        Scanner sc = new Scanner(System.in);

        while (true)
        {
            parseCommand(mediator, sc.nextLine());
        }

    }

    private static void parseCommand(JCC mediator, String command)
    {
        String param1 = command.split(" ")[0];
        String param2 = command.split(" ")[1];

        if (param2.equals("SERVE"))
        {
            String providerName = param1;
            String consumerName = mediator.serveRequest(providerName);

            System.out.println(providerName + " serves the request of " + consumerName);
        }
        else
        {
            String consumerName = param1;
            String serviceName = param2;
            mediator.addRequest(consumerName, serviceName);

            System.out.println(consumerName + " requests for " + serviceName + " service");
        }
    }

}
