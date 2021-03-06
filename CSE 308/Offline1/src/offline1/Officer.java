package offline1;

import java.util.ArrayList;

public class Officer extends Cashier {

    public Officer(String name) {
        super(name);
    }

    public void approveLoan() {
        ArrayList<Object> personList = Bank.getInstance().getPersonList();
        for (Object obj : personList) {
            if (obj instanceof Account) {
                Account acc = (Account) obj;
                if (!acc.isLoanApproved()) {
                    approveIndividualLoan(acc);
                }
            }
        }
        Bank.getInstance().setLoanRequest(false);
    }

    private void approveIndividualLoan(Account acc) {
        double loanAmount = acc.getLoan();
        double bankFund = Bank.getInstance().getBankFund();

        if (loanAmount > bankFund) {
            System.err.println("Insufficient fund. Can't approve loans.");
        }
        else {
            acc.setLoanApproved(true);
            acc.addBalance(loanAmount);
            Bank.getInstance().deductFund(loanAmount);
            System.out.println("Loan approved for " + acc.getName());
        }
    }

}
