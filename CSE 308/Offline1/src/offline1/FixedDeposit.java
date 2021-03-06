package offline1;

public class FixedDeposit extends Account {

    public FixedDeposit(String name, int startYear, double initBalance) {
        super(name, startYear, Bank.getInstance().getFixedDepositRate(), 100000, initBalance);
    }

    @Override
    public void withdraw(double amount) {
        int maturity = Bank.getInstance().getBankYear() - this.getStartYear();

        if (maturity < 1) {
            System.err.println("Transaction failed. Current balance: " + this.getBalance() + "$");
        }
        else {
            super.withdraw(amount);
        }
    }

    @Override
    public void deposit(double amount) {
        if (amount < 50000) {
            System.err.println("Transaction failed. Can't deposit less than 50000.");
        }
        else {
            super.deposit(amount);
        }
    }
}
