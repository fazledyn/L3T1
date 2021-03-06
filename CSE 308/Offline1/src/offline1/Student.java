package offline1;

public class Student extends Account {

    public Student(String name, int startYear, double initBalance) {
        super(name, startYear, Bank.getInstance().getStudentRate(), 1000, initBalance);
    }

    @Override
    public void withdraw(double amount) {
        if (amount > 10000) {
            System.err.println("Transaction failed. Current balance: " + this.getBalance() + "$");
        }
        else {
            super.withdraw(amount);
        }
    }

    @Override
    public void annualSettlement() {
        double interest = this.getBalance()*this.getInterestRate();

        // Interest give to account
        this.addBalance(interest);
        Bank.getInstance().deductFund(interest);

        if (this.isLoanApproved()) {
            double loanInterest = this.getLoan()*0.1;
            // Loan interest give to bank
            this.deductBalance(loanInterest);
            Bank.getInstance().addFund(loanInterest);
        }
    }

}
