package sec02.exam01;

public class CarExample {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Car myCar = new Car();
		
		myCar.run();
		
		myCar.frontLeftTire = new KumhoTire();
		myCar.frontRigttTire = new KumhoTire();
		
		myCar.run();
	
		
//		System.out.println("제작회사: "  + myCar.company);
//		System.out.println("모델명: "  + myCar.model);
//		System.out.println("색깔: "  + myCar.color);
//		System.out.println("최고속도: "  + myCar.maxSpeed);
//		System.out.println("현재속도: "  + myCar.speed);
//		
//		myCar.speed = 60;
//		System.out.println("수정된 속도: " + myCar.speed);

	}

}
