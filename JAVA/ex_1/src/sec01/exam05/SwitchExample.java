package sec01.exam05;
// p142 주사위 프로그램
public class SwitchExample {
    public static void main(String[] args) {
        int num = (int) (Math.random() * 6) + 1;
        // math.random 은 0~ 5 까지만 나오니까 1~ 6이 나오개 하려고 +1 함

        switch (num) {
            case 1:
                System.out.println("1번이 나옴");
                break;
            case 2:
                System.out.println("2번이 나옴");
                break;
            case 3:
                System.out.println("3번이 나옴");
                break;
            case 4:
                System.out.println("4번이 나옴");
                break;
            case 5:
                System.out.println("5번이 나옴");
                break;
            default:
                System.out.println("6번이 나옴");
                break;
                // default 는 break 생략해도 됌
        }
    }
}
