 package servlet;
 
 import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import jspboard.BoardDAO;
 
 
 
 @WebServlet({"/checkdupl"})
 public class CheckDuplicateServlet
   extends HttpServlet
 {
   private static final long serialVersionUID = 1L;
   private BoardDAO dao = new BoardDAO();
   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     request.setCharacterEncoding("UTF-8");
     response.setContentType("application/json; charset=utf-8");
 
     
     BufferedReader reader = request.getReader();
     StringBuilder jsonData = new StringBuilder();
     
     String line;
     while ((line = reader.readLine()) != null) {
       jsonData.append(line);
     }
 
     
     try {
       JSONObject jsonObj = new JSONObject(jsonData.toString());
       
       String value = jsonObj.getString("value");
       String column = jsonObj.getString("column");
       boolean isDuplicate = false;
       
       if (value != null && column != null) {
         isDuplicate = this.dao.isUserIdOrEmailExists(column, value);
       }
 
       
       PrintWriter out = response.getWriter();
       out.print("{\"isDuplicate\" : \"" + isDuplicate + "\"}");
       out.flush();
       out.close();
     }
     catch (Exception e) {
       e.printStackTrace();
     } 
   }
 
 
 
 
   
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     doGet(request, response);
   }
 }

