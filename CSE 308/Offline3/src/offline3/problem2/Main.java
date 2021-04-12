package offline3.problem2;


import java.util.Random;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        printMenu();

        while(true) {
            System.out.print("Enter your choice: ");
            int choice = sc.nextInt();
            selectMenu(choice);
        }

    }

    static void printMenu() {
        System.out.println("Welcome to Pizza Shop");
        System.out.println("1. Beef Pizza with French Fries");
        System.out.println("2. Veggie Pizza with Onion Rings");
        System.out.println("3. A combo meal with Veggie Pizza, French Fry and Coke");
        System.out.println("4. A combo meal with Veggie Pizza, Onion Rings and Coffee");
        System.out.println("5. A Beef Pizza only");
    }

    static void selectMenu(int n) {
        FoodItem item = null;

        switch (n) {
            case 1:
                item = new BeefPizza();
                item = new FrenchFries(item);
                break;

            case 2:
                item = new VeggiePizza();
                item = new OnionRings(item);
                break;

            case 3:
                item = new VeggiePizza();
                item = new FrenchFries(item);
                item = new Coke(item);
                break;

            case 4:
                item = new VeggiePizza();
                item = new OnionRings(item);
                item = new Coffee(item);
                break;

            case 5:
                item = new BeefPizza();
                break;

            default:
                System.out.println("Wrong input !!");
                return;
        }
        System.out.println("Total items: " + item.getName());
        System.out.println("Total price: " + item.getPrice());
    }
}
