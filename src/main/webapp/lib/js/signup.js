/******** signup 폼검증 *****************/
// document.getElementById("myform").addEventListener("submit", function(event){

let isValid = true;

function validateForm() {

	    let isValid = true;
	    //아이디 검증 (영문, 숫자 조합 3자 이상 10자이하)
	    const userid = document.getElementById("userId").value;
	    const useridReg = /^[a-zA-Z0-9]{3,10}$/;
	    
	    if(userid === "") {
	    	showError("userIdError", "(●'◡'●) 아이디를 입력하세요.");
	    }
	    if(!useridReg.test(userid)){
	       //검증실패
	      showError("userIdError", "(●'◡'●) 아이디는 영문, 숫자 조합 3~10자 이하여야 합니다."); 
	      isValid = false;
	    }else{
	        clearError("userIdError");
	    }
	//비밀번호 검증
	    const userPass = document.getElementById("userPass").value;
	//  const userpassReg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@%*?&])[A-Za-z\d@!%*?&]{6,10}/;
	
	   const userpassReg = /^.{6,10}$/;
	   
	   if(userPass === "") {
		showError("userPassError", "(●'◡'●) 비밀번호를 입력하세요.");
		}
	   
	   if(!userpassReg.test(userPass)){
      //검증실패
	      showError("userPassError","(●'◡'●) 대소문자,숫자,특수문자 포함 6-10자 이내여야합니다. ");
	      isValid = false;
	   }else{
	       clearError("userPassError");
	   }
		   //비밀번호 확인검증
		   
		   const reuserpass = document.getElementById("reuserPass").value;
		   
		   if(reuserpass === "") {
	    	showError("reuserPassError", "(●'◡'●) 비밀번호 확인을 입력하세요.");
	    	}
		   
		   if(userPass !== reuserpass){
		   showError("reuserPassError", "(●'◡'●) 비밀번호가 일치하지 않습니다.");
		   isValid = false;
		   
		   }else{
		   clearError("reuserPassError");
		   }
		   
		   //이름 검증
		   const username = document.getElementById("userName").value;
		   
		   if(username === "") {
	    	showError("userNameError", "(●'◡'●) 이름을 입력하세요.");
	    	}
		   
		   //이메일 검증
		   const useremail = document.getElementById("userEmail").value;
		   const useremailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-z]{2,3}$/i;
		   
		   if(useremail === "") {
	    	showError("userEmailError", "(●'◡'●) 이메일을 입력하세요.");
	    	}
		   
		   if(!useremailReg.test(useremail)){
		       //검증실패
		       showError("userEmailError","(●'◡'●) 이메일 형식이 올바르지 않습니다.");
		       isValid = false;
		    }else{
		        clearError("userEmailError");
		    }
		    
		    //전화번호 검증
		   const usertel = document.getElementById("userTel").value;
		   const usertelReg = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[-.\s]?[0-9]{3,4}[-.\s]?[0-9]{4}/;
		   
		   if(usertel === "") {
	    	showError("userTelError", "(●'◡'●) 전화번호를 입력하세요.");
	    	}
		   
		   if(!usertelReg.test(usertel)){
		       //검증실패
		       showError("userTelError","(●'◡'●) 전화번호 형식이 올바르지 않습니다.");
		       isValid = false;
		    }else{
		        clearError("userTelError");
		    }
	
		/*
		    if(!isValid){
		       event.preventDefault();
		    }   
		*/
		
			if(!isValid) {
				isValid = false;
			} else {
				document.getElementById("myform").submit();
			}
}	   
// });

document.addEventListener("DOMContentLoaded", function(e) {
	const inputFields = document.querySelectorAll("input");
	const useridInput = document.getElementById("userId");
	const useremailInput = document.getElementById("userEmail");
	
	useridInput.addEventListener("blur", function() {
		checkDup("userId", this.value);
	});
	
	useremailInput.addEventListener("blur", function() {
		checkDup("email", this.value);
	});
	
	inputFields.forEach(input => {
		input.addEventListener("focus", function(e) {
			const thisId = e.target.id;
			clearError(thisId + "Error");
		
		});
	
	});

});

//오류 메시지 출력
function showError(id, message){
   document.getElementById(id).textContent = message;
   document.getElementById(id).classList.add("input-error");
}

//오류 메시지 지움
function clearError(id) {
   document.getElementById(id).textContent = "";
   document.getElementById(id).classList.remove("input-error");  
}

function checkDup(field, value) {
	if(value.trim() === "") return false;
	
	let errorName = field == "userId" ? "userIdError" : "userEmailError";
	
	fetch("../checkdupl", {
		method: "POST",
		header: {
			"Content-Type" : "application/json"
		},
		body: JSON.stringify({ column : field, value : value})
	}).then(response => response.json())
	.then(data => {
		isDuplicate = JSON.parse(data.isDuplicate);
		if(isDuplicate) {
		console.log(data.isDuplicate);
			showError(errorName, value + "(은)는 이미 있는 이름입니다.");
			isValid = false;
		} else {
			clearError(errorName);
			isValid = true;
		}
	})
	;
}
























