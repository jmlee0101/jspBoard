<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
	<body>
		전체게시글: 123
		<%
			int currentPage = Integer.parseInt(request.getParameter("pg"));
			int totalPosts = 123;
			int postPerPages = 10;
			int totalPages = (int) Math.ceil((double)totalPosts/postPerPages); // 올림
			int pagesPerBlock = 10; // 총 페이지를 10개 단위로 묶음
			// 총 몇 페이지가 나오는가?
					
					out.println("총 게시글 수 : " + totalPosts + " / " + totalPages + " pages <br><br><br>");
			
			// pg 1 ~ 10 시작페이지 1
			// pg 11 ~ 20 시작페이지 11
			int startPage  = ((currentPage-1)/pagesPerBlock) * pagesPerBlock + 1;
			int endPage = startPage + pagesPerBlock - 1;
			
		%>
		
		<a href="test.jsp?pg=<%= startPage - 1 %>"><</a>
		<%
			for(int i = startPage; i <= endPage; i++) {
		%>
			<a href="test.jsp?pg=<%= i %>"><%= i %></a>&nbsp;&nbsp;&nbsp;&nbsp;
		<%
			}
		%>
		<a href="test.jsp?pg=<%= endPage + 1 %>">></a>			
	</body>
</html>