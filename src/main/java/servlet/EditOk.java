package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jspboard.BoardDAO;
import jspboard.BoardDTO;

@WebServlet("/editok")
public class EditOk extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = new BoardDTO();
		
		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String pass = request.getParameter("pass");
		
		dto.setId(id);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setPass(pass);
		
		int rs = dao.setUpdateBoard(dto);
		
		PrintWriter out = response.getWriter();
		String ok = "<script>alert('성공적으로 등록되었습니다.'); location.href='list.jsp';</script>";
		String err = "<script>alert('비밀번호가 틀리거나 에러가 발생했습니다. 다시 시도하세요.'); location.href='list.jsp';</script>";
		
		if(rs > 0) {
			// 글쓰기 성공
			out.print(ok);
		} else {
			// 글쓰기 실패
			out.print(err);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
