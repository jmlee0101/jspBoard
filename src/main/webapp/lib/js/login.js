/**
 * login.js
 */
 
 document.getElementById("loginform").addEventListener("submit", function(event) {
 	
 	const userId = document.querySelector("input[name='userId']");
 	const userPass = document.querySelector("input[name='userPass']").value.trim();
 	
 	if(!userId.value.trim()) {
 		event.preventDefault();
 		alert("아이디를 입력하세요.");
 		userId.focus();
 		return;
 	}
 	if(!userPass.value.trim()) {
 		event.preventDefault();
 		alert("비밀번호를 입력하세요.");
 		userPass.focus();
 		return;
 	}
 });