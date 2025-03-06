package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jspboard.BoardDAO;


@WebServlet("/delok")
public class DelOk extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		BoardDAO dao = new BoardDAO();
		
		int id = Integer.parseInt(request.getParameter("id"));
		String pass = request.getParameter("pass");
		
		int rs = dao.delBoard(id, pass);
		PrintWriter out = response.getWriter();
		String ok = "<script>alert('성공적으로 삭제되었습니다.');location.href='list.jsp';</script>";
		String err = "<script>alert('비밀번호가 틀리거나 에러가 발생했습니다. 다시 시도하세요.');history.go(-1);</script>";
		if(rs >0) {
			//삭제 성공
			out.print(ok);
		}else {
			//삭제 실패
			out.print(err);
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
