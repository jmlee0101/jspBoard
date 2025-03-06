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

@WebServlet("/writeok")
public class WriteOk extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // 한글이 깨지지 않게 캐릭터 세팅
		response.setContentType("text/html; charset=utf-8");
		
		// 폼에서 전달되는 파라미터 받기
		String writer = request.getParameter("writer");
		String userId = request.getParameter("userId");
		String pass = request.getParameter("pass");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		BoardDTO dto = new BoardDTO();
		
		dto.setWriter(writer);
		dto.setUserId(userId);
		dto.setPass(pass);
		dto.setTitle(title);
		dto.setContent(content);
		
		BoardDAO dao = new BoardDAO();
		int result = dao.setWriteBoard(dto);
		
		PrintWriter out = response.getWriter();
		String ok = "<script>alert('성공적으로 등록되었습니다.'); location.href='list.jsp';</script>";
		String err = "<script>alert('에러가 발생했습니다. 다시 시도하세요.'); location.href='list.jsp';</script>";
		
		if(result > 0) {
			// 글쓰기 성공
			out.print(ok);
		} else {
			// 글쓰기 실패
			out.print(err);
		}
	}

}
