package sec03.ex04;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/logintest")
public class LoginTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");   
	      response.setContentType("text/html;charset=utf-8");  
	      PrintWriter out = response.getWriter();				
	      String id = request.getParameter("user_id");  
	      String pw = request.getParameter("user_pw");  
			
	      System.out.println("아이디   : "+ id);  
	      System.out.println("패스워드 : "+ pw);
		
	     if(id!= null &&(id.length()!=0)){
			out.print("<html>");  
			out.print("<body>");
			out.print( id +" 님!! 로그인 하셨습니다." );
			out.print("</html>");
			out.print("</body>");
	      }else{
			out.print("<html>");  
			out.print("<body>");
			out.print("아이디를 입력하세요!!!" ) ;
			out.print("<br>");
			out.print("<a href='http://localhost/pro03/login.html'>로그인창으로 이동  </a>");
			out.print("</html>");
			out.print("</body>");
	      
	   }

	}

}
