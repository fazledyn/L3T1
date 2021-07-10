package method;

public class FaultySortMethod implements Method {

    @Override
    public int[] run(int[] list) {

        int[] newList = new int[list.length];
        System.arraycopy(list, 0, newList, 0, list.length);

        for (int i = 2; i < newList.length - 1; i++) {
            for (int j = 2; j < newList.length - i - 1; j++) {
                if (newList[j] > newList[j + 1]) {
                    int temp;
                    temp = newList[j];
                    newList[j] = newList[j + 1];
                    newList[j + 1] = temp;
                }
            }
        }
        return newList;
    }

}