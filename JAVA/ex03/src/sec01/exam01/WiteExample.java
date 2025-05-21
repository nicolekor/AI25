// p596
// output이 파일을 입력하는 명령어

package sec01.exam01;

import java.io.FileOutputStream;
import java.io.OutputStream;

public class WiteExample {

	public static void main(String[] args) throws Exception {
		OutputStream os = new FileOutputStream("d:/temp/test1.db");
		
		byte a = 10;
		byte b = 20;
		byte c = 30;
		
		os.write(a);
		os.write(b);
		os.write(c);
		
		os.flush();
		os.close();

	}

}
