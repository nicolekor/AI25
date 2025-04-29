// p81

package sec03.exam05;

public class OperationsPromotionExample {
    public static void main(String[] args) {
        byte byteValue1 = 10;
        byte byteValue2 = 20;

        int intValue1 = byteValue1 + byteValue2;
        System.out.println(intValue1);

        char charVal1 = 'A';
        char charVal2 = 1;
        int intVal2 = charVal1 + charVal2;
        System.out.println("유니코드=" + intVal2);
        System.out.println("출력문자=" + (char)intVal2);

        int intValue3 = 10;
        int intValue4 = intValue3/4;
        // int는 정수라고 소숫점 이하를 날려버림
        System.out.println(intValue4);

        int intValue5 = 10;
        double doubleValue = intValue5 / 4.0;
        System.out.println(doubleValue);

        int x = 1;
        int y = 2;
        double result = (double) x/y;
        System.out.println(result);

        int i = 10;
        int j = 4;
        int intSum = i / j;
        System.out.println(intSum);

        double doubleSum = (double) i/j;
        System.out.println(doubleSum);
    }
}


