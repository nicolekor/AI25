//package sec02.exam02;
//// p151
//public class ForSumFrom1To100Example1 {
//    public static void main(String[] args) {
//        int sum = 0;  // 이 부분을 수정해야 합니다.
//
//        for (int i = 1; i <= 100; i++) {
//            sum += i;
//        }
//
//        System.out.println("1~100 의 합: " + sum);
//    }
//}



public class ForSumFrom1To100Example1 {
    public static void main(String[] args) {
        int sum = 0;

        // 1부터 10까지 반복
        for (int i = 1; i <= 10; i++) {
            // 홀수일 경우
            if (i % 2 != 0) {
                sum += i;  // 홀수를 합계에 더함
                System.out.println("홀수: " + i);  // 홀수 출력
            }
        }

        System.out.println("1~10 사이의 홀수 합: " + sum);
    }
}
