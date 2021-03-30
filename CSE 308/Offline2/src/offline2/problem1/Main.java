package offline2.problem1;

import java.util.Scanner;


public class Main {

    public static void main(String[] args) throws Exception {

        Scanner sc = new Scanner(System.in);
        String planName, webServerName, internet;

        System.out.print("Enter your plan: ");
        planName = sc.nextLine();
        System.out.print("Enter internet connection: ");
        internet = sc.nextLine();
        System.out.print("Enter preferred webserver: ");
        webServerName = sc.nextLine();

        SystemFactory sf = new SystemFactory();
        GASystem system = sf.buildSystem(planName, internet, webServerName);

        system.printInfo();
    }
}
