package sec02.exam01;

public class Car {
//	String company = "현대자동차";
//	String model = "그랜저";
//	String color = "검정";
//	int maxSpeed = 350;
//	int speed ;
	
	Tire frontLeftTire = new HankookTire();
	Tire frontRigttTire = new HankookTire();
	Tire backLeftTire = new HankookTire();
	Tire backRigttTire = new HankookTire();
	
	void run() {
		frontLeftTire.roll(); 
		frontRigttTire.roll(); 
		backLeftTire.roll();
		backRigttTire.roll();
	}
}

