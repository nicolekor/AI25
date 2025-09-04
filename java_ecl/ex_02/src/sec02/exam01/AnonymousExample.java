package sec02.exam01;

public class AnonymousExample {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Anonymous anony = new Anonymous();
		
		anony.field.wake();
		anony.method1();
		anony.method2(
				new Person() {
					void study() {
						System.out.println("공부함");
					}
					@Override
					void wake() {
						System.out.println("8시에 일어남");
						study();
					}
				}
			);
	}
}
