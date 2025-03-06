<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="include/header.jsp" %>

<c:set var="userId" value="${sessionScope.loginUserId }"/>
<c:set var="userName" value="${ sessionScope.loginUserName }" />
<c:set var="isAdmin" value="${ userId eq 'admin' }" />

<c:if test="${ empty param.id }">
	<script>
	alert("Error");
	</script>
</c:if>

<jsp:useBean id="dao" class="jspboard.BoardDAO" scope="page" />
<c:set var="dto" value="${dao.getDetailBoard(param.id) }" />
<c:set var="postOwner" value="${ userId eq dto.userId }" />

<div class="delbox">
	<h3 class="text-center mt-30 mb-30">삭제를 하려면 비밀번호를 입력하세요.</h3>
	<div>
		<input type="password" name="pass" id="pass" class="form-control" placeholder="비밀번호" />
	</div>
	<div class="btn-box">
	<input type="hidden" name="id" id="postId" value="${ param.id }"/>
		<button type="button" class="reset btn"> 취소 </button>
		<button type="button" class="btn" id="delBtn"> 전송 </button>
		<!-- <button type="button" class="submit btn" onclick="confirmDel();"> 확인 </button> -->
	</div>

</div>


<script>
document.addEventListener("DOMContentLoaded", function(){
   const delBtn = document.getElementById("delBtn");
   const postId = document.getElementById("postId").value;
   const passInput= document.getElementById("pass");

   const isAdmin = ${isAdmin}; //관리자 여부 확인
   const isOwner = ${postOwner}; //글 주인 여부 확인
   if(isAdmin || isOwner){
     //관리자 또는 글 주인일 경우 다시 물어본후 삭제 진행
		if(confirm("삭제하시겠습니까?")) {
			formAction(postId, '${dto.pass}');
		}
   }
   
   delBtn.addEventListener("click", function(){
     const pass = passInput.value; 
     if(!pass){
           alert("비밀번호를 입력하세요.");
           passInput.focus();
           return;
      }
     alert("글삭제로 보냄");
     
     if(confirm("정말로 삭제하시겠습니까?")) {
			formAction(postId, '${dto.pass}');
	}
   });
});

function formAction(postId, pass) {
	   const form = document.createElement("form");
	   form.method="POST";
	   form.action="delok";
	   
	   const idInput = document.createElement("input");
	   const passInput = document.createElement("input");
	    idInput.type="hidden";
	    idInput.name="id";
	    idInput.value=postId;
	    passInput.type="hidden";
	    passInput.name="pass";
	    passInput.value=pass;
	    
	    form.appendChild(idInput);
	    form.appendChild(passInput);
	    document.body.appendChild(form);
	    form.submit();
}

/* function confirmDel() {
	const form = document.createElement("form");
	form.method = "POST";
	form.action = "delok";
	
	const idInput = document.createElement("input");
	const passInput = document.createElement("input");
	idInput.type = "hidden";
	idInput.name = "id";
	idInput.value = postId;
	
	passInput.type = "hidden";
	passInput.name = "pass";
	passInput.value = "pass";
	
	form.appendChild(idInput);
	form.appendChild(passInput);
	document.body.appendChild(form);
	
	form.submit();
} */
	
/* 	const pass = document.getElementById("pass").value;
	
	if(confirm("삭제하시겠습니까?")) {
		location.href="/jspBoard/delBoard?id=${param.id}&pass=" + pass;
	} */
</script>
<%@ include file="include/footer.jsp"%>