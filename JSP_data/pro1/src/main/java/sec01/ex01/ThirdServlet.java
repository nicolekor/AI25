package sec01.ex01;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/third")
public class ThirdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void init(ServletConfig config) throws ServletException {
		System.out.println("ThirdServlet init 메소드 호출");
	}

	
	public void destroy() {
		System.out.println("ThirdServlet destory 메소드 호출");
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		System.out.println("ThirdServlet doGet 메소드 호출");
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

}
