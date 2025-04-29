package sec02.exam08;
//// p157
public class BreakExample {
//    public static void main(String[] args) {
//        while (true) {
//            int num = (int) (Math.random() * 6) + 1;
//            System.out.println(num);
//            if(num == 6) {
//                break;
//            }
//        }
//        System.out.println("프로그램 종료");
//    }
//}

    public static void main(String[] args) {
        int sum = 0;
        int i = 1;

        do {
            sum += i;
            i++;
        } while (i <= 10);
        System.out.println("1 부터 10까지 합은 : " + sum);
    }
}
