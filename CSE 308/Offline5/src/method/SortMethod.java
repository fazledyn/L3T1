package method;

public class SortMethod implements Method {

    @Override
    public int[] run(int[] list) {

        int[] newList = new int[list.length];
        System.arraycopy(list, 0, newList, 0, list.length);

        for (int i = 0; i < newList.length - 1; i++) {
            for (int j = 0; j < newList.length - i - 1; j++) {
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
