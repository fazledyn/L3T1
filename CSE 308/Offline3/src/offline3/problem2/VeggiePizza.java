package offline3.problem2;

public class VeggiePizza implements FoodItem {

    @Override
    public int getPrice() {
        return 250;
    }

    @Override
    public String getName() {
        return "Veggie Pizza";
    }
}
