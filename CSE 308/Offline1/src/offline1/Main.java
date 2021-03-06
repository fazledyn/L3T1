package offline1;

public class Main {

    private final static Bank bank = Bank.getInstance();

    public static void main(String[] args) {
        bank.run();
    }
}
