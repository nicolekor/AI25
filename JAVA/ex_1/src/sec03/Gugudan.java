package sec03;

public class Gugudan {
    public static void main(String[] args) {
        for (int i = 1; i <= 9; i++) {
            System.out.println(i + "단 출력:");
            for (int j = 1; j <= 9; j++) {
                System.out.println(i + " * " + j + " = " + (i * j));
            }
            System.out.println();
        }
    }
}
