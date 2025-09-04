package sec01.exam04;
// input 파일을 출력하는 명령어

import java.io.FileInputStream;
import java.io.InputStream;

public class ReadExample {

	public static void main(String[] args) throws Exception {
		InputStream is = new FileInputStream("d:/temp/test1.db");
		while(true) {
			int data = is.read();
			if(data == -1) break;  // -1 의 의미: 전체 데이터 개수를 다 불러옴
			System.out.println(data);
		}
		
		is.close();

	}

}
