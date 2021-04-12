package offline3.problem2;

public class OnionRings extends AddOn {

    OnionRings(FoodItem newItem) {
        super(newItem);
    }

    @Override
    public int getPrice() {
        return newItem.getPrice() + 100;
    }

    @Override
    public String getName() {
        return newItem.getName() + ", Onion Rings";
    }
}
