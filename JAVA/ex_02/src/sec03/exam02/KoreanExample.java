package sec03.exam02;

public class KoreanExample {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Korean k1 = new Korean("빅자바", "011225-1234567");
		System.out.println("k1.name : " + k1.name);
		System.out.println("k1.ssn : " + k1.ssn);
		
		Korean k2 = new Korean("김자바", "930525-0654321");
		System.out.println("k2.name : " + k2.name);
		System.out.println("k3.ssn : " + k2.ssn);
		
		Korean k3 = new Korean("김ㅁㅁ", "123456-1234567");
		System.out.println("k3.name : " + k3.name);
		System.out.println("k3.ssn : " + k3.ssn);
		
		

	}

}
