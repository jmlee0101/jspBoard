<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%

	Integer loginId = null, loginUserAuth = null;
	String loginUserId = null;
	
	if(session != null) {
		loginId = (Integer) session.getAttribute("loginId");
		loginUserId = (String) session.getAttribute("loginUserId");
		loginUserAuth = (Integer) session.getAttribute("loginUserAuth");
		
	}
%> --%>

<c:set var="loginId" value="${ sessionScope.loginId }" />
<c:set var="loginUserId" value="${ sessionScope.loginUserId }" />
<c:set var="loginUserAuth" value="${ sessionScope.loginUserAuth }" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    
    <!-- 여러 경로에서 쓰이기 때문에 script와 css는 절대경로로 설정한다. -->
    <link rel="stylesheet" href="/jspBoard/lib/bootstrap/css/bootstrap-grid.css">
    <link rel="stylesheet" href="/jspBoard/lib/css/style.css">
    <link rel="stylesheet" href="/jspBoard/lib/css/detail.css">
    
</head>
<body>
    <div class="container pt-5">
    <h1 class="title">JSP BOARD</h1>
    <nav>
       <a href="/jspBoard/list.jsp">자유 게시판</a>
       <a href="#">회원 게시판</a>
       <c:choose>
			<c:when test="${ empty loginUserId }">
				<a href="/jspBoard/login.jsp">로그인</a>
          		<a href="/jspBoard/member/signup.jsp">회원가입</a>
			</c:when>
			<c:otherwise>
				<c:if test="${ loginUserAuth == 99 }">
					<a href="/jspBoard/member/memberList.jsp">회원관리</a> 
				</c:if>
				<a href="/jspBoard/logout.jsp">로그아웃</a>
			</c:otherwise>
       </c:choose>
       <%-- <% if(loginId == null){ %>
          <a href="/jspboard/login.jsp">로그인</a>
          <a href="/jspboard/member/signup.jsp">회원가입</a>
       <% } else {
             if(loginUserAuth == 99){   
       %>   
              <a href="/jspboard/member/memberList.jsp">회원관리</a> 
       <%
             }
       %>
          <a href="/jspboard/logout.jsp">로그아웃</a>
       <%         
          }    
       %> --%>
       
    </nav>
        <h1 class="text-center">자유게시판</h1>
        <p class="text-center mb-5 pb-5">jsp + servlet으로 디자인할 자유게시판입니다.</p>
	