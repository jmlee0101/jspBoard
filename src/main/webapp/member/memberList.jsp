<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@ page import=" java.sql.*, java.util.*, java.text.*, jspboard.* " %> --%>
<%@ include file="../include/header.jsp" %>

<%-- <%
   //세션 권환 확인
  // String userId = (String) session.getAttribute("loginUserId");

   if(loginUserId == null || loginUserAuth != 99){
	   
 %> --%>
 
<c:set var="loginUesrId" value="${sessionScope.loginUesrId }" />
<c:set var="loginUserAuth" value="${sessionScope.loginUserAuth }" />
 
 <c:if test="${ empty loginUserId or loginUserAuth ne 99 }">
    <script>
     alert("페이지를 볼 수 있는 권한이 없습니다.");
     location.href="../login.jsp";
    </script> 
 </c:if>
 
 <c:set var="pg" value="${ empty param.pg ? 1 : param.pg }" />
 
 <jsp:useBean id="dao" class="jspboard.BoardDAO" scope="page" />
 <c:set var="mList" value="${dao.getMemberList(pg, 5)}" />
 
 <%-- <%  
     return;
   }


	int pg = 1;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	String pgParam = request.getParameter("pg");
	try{
	   if(pgParam != null && !pgParam.trim().isEmpty()){
	       pg = Integer.parseInt(pgParam);
	   }   
	}catch(NumberFormatException e){
	   pg = 1;
	}
	
	// DAO 객체 생성
	BoardDAO dao = new BoardDAO();

	// DAO 객체 생성
	List<MembersDTO> mList = dao.getMemberList(pg, 10);
	
	/* Connection conn = DriverManager.getConnection(url, userId, pass);

	String sql = "SELECT * FROM MEMBERS ORDER BY ID DESC LIMIT ?, ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, min);
	pstmt.setInt(2, 2);
	ResultSet rs = pstmt.executeQuery(); */
	/* Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(sql); */
	
%> --%>
<h1 class="text-center">${ loginUserId }  님, 환영합니다.</h1>
<table class="list-table">
            <colgroup>
                <col width="5%">
                <col width="15%">
                <col width="10%">
                <col width="15%">
                <col width="15%">
                <col width="15%">
                <col width="15%">
                <col width="10%">
            </colgroup>
            <thead>
                <tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>가입일</th>
					<th>수정일</th>
					<th>권한</th>
                </tr>
            </thead>
            <tbody>
	            <c:choose>
	            	<c:when test="${ empty mList }">
	            		<tr><td colspan="8" class="test-center">회원정보가 없습니다.</td></tr>
	            	</c:when>
	            	<c:otherwise>
		            	<c:forEach var="data" items="${ mList }" varStatus="status">
		            		<tr>
							<td>${ data.id }</td>
							<td>${ data.userId}</td>
							<td>${data.name}</td>
							<td>${data.email}</td>
							<td>${data.tel}</td>
							<td><fmt:formatDate value="${ data.regdate }" pattern="yyyy.MM.dd"/></td>
							<td><fmt:formatDate value="${ data.modate }" pattern="yyyy.MM.dd"/></td>
							<td>
								<c:choose>
									<c:when test="${ data.auth eq 1 }">일반회원</c:when>
									<c:when test="${ data.auth eq 2 }">VIP회원</c:when>
									<c:when test="${ data.auth eq 99 }">관리자</c:when>
									<c:otherwise>탈퇴회원</c:otherwise>
								</c:choose>
							</td>
						</tr>
		            	</c:forEach>
	            		
	            	</c:otherwise>
	            </c:choose>

            </tbody>
        </table>
	
<%@ include file="../include/footer.jsp" %>