package offline1;

import java.util.ArrayList;

public class MD extends Officer {

    public MD(String name) {
        super(name);
    }

    public void seeInternalFund() {
        double bankFund = Bank.getInstance().getBankFund();
        System.out.println("Current bank fund: " + bankFund + "$");
    }

    // @param Rate parameter in percentage form. Gotta divide by 100
    public void changeInterestRate(String accountType, String rate) {

        double newRate = Double.parseDouble(rate)/100;
        ArrayList<Object> personList = Bank.getInstance().getPersonList();

        switch (accountType) {
            case "Student" -> {
                Bank.getInstance().setStudentRate(newRate);
                for (Object obj : personList) {
                    if (obj.getClass().getSimpleName().equals("Student")) {
                        Account acc = (Account) obj;
                        acc.setInterestRate(newRate);
                    }
                }
            }

            case "Savings" -> {
                Bank.getInstance().setSavingsRate(newRate);
                for (Object obj : personList) {
                    if (obj.getClass().getSimpleName().equals("Savings")) {
                        Account acc = (Account) obj;
                        acc.setInterestRate(newRate);
                    }
                }
            }

            case "FixedDeposit" -> {
                Bank.getInstance().setFixedDepositRate(newRate);
                for (Object obj : personList) {
                    if (obj.getClass().getSimpleName().equals("FixedDeposit")) {
                        Account acc = (Account) obj;
                        acc.setInterestRate(newRate);
                    }
                }
            }
            default -> System.err.println("Wrong command.");
        }
        System.out.println("Interest rate for " + accountType + " has been changed");
    }
}
