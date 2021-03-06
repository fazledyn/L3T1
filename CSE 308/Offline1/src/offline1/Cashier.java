package offline1;

import java.util.ArrayList;

public class Cashier extends Person {

    public Cashier(String name) {
        super(name);
    }

    public void lookup(String name) {
        ArrayList<Object> personList = Bank.getInstance().getPersonList();

        for (Object obj : personList) {
            Person person = (Person) obj;

            if (person.getName().equals(name)) {
                if (person instanceof Account) {
                    Account acc = (Account) person;
                    if (acc.isLoanApproved()) {
                        System.out.println(acc.getName() + "'s Balance: " + acc.getBalance() + " Loan: " + acc.getLoan());
                    } else {
                        System.out.println(acc.getName() + "'s Balance: " + acc.getBalance());
                    }
                }
            }
        }
    }
}
