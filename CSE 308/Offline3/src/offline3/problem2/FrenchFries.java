package offline3.problem2;

public class FrenchFries extends AddOn {

    public FrenchFries(FoodItem newItem) {
        super(newItem);
    }

    @Override
    public int getPrice() {
        return newItem.getPrice() + 100;
    }

    @Override
    public String getName() {
        return newItem.getName() + ", French Fries";
    }


}
