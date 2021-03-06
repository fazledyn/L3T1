package offline1;

public class Account extends Person {

    private final int startYear;
    private final double maximumLoan;

    private boolean loanApproved;
    private double balance, loan, interestRate;

    public Account(String name, int startYear, double interestRate, double maximumLoan, double balance) {
        super(name);
        this.startYear = startYear;
        this.maximumLoan = maximumLoan;
        this.interestRate = interestRate;
        this.loanApproved = false;
        this.balance = balance;
        this.loan = 0;
    }

    // Setter Getter
    public int getStartYear() { return startYear; }
    public void setInterestRate(double rate) { this.interestRate = rate; }
    public double getInterestRate() { return interestRate; }

    public boolean isLoanApproved() { return loanApproved; }
    public void setLoanApproved(boolean loanApproved) { this.loanApproved = loanApproved; }

    public double getBalance() { return balance; }
    public double getLoan() { return loan; }

    public void addBalance(double amount) { this.balance += amount; }
    public void deductBalance(double amount) { this.balance -= amount; }


    public void queryBalance() {
        if (this.loanApproved) {
            System.out.println("Current balance: " + this.balance + "$, Loan: " + this.loan + "$");
        }
        else {
            System.out.println("Current balance: " + this.balance + "$");
        }
    }

    public void deposit(double amount) {
        this.balance += amount;
        System.out.println("Transaction successful. Current balance: " + this.balance +"$");
    }

    public void requestLoan(double amount) {
        if (amount > this.maximumLoan) {
            System.err.println("Loan request failed.");
        }
        else {
            this.loanApproved = false;
            this.loan = amount;
            Bank.getInstance().setLoanRequest(true);
            System.out.println("Loan request successful. Waiting for approval.");
        }
    }

    public void withdraw(double amount) {
        this.deductBalance(amount);
        System.out.println(amount + "$ has been withdrawn. Current balance: " + this.getBalance() + "$");
    }

    public void annualSettlement() {
        double interest = this.balance*this.interestRate;

        // Interest give to account
        this.balance += interest;
        Bank.getInstance().deductFund(interest);

        // Give annual charge to bank
        this.balance -= 500;
        Bank.getInstance().addFund(500);

        if (loanApproved) {
            double loanInterest = this.loan*0.1;

            // Loan interest give to bank
            this.balance -= loanInterest;
            Bank.getInstance().addFund(loanInterest);
        }
    }
}
