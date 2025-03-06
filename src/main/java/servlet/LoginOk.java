 package servlet;
 
 import java.io.IOException;
 import javax.servlet.ServletException;
 import javax.servlet.annotation.WebServlet;
 import javax.servlet.http.HttpServlet;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpServletResponse;
 import javax.servlet.http.HttpSession;
 import jspboard.BoardDAO;
 import jspboard.MembersDTO;
 
 
 @WebServlet({"/loginok"})
 public class LoginOk
   extends HttpServlet
 {
   private static final long serialVersionUID = 1L;
   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     String userId = request.getParameter("userId");
     String userPass = request.getParameter("userPass");
     
     BoardDAO dao = new BoardDAO();
     MembersDTO memDTO = dao.checkMember(userId, userPass);
     
     if (memDTO.getId() == 0) {
       response.sendRedirect("login.jsp?error=1");
     } else {
       HttpSession session = request.getSession();
       
       session.setAttribute("loginId", Integer.valueOf(memDTO.getId()));
       session.setAttribute("loginUserId", memDTO.getUserId());
       session.setAttribute("loginUserAuth", Integer.valueOf(memDTO.getAuth()));
       session.setAttribute("loginUserName", memDTO.getName());
       
       if (memDTO.getAuth() == 99) {
         response.sendRedirect("member/memberList.jsp");
       } else {
         response.sendRedirect("index.jsp");
       } 
     } 
   }
   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     doGet(request, response);
   }
 }

