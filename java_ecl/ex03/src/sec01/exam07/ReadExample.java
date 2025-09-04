package sec01.exam07;
// p609
import java.io.FileReader;
import java.io.Reader;

public class ReadExample {

	public static void main(String[] args) throws Exception {
		Reader reader = new FileReader("d:/temp/test7.txt");
		while(true) {
			int data = reader.read();
			if(data == -1) break;  // -1 의 의미: 전체 데이터 개수를 다 불러옴
			
			System.out.print((char)data + " ");
			
//			System.out.println((char)data);
		}
		
		reader.close();

	}

}
