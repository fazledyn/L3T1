package offline1;

import java.util.ArrayList;
import java.util.Locale;
import java.util.Scanner;


public class Bank {

    private int bankYear;
    private double bankFund;
    private boolean loanRequest;
    private final ArrayList<Object> personList;
    private static final Bank instance = new Bank();

    // Bank Constant Variable
    private double studentRate;
    private double savingsRate;
    private double fixedDepositRate;

    // Session Variable
    private Object currentUser;

    private Bank() {
        this.bankYear       = 0;
        this.bankFund       = 1000000;
        this.loanRequest = false;
        this.personList     = new ArrayList<>();

        studentRate      = 0.05;
        savingsRate      = 0.10;
        fixedDepositRate = 0.15;
    }

    public void addFund(double amount) { this.bankFund += amount; }
    public void deductFund(double amount) { this.bankFund -= amount; }

    // Setter Getter
    public void setLoanRequest(boolean status) { this.loanRequest = status; }
    public void setStudentRate(double studentRate) { this.studentRate = studentRate; }
    public void setSavingsRate(double savingsRate) { this.savingsRate = savingsRate; }
    public void setFixedDepositRate(double fixedDepositRate) { this.fixedDepositRate = fixedDepositRate; }

    public double getBankFund() { return this.bankFund; }
    public double getStudentRate() { return studentRate; }
    public double getSavingsRate() { return savingsRate; }
    public double getFixedDepositRate() { return fixedDepositRate; }

    public int getBankYear() { return this.bankYear; }
    public static Bank getInstance() { return instance; }
    public ArrayList<Object> getPersonList() { return this.personList; }

    private void increaseYear() {
        this.bankYear += 1;
        System.out.println("1 Year Passed");
        annualSettlement();
    }

    private void annualSettlement() {
        for (Object obj: personList) {
            if (obj instanceof Student) {
                Student acc = (Student) obj;
                acc.annualSettlement();
            }
            else if (obj instanceof Savings) {
                Savings acc = (Savings) obj;
                acc.annualSettlement();
            }
            else if (obj instanceof FixedDeposit) {
                FixedDeposit acc = (FixedDeposit) obj;
                acc.annualSettlement();
            }
        }
    }

    private void createStaff() {
        personList.add(new MD("MD"));
        personList.add(new Officer("O1"));
        personList.add(new Officer("O2"));

        personList.add(new Cashier("C1"));
        personList.add(new Cashier("C2"));
        personList.add(new Cashier("C3"));
        personList.add(new Cashier("C4"));
        personList.add(new Cashier("C5"));

        System.out.println("Bank Created; MD, O1, O2, C1, C2, C3, C4, C5 created");
    }


    public void run() {
        createStaff();
        //testAccount();

        boolean exit = false;
        Scanner sc = new Scanner(System.in);

        while (!exit) {

            String input = sc.nextLine();
            String[] token = input.split(" ", 0);

            switch(token[0]) {

                // General Level
                case "Create" -> createAccount(token);
                case "Open" -> openUser(token[1]);
                case "INC" -> increaseYear();
                case "Close" -> logoutUser();

                case "Deposit" -> {
                    Account acc = (Account) currentUser;
                    acc.deposit(Double.parseDouble(token[1]));
                }

                case "Withdraw" -> {
                    Account acc = (Account) currentUser;
                    acc.withdraw(Double.parseDouble(token[1]));
                }

                case "Query" -> {
                    Account acc = (Account) currentUser;
                    acc.queryBalance();
                }

                case "Request" -> {
                    Account acc = (Account) currentUser;
                    acc.requestLoan(Double.parseDouble(token[1]));
                }

                // Cashier Level
                case "Lookup" -> {
                    Cashier staff = (Cashier) currentUser;
                    staff.lookup(token[1]);
                }

                // Officer Level
                case "Approve" -> loanApprove(token[1]);

                // MD Level
                case "See" -> seeFund();
                case "Change" -> changeInterest(token[1], token[2]);

                default -> exit = true;
            }
        }
    }

    private void loanApprove(String token) {
        if (token.equals("Loan")) {
            if (currentUser instanceof Officer) {
                Officer officer = (Officer) currentUser;
                officer.approveLoan();
            }
            else {
                System.err.println("You don't have permission for this operation");
            }
        }
    }

    private void changeInterest(String type, String newRate) {
        if (currentUser instanceof MD) {
            MD md = (MD) currentUser;
            md.changeInterestRate(type, newRate);
        }
        else {
            System.err.println("You don't have permission for this operation");
        }
    }

    private void seeFund() {
        if (currentUser instanceof MD) {
            MD md = (MD) currentUser;
            md.seeInternalFund();
        }
        else {
            System.err.println("You don't have permission for this operation");
        }
    }

    public void createAccount(String[] token) {
        String name = token[1];
        String type = token[2].toUpperCase(Locale.ROOT);
        double initBal = Double.parseDouble(token[3]);

        switch (type) {
            case "STUDENT" -> personList.add(new Student(name, bankYear, initBal));
            case "SAVINGS" -> personList.add(new Savings(name, bankYear, initBal));
            case "FIXEDDEPOSIT" -> {
                if (initBal < 100000) {
                    System.err.println("Initial deposit must be at least 100,000$");
                    return;
                } else {
                    personList.add(new FixedDeposit(name, bankYear, initBal));
                }
            }
            default -> System.err.println("Wrong command.");
        }
        System.out.println(token[2] + " account for " + name + " created. Balance: " + initBal + "$");
        loginUser(name);
    }

    private void openUser(String name) {
        loginUser(name);
        System.out.print("Welcome back, " + name);
        if (currentUser instanceof Officer) {
            if (loanRequest) {
                System.out.print(". There are loan requests to approve.");
            }
        }
        System.out.print("\n");
    }

    private void loginUser(String name) {
        for (Object obj: personList) {
            Person person = (Person) obj;
            if (person.getName().equals(name)) {
                currentUser = person;
            }
        }
    }

    private void logoutUser() {
        Person person = (Person) currentUser;
        System.out.println("Operations for " + person.getName() + " closed.");
        currentUser = null;
    }

}