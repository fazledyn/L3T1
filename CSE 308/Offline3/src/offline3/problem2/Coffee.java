package offline3.problem2;

public class Coffee extends AddOn {

    public Coffee(FoodItem newItem) {
        super(newItem);
    }

    @Override
    public int getPrice() {
        return newItem.getPrice() + 80;
    }

    @Override
    public String getName() {
        return newItem.getName() + ", Coffee";
    }
}
