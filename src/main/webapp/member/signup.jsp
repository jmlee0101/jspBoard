<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>   

          <form class="myform" id="myform" action="../signupok" name="signup" method="post">
           <ul>
              <li>
                 <label class="col-2">아이디</label>
                 <div class="col-3">
                    <input type="text" 
                           name="userId" 
                           id="userId"
                           class="form-control" 
                           placeholder="아이디" />
                 </div>
                 <div class="col-7">
                    <span class="red" id="userIdError">영문,숫자 조합 3~10자</span>
                 </div>
              </li>
              <li>
                <label class="col-2">비밀번호</label>
                <div class="col-3">
                   <input type="password" 
                          name="userPass" 
                          id="userPass"
                          class="form-control" 
                          placeholder="비밀번호" />
                </div>
                <div class="col-7">
                    <span class="red" id="userPassError">대소문자+숫자+특수문자 포함 6~10자</span>
                 </div>
             </li>
             <li>
                <label class="col-2">비밀번호확인</label>
                <div class="col-3">
                   <input type="password" 
                          name="reuserPass" 
                          id="reuserPass"
                          class="form-control" 
                          placeholder="비밀번호 확인" />
                </div>
                <div class="col-7">
                   <span class="red" id="reuserPassError"></span>
                </div>
             </li>
             <li>
                <label class="col-2">이름</label>
                <div class="col-3">
                   <input type="text" 
                          name="userName" 
                          id="userName"
                          class="form-control" 
                          placeholder="이름" />
                </div>
                <div class="col-7">
                   <span class="red" id="userNameError"></span>
                </div>
             </li>
             <li>
                <label class="col-2">이메일</label>
                <div class="col-4">
                   <input type="text" 
                          name="userEmail" 
                          id="userEmail"
                          class="form-control" 
                          placeholder="이메일" />
                </div>
                <div class="col-6"><span class="red" id="userEmailError"></span></div>
             </li>
             <li>
                <label class="col-2">전화번호</label>
                <div class="col-4">
                   <input type="text" 
                          name="userTel" 
                          id="userTel"
                          class="form-control" 
                          placeholder="전화번호" />
                </div>
                <div class="col-6"><span class="red" id="userTelError"></span></div>
             </li>
           </ul> 
           <div class="text-center pt-4 pb-3">
               <button type="reset">취소</button>
               <button type="button" onclick="validateForm();">전송</button>
           </div>
        </form>
    
<script src="../lib/js/signup.js"></script>
<%@ include file="../include/footer.jsp" %>  