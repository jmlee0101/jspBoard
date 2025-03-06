<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="include/header.jsp" %>

<!-- 세션에서 USERID 가져오기 -->
<c:set var="userId" value="${sessionScope.loginUserId }"/>
<c:set var="userName" value="${ sessionScope.loginUserName }" />
<c:set var="isLoggedIn" value="${not empty userId }" />

<!-- onsubmit : form을 submit 할때 중지시키고 validateForm이라는 함수를 실행시킴 -->
<form name="writeform" action="writeok" method="post" onsubmit="return validateForm();">
	<div class="row">
			<c:choose>
				<c:when test="${ isLoggedIn }">
					<input type="hidden" name="writer" value="${userId }"/>
					<input type="hidden" name="userId" value="${userName }"/>
					<input type="hidden" name="pass" value="1111"/>
				</c:when>
				<c:otherwise>
					<label class="col-1 mb-20">작성자</label>
			
					<input type="text" name="writer" class="col-3 form-control mb-20" placeholder="작성자">
		
					<label class="col-1 offset-1 mb-20">비밀번호</label>
					<input type="password" name="pass" class="col-3 form-control mb-20" placeholder="비밀번호">
					<input type="hidden" name="userId" value="guest">
					<div class="col-3 mb-20"></div>
				</c:otherwise>
			</c:choose>
			
			
		
			<label class="col-1 mb-20">제목</label>
			<input type="text" name="title" class="form-control col-11 mb-20" placeholder="제목">
			
			<label class="d-block col-1 mb-20">내용</label>
			<textarea name="content" class="form-control col-11 mb-20"></textarea>
			
			<div class="btn-box ">
				<button class="btn" type="reset">취소</button>
				<button class="btn" type="submit">저장</button>
			</div>
	
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