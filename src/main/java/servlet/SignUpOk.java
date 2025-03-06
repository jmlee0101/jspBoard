 package servlet;
 
 import java.io.IOException;
 import java.io.PrintWriter;
 import javax.servlet.ServletException;
 import javax.servlet.annotation.WebServlet;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import jspboard.BoardDAO;
 import jspboard.MembersDTO;
 
 
 @WebServlet({"/signupok"})
 public class SignUpOk
   extends HttpServlet
 {
   private static final long serialVersionUID = 1L;
   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     response.setContentType("text/html; charset=utf-8");
     request.setCharacterEncoding("utf-8");
     MembersDTO dto = new MembersDTO();
     BoardDAO dao = new BoardDAO();
     PrintWriter out = response.getWriter();
     
     String userId = request.getParameter("userId");
     String userPass = request.getParameter("userPass");
     String userName = request.getParameter("userName");
     String userEmail = request.getParameter("userEmail");
     String userTel = request.getParameter("userTel");
     
     dto.setUserId(userId);
     dto.setPasswd(userPass);
     dto.setName(userName);
     dto.setEmail(userEmail);
     dto.setTel(userTel);
     
     String txtok = "<script>alert('성공적으로 등록되었습니다.');location.href='/jspBoard/login.jsp';</script>";
     String txterr = "<script>alert('회원가입에 실패했습니다.다시 시도하세요.');location.href='/jspBoard.signup.jsp'></script>";
     boolean rs = dao.insertMember(dto);
     
     if (rs) { out.print(txtok); }
     else { out.print(txterr); }
   
   }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     doGet(request, response);
   }
 }

