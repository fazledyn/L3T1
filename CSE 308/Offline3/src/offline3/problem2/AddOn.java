package offline3.problem2;

public abstract class AddOn implements FoodItem {

    protected FoodItem newItem;

    public AddOn(FoodItem newItem) {
        this.newItem = newItem;
    }

    public abstract int getPrice();
    public abstract String getName();

}
