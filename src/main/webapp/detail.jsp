<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ include file="include/header.jsp" %>
<%
   //치환 변수 선언
    pageContext.setAttribute("cr", "\r"); //Space
    pageContext.setAttribute("cn", "\n"); //Enter
    pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
    pageContext.setAttribute("br", "<br/>"); //br 태그
%> 

<jsp:useBean id="dao" class="jspboard.BoardDAO" scope="page" /> 
<c:set var="id" value="${param.id }" />
<c:if test="${empty id}">
  <script>
    alert("페이지를 여는데 문제가 발생했습니다.");
    location.href="list.jsp";
  </script>
</c:if>
<c:set var="list" value="${ dao.getDetailBoard(id) }" />


<!-- <form name="delform" id="delform" action="delBoard" method="post"> -->
	<div class="detail-title">
	   ${ list.title }
	</div>
	
	<div class="row detail">
	   <div class="col-6">
	      <label>글쓴이</label>
	      <span>${ list.writer }</span>
	   </div>
	   <div class="col-6">
	      <label>등록일</label>
	      <span>
	        <fmt:formatDate value="${ list.wDate }" type="both" dateStyle="long" timeStyle="medium" />
	      </span> 
	   </div>
	 </div>
	 
	 <div class="row detail">  
	   <div class="col-12">
	      <label>조회수</label>
	      <span>${ list.hit }</span>
	   </div>
	</div>
	
	<div class="detail-content">
		<c:out value="${fn:replace(list.content, cn, br)}" escapeXml="false"/>
	</div>
	<div class="btn-group">
	    <a href="list.jsp" class="btn">목록</a>
	    <a href="edit.jsp?id=${ list.id }" class="btn">수정</a>
	    <a href="delete.jsp?id=${ list.id }" class="btn">삭제</a>
<!-- 	    <a href="#" class="btn" onclick="doDelete();">삭제</a> -->
	</div>
<!-- </form> -->
<!-- delete.jsp?id=${ list.id }  -->
<script>
function doDelete(){
	const loginUserId = '${loginUserId}';
	const writerId = '${list.writer}';
	const frm = document.forms[0];
	
	if(loginUserId == null || loginUserId != writerId) {
		location.href="delete.jsp?id=${ list.id }";
	} else if(loginUserId == writerId || loginUserId == "admin") {
		if(confirm("삭제하시겠습니까?")) {
			frm.method = "POST";
			frm.action = "delok";
			frm.submit();
		}
	}
}
</script>
<%@ include file="include/footer.jsp"%>