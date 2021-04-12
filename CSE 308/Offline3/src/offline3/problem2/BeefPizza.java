package offline3.problem2;

public class BeefPizza implements FoodItem {

    @Override
    public int getPrice() {
        return 300;
    }

    @Override
    public String getName() {
        return "Beef Pizza";
    }
}
