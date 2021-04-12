package offline3.problem2;

public class Coke extends AddOn {

    public Coke(FoodItem newItem) {
        super(newItem);
    }

    @Override
    public int getPrice() {
        return newItem.getPrice() + 50;
    }

    @Override
    public String getName() {
        return newItem.getName() + ", Coke";
    }
}
