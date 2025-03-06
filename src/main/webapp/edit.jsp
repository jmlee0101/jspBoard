<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="include/header.jsp" %>

<jsp:useBean id="dao" class="jspboard.BoardDAO" scope="page" /> 
<c:set var="id" value="${param.id }" />
<c:if test="${empty id}">
  <script>
    alert("페이지를 여는데 문제가 발생했습니다.");
    location.href = "list.jsp";
  </script>
</c:if>
<c:set var="list" value="${ dao.getDetailBoard(id) }" />
<!-- 세션에서 USERID 가져오기 -->
<c:set var="userId" value="${sessionScope.loginUserId }"/>
<c:set var="userName" value="${ sessionScope.loginUserName }" />
<c:set var="isLoggedIn" value="${not empty userId }" />
<c:set var="isAdmin" value="${ userId eq 'admin' }"/>

<!-- onsubmit : form을 submit 할때 중지시키고 validateForm이라는 함수를 실행시킴 -->
<form name="writeform" action="editok" method="post" onsubmit="return validateForm();">
	<div class="row">
			<c:choose>
				<c:when test="${ isLoggedIn and (list.userId eq userId or isAdmin) }">
					<input type="hidden" name="pass" value="${ list.pass }"/>
				</c:when>
				<c:otherwise>
					<label class="col-1 mb-20">작성자</label>
			
					<input type="text" name="writer" class="col-3 form-control mb-20" value="${ list.writer }" readonly="readonly">
		
					<label class="col-1 offset-1 mb-20">비밀번호</label>
					<input type="password" name="pass" class="col-3 form-control mb-20" placeholder="비밀번호">
					<div class="col-3 mb-20"></div>
				</c:otherwise>
			</c:choose>
			
			
		
			<label class="col-1 mb-20">제목</label>
			<input type="text" name="title" class="form-control col-11 mb-20" value="${ list.title }">
			
			<label class="d-block col-1 mb-20">내용</label>
			<textarea name="content" class="form-control col-11 mb-20">${ list.content }</textarea>
			
			<div class="btn-box ">
				<button class="btn" type="reset">취소</button>
				<button class="btn" type="submit">저장</button>
			</div>
			<input type="hidden" name="id" value="${ list.id }"/>
	
	</div>
</form>




<script>
	function validateForm() {
		// 제목, 내용
		const title = document.writeform.title.value.trim();
		const content = document.writeform.content.value.trim();
		
		let isLoggedIn = ${isLoggedIn ? "true" : "false"};
		
		if(!isLoggedIn) {
			const writer = document.writeform.writer.value.trim();
			// const writer1 = document.writeform.writer1.value.trim();
			const pass = document.writeform.pass.value.trim();
			
			if(writer === "") {
				alert("작성자를 입력하세요.");
				document.writeform.writer.focus;
				return false;
			}
			if(pass === "") {
				alert("비밀번호를 입력하세요.");
				document.writeform.pass.focus;
				return false;
			}
		}
		
		if(title === "") {
			alert("제목을 입력하세요.");
			document.writeform.title.focus;
			return false;
		}

		if(content === "") {
			alert("내용을 입력하세요.");
			document.writeform.content.focus;
			return false;
		}
		
		return true;
	}
</script>

<%@ include file="include/footer.jsp"%>