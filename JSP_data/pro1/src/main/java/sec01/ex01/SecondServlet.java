package sec01.ex01;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SecondServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("doGet 메서드 호출 >>>>>");
		super.doGet(req, resp);
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		System.out.println("destroy 메서드 호출 >>>>>");
		super.destroy();
	}

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("init 메서드 호출 >>>>>");
		super.init();
	}
	
	

}
