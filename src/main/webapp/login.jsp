<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>    
<%@ page import="java.text.SimpleDateFormat, jspboard.*" %>   
<%@ include file="include/header.jsp" %>

<%
	String error = request.getParameter("error");
	if(error != null) {
%>
	<script>
		alert("아이디 또는 비밀번호가 틀렸습니다.");
		location.href="login.jsp";
	</script>
<%
	}
%>

<section id="login">
<h2 class="text-center mb-20">회원 로그인</h2>
	<form name="loginform" id="loginform" action="loginok" method="post">
		<ul>
			<li><input type="text" name="userId" placeholder="아이디"/></li>
			<li><input type="password" name="userPass" placeholder="비밀번호"/></li>
			<li class="text-center">
				<button type="submit">로그인</button>
				<button type="reset">취소</button>
			</li>
		</ul>
	</form>
</section>

<script src="lib/js/login.js"></script>
<%@ include file="include/footer.jsp" %>