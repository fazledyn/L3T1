package offline1;

public class Savings extends Account {

    public Savings(String name, int startYear, double initBalance) {
        super(name, startYear, Bank.getInstance().getSavingsRate(), 10000, initBalance);
    }

    @Override
    public void withdraw(double amount) {
        double moneyLeft = this.getBalance() - amount;

        if (moneyLeft < 1000) {
            System.err.println("Transaction failed. Current balance: " + this.getBalance() + "$");
        }
        else {
            super.withdraw(amount);
        }
    }
}
